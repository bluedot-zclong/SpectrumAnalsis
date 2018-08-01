package bluedot.spectrum.web.core;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import bluedot.spectrum.web.core.ajax.AjaxResultHander;
import bluedot.spectrum.web.core.utils.GetClassFromPackage;
import bluedot.spectrum.web.core.utils.Result;
import jxau.spectrum.frame.web.annotation.Autowired;
import jxau.spectrum.frame.web.annotation.Controller;
import jxau.spectrum.frame.web.annotation.DevMode;
import jxau.spectrum.frame.web.annotation.RequestMapping;
import jxau.spectrum.frame.web.annotation.RequestParam;
import jxau.spectrum.frame.web.annotation.Service;
import jxau.spectrum.frame.web.annotation.Token;


@SuppressWarnings("serial")
@MultipartConfig // 标识Servlet支持文件上传
public class DispatcherServlet extends HttpServlet {
	private static final Logger LOGGER = LogManager.getLogger(DispatcherServlet.class);
	private Properties properties = new Properties();
	private List<String> classNames = new ArrayList<String>();
	private Map<String, Object> ioc = new HashMap<String, Object>();
	private List<Handler> handlerMaping = new ArrayList<Handler>();
	private static Boolean devMode = false; 

	@Override
	public void init(ServletConfig config) throws ServletException {
		// 初始化加载配置文件
		String path = config.getInitParameter("contextConfigLocation");
		// 1、加载配置文件application.properties代替xml
		doLoadConfig(path);
		// 2、扫描所有相关的类,拿到基础包路径，递归扫描
		String controllerPackage = properties.getProperty("controllerPackage");
		String servicePackage = properties.getProperty("servicePackage");
		if ("true".equalsIgnoreCase(properties.getProperty("dev"))) {
			devMode = true;
		}
		doScanner(controllerPackage);
		doScanner(servicePackage);
		// 3、把扫描的所有的类实例化，放到IOC容器中（自实现，实际是一个Map,key是bean的id(类名)，value是bean的实例）
		doInstance();
		// 4、检查注入，只要加了@Autowired注解的子段，属性，不管他是私有的还是共有的，还是受保护的都要给他强制赋值
		doAutowired();
		// 5、获取用户的请求，根据所请求的URL去找到对应的Method，通过反射机制去调用HandlerMapping，把这样一个关系存放到HandlerMapping中去（map）
		initHandlerMapping();
		// 6、等待请求，吧反射调用结果通过response写到浏览器中
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		this.doPost(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			doDispatch(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void doDispatch(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String url = req.getRequestURI();
		if(url.indexOf(".") != -1) {
			url = url.substring(0, url.lastIndexOf("."));
		}
		String contextPath = req.getContextPath();
		url = url.replace(contextPath, "/").replaceAll("/+", "/");
		System.out.println(url);

		Handler handler = getHandler(req);
		if (handler == null) {
			// 如果没有匹配上
			resp.getWriter().write("404 Not Found");
			return;
		}
		
		// 判断是否重复提交
//		preHandle(req, resp, handler);
		
		// 获取方法的参数列表
		Class<?>[] paramTypes = handler.method.getParameterTypes();

		// 保存所有需要赋值的参数
		Object[] paramValues = new Object[paramTypes.length];

		// 首先通过获取request的参数列表
		// 获取自定义的方法的参数列表
		Map<String, String[]> params = req.getParameterMap();
		for (Entry<String, String[]> param : params.entrySet()) {
			String value = Arrays.toString(param.getValue()).replaceAll("\\[|\\]", "").replaceAll(",\\s", ",");
			// 如果找到匹配的对象，则开始填充参数值
			if (!handler.paramIndexMapping.containsKey(param.getKey())) {
				continue;
			}
			int index = handler.paramIndexMapping.get(param.getKey());
			paramValues[index] = convert(paramTypes[index], value);
		}

		// 设置方法中的request和response对象
		if(handler.paramIndexMapping.get(HttpServletRequest.class.getName()) != null) {
			int reqIndex = handler.paramIndexMapping.get(HttpServletRequest.class.getName());
			paramValues[reqIndex] = req;
		}
		if(handler.paramIndexMapping.get(HttpServletResponse.class.getName()) != null) {
			int respIndex = handler.paramIndexMapping.get(HttpServletResponse.class.getName());
			paramValues[respIndex] = resp;
		}

		
		// System.out.println("成功获取到即将要调用的Method : " + method);
		// handler.method.invoke(handler.controller, paramValues);
		Object obj = handler.method.invoke(handler.controller, paramValues);
		if (null != obj) {
			// 结果处理
			handleResult(req, resp, obj);
		}
		return;
	}

	private Handler getHandler(HttpServletRequest req) throws Exception {
		if (handlerMaping.isEmpty()) {
			return null;
		}
		String url = req.getRequestURI();
		if(url.indexOf(".") != -1) {
			url = url.substring(0, url.lastIndexOf("."));
		}
		String contextPath = req.getContextPath();
		url = url.replace(contextPath, "").replaceAll("/+", "/");
		for (Handler handler : handlerMaping) {
			try {
				// Matcher matcher = handler.pattern.matcher(url);
				String pattern = handler.pattern.pattern();
				Boolean flag = PatternMatchUtils.simpleMatch(pattern, url);
				if (!flag) {
					continue;
				}
				// 如果没有匹配上继续下一个匹配、
				/*
				 * if (!matcher.matches()) { continue; }
				 */
				return handler;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	private void doLoadConfig(String path) {
		InputStream is = this.getClass().getClassLoader().getResourceAsStream(path);

		try {
			properties.load(is);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	private void doScanner(String controllerPackage) {
		URL url = this.getClass().getClassLoader().getResource("/" + controllerPackage.replaceAll("\\.", "/"));
		// 得到协议的名称
		String protocol = url.getProtocol();
		if("file".equals(protocol)) {
			File dir = new File(url.getFile());
			for (File file : dir.listFiles()) {
				// 如果有子包，继续扫描，否则将类路径添加到集合中
				if (file.isDirectory()) {
					doScanner(controllerPackage + "." + file.getName());
				} else {
					classNames.add(controllerPackage + "." + file.getName().replace(".class", ""));
				}
			}
		}else if ("jar".equals(protocol)) {
			GetClassFromPackage.getClasssFromJarFile(url, classNames, controllerPackage);
		}
	}

	private void doInstance() {
		if (classNames.isEmpty()) {
			return;
		}
		try {
			for (String className : classNames) {
				Class<?> clazz = Class.forName(className);

				// 不是所有的类都要初始化的，加了Control而注解的才进行初始化
				if (clazz.isAnnotationPresent(Controller.class)) {
					// <bean id="" name="" class="">
					String beanName = lowerFirst(clazz.getSimpleName());
					ioc.put(beanName, clazz.newInstance());
				} else if (clazz.isAnnotationPresent(Service.class)) {
					// 1、如果自己起了名字，优先使用自己的名字进行匹配并注入
					// 2、默认首字母小写(发生在不是接口的情况)
					// 3、如果注入的类型是接口，自动找到其实现类的实例并注入
					Service service = clazz.getAnnotation(Service.class);
					String beanName = service.value(); // 如果设置了值，不等于""
					if (!"".equals(beanName.trim())) {
						ioc.put(beanName, clazz.newInstance());
					} else {
						beanName = lowerFirst(clazz.getSimpleName());
						ioc.put(beanName, clazz.newInstance());
					}

					Class<?>[] interfaces = clazz.getInterfaces();
					for (Class<?> interface1 : interfaces) {
						ioc.put(interface1.getName(), clazz.newInstance());
					}
				} else {
					continue;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void doAutowired() {
		if (ioc.isEmpty()) {
			return;
		}
		for (Entry<String, Object> entry : ioc.entrySet()) {
			// 通过反射拿到私有方法
			Field[] fileds = entry.getValue().getClass().getDeclaredFields();
			for (Field field : fileds) {
				// 给DEV加上，当且dev = true
				if (devMode && field.isAnnotationPresent(DevMode.class)) {
					try {
						// 只要加了Autowried注解的，实行强制赋值
						field.setAccessible(true);
						field.setBoolean(entry.getValue(), devMode);
					} catch (Exception e) {
						System.out.println("设置开发者模式 失败，抛出了一个错误");
						e.printStackTrace();
					}
					continue;
				}
				// 如果没有注解直接跳
				if (!field.isAnnotationPresent(Autowired.class)) {
					continue;
				}
				// 如果注解加了自定义的名字
				Autowired autowired = field.getAnnotation(Autowired.class);
				String beanName = autowired.value().trim();
				// 通过声明接口注入
				if ("".equals(beanName.trim())) {
					beanName = field.getType().getName();
				}
				// 只要加了Autowried注解的，实行强制赋值
				field.setAccessible(true);
				try {
					// 反射机制拿到属性名使用set方法给属性构造对象
					field.set(entry.getValue(), ioc.get(beanName));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void initHandlerMapping() {
		if (ioc.isEmpty()) {
			return;
		}
		for (Entry<String, Object> entry : ioc.entrySet()) {
			// 把所有的RequestMapping扫描出去，读取他的值，跟Method关联上，并且放入到HandlerMapping之中去
			Class<?> clazz = entry.getValue().getClass();
			// 只跟Controller
			if (!clazz.isAnnotationPresent(Controller.class)) {
				continue;
			}

			String baseUrl = "";
			if (clazz.isAnnotationPresent(RequestMapping.class)) {
				RequestMapping requestMapping = clazz.getAnnotation(RequestMapping.class);
				baseUrl = requestMapping.value();
			}
			Method[] methods = clazz.getMethods();
			for (Method method : methods) {
				if (!method.isAnnotationPresent(RequestMapping.class)) {
					continue;
				}
				RequestMapping requestMapping = method.getAnnotation(RequestMapping.class);
				String mappingUrl = ("/" + baseUrl + "/" + requestMapping.value()).replaceAll("/+", "/");

				// 把url和Method的关系再重新封装一次
				Pattern pattern = Pattern.compile(mappingUrl);
				handlerMaping.add(new Handler(pattern, entry.getValue(), method));
				System.out.println("Mapping : " + mappingUrl + ",Method : " + method);
			}
		}
	}

	// 首字母小写
	private String lowerFirst(String str) {
		char[] chars = str.toCharArray();
		chars[0] += 32;
		return String.valueOf(chars);
	}

	/**
	 * 内部类 Handler记录Controller中的RequestMapping和Method的对应关系
	 * 
	 * @author zclong 2018年1月4日
	 */
	private class Handler {
		protected Object controller; // 保存方法对应的实例
		protected Method method; // 保存映射的方法
		protected Pattern pattern; // Spring中的url支持正则
		protected Map<String, Integer> paramIndexMapping; // 参数顺序

		/**
		 * 构造基于Handler的基本参数
		 * 
		 * @param pattern
		 * @param controller
		 * @param method
		 */
		protected Handler(Pattern pattern, Object controller, Method method) {
			this.controller = controller;
			this.method = method;
			this.pattern = pattern;

			paramIndexMapping = new HashMap<String, Integer>();
			putParamIndexMapping(method);
		}

		private void putParamIndexMapping(Method method) {
			// 提取方法中加了注解的参数
			Annotation[][] pa = method.getParameterAnnotations();
			for (int i = 0; i < pa.length; i++) {
				for (Annotation annotation : pa[i]) {
					if (annotation instanceof RequestParam) {
						String paramName = ((RequestParam) annotation).value();
						if (!"".equals(paramName.trim())) {
							paramIndexMapping.put(paramName, i);
						}
					}
				}
			}

			// 提取方法中的request和response参数
			Class<?>[] paramsTypes = method.getParameterTypes();
			for (int i = 0; i < paramsTypes.length; i++) {
				Class<?> type = paramsTypes[i];
				if (type == HttpServletRequest.class || type == HttpServletResponse.class) {
					paramIndexMapping.put(type.getName(), i);
				}
			}
		}
	}

	/**
	 * 如果传递的参数是int类型，将String类型转换为int类型
	 * 2018年1月19日
	 * zclong
	 * @param type
	 * @param value
	 * @return
	 */
	private Object convert(Class<?> type, String value) {
		if (Integer.class == type) {
			return Integer.valueOf(value);
		}
		return value;
	}

	/**
	 * 视图真实路径 2018年1月13日 zclong
	 * 
	 * @param viewName
	 * @return
	 * @throws Exception
	 */
	protected String buildView(String viewName) {
		if (null == viewName) {
			LOGGER.debug("视图路径不能为空");
		}
/*		String prefix = "/WEB-INF/pages/"; // 视图前缀
*/		String suffix = ".html"; // 视图后缀
		String view = ( viewName + suffix).replaceAll("/+", "/");;
		return view;
	}
	
	/**
	 * 处理结果集 2018年1月16日 zclong
	 * 
	 * @param req
	 * @param resp
	 * @param obj 方法返回的数据(ModelAndView或者String)
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void handleResult(HttpServletRequest req, HttpServletResponse resp, Object obj) throws ServletException, IOException {
		// 如果是ModelAndView的实例就说明是回到视图层，否则转发到其他方法
		if(obj instanceof ModelAndView) {
			ModelAndView mv = (ModelAndView) obj;
			String view = buildView(mv.getViewName());
			Map<String, Object> model = mv.getModelInternal();
			model.put("url", view);
			/**
			 * 结果处理
			 */
			InternalResourceView internalResourceView = SingletonUtil.INSTANCE.buildInternalResourceView();
			try {
				internalResourceView.renderMergedOutputModelFreeMarker(model, req, resp);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(obj instanceof Result){
			// ajax请求
			new AjaxResultHander(req, resp).doAjax(obj);
            return;
		} else {
			String resource = (String) obj;
			/*
			 * 查看返回的字符串中是否包含冒号，如果没有，表示转发 如果有，使用冒号分割字符串，得到前缀和后缀！
			 * 其中前缀如果是forward，表示跳转到相同类中的方法，如果是r表示重定向，后缀就是要转发或重定向的路径了！
			 */
			if (resource.contains(":")) {

				// 获取冒号的位置，使用冒号分割字符串，得到前缀和后缀
				int index = resource.indexOf(":");
				// 截取result字符串的第一个字母,冒号前的字符串
				String i = resource.substring(0, index);// 截取出前缀，表示操作
				// 截取冒号后的所有字符
				String path = resource.substring(index + 1).trim();// 截取出后缀，表示路径

				// 表示传递的参数
				String params = "";
				// 如果带有参数 
				if(path.contains("?")) {
					// 获取?的位置，使用?分割字符串，得到前缀和后缀
					index = path.indexOf("?");
					String pathParams = path;
					// 截取出前缀，表示路径
					path = pathParams.substring(0, index).trim();
					// 截取出后缀，表示参数
					params = pathParams.substring(index).trim();
				}
				
				//判断是转发还是重定向,f代表转发，r代表重定向
				if ("forward".equalsIgnoreCase(i)) {
					req.getRequestDispatcher(path + ".do" + params).forward(req, resp);
				} else if ("redirect".equalsIgnoreCase(i)) {
					resp.sendRedirect(req.getContextPath() + path + ".do" + params);
				} else {
					throw new RuntimeException("你指定的操作：" + i + "，当前版本还不支持！");
				}
			}else {
				resource = buildView(resource);
				Map<String, Object> model = new HashMap<String, Object>();
				model.put("url", resource);
				/**
				 * 结果处理
				 */
				InternalResourceView internalResourceView = SingletonUtil.INSTANCE.buildInternalResourceView();
				try {
					internalResourceView.renderMergedOutputModelFreeMarker(model, req, resp);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
}
