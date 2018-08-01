package bluedot.spectrum.web.core;

import java.io.File;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import bluedot.spectrum.freemarker.config.FreeMarkerConfig;
import bluedot.spectrum.web.core.utils.StringUtils;
import bluedot.spectrum.web.core.utils.WebUtils;
import freemarker.template.Template;
import freemarker.template.TemplateException;


public class InternalResourceView {
	private static final Logger LOGGER = LogManager.getLogger(InternalResourceView.class);
	
	private String url;
	/**
	 * 设置是否显式阻止派遣回,默认为“false”。 基于约定切换到“true”
	 */
	private boolean preventDispatchLoop = false;
	
	private boolean alwaysInclude = false;
	
	public static final String DEFAULT_CONTENT_TYPE = "text/html;charset=UTF-8";
	
	private String contentType = DEFAULT_CONTENT_TYPE;
	/**
	 * 设置是否显式阻止调度回
	 * 当前处理程序路径。
	 * 2018年1月13日
	 * zclong
	 * @param preventDispatchLoop
	 */
	public void setPreventDispatchLoop(boolean preventDispatchLoop) {
		this.preventDispatchLoop = preventDispatchLoop;
	}
	/**
	 * 
	* @Title: renderMergedOutputModelFreeMarker 
	* @Description: TODO(渲染指定模型的内部资源) 
	* @author WFP
	* @return void    返回类型 
	* @throws
	 */
	protected void renderMergedOutputModelFreeMarker(
			Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		this.url = (String) model.get("url");
		
		Map<String,Object> sessionMap = new HashMap<String,Object>();
		for (Enumeration<String> en = request.getSession().getAttributeNames(); en.hasMoreElements();) {
			String attribute = en.nextElement();
			if (sessionMap.containsKey(attribute)) {
				throw new ServletException("Cannot expose session attribute '" + attribute +
						"' because of an existing model object of the same name");
			}
			Object attributeValue = request.getSession().getAttribute(attribute);
			
			sessionMap.put(attribute, attributeValue);
		}
		
		FreeMarkerConfig freeMarkerConfig = FreeMarkerConfig.INSTANCE;
		String path = request.getServletContext().getRealPath("/")+"WEB-INF/pages/templates";
	
		freeMarkerConfig.getConfiguration().setDirectoryForTemplateLoading(new File(path));
		Template template = freeMarkerConfig.getConfiguration().getTemplate(url);
		//项目路径
		model.put("basePath", request.getContextPath());
		model.put("Session", sessionMap);
		
        response.setCharacterEncoding("UTF-8");
        template.setEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        try {
        	template.process(model, out);
        } catch (TemplateException e) {
            e.printStackTrace();
        }
	}
	
	/**
	 * 渲染指定模型的内部资源。
	 * 这包括将模型设置为请求属性。
	 * 2018年1月13日
	 * zclong
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	protected void renderMergedOutputModel(
			Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// Expose the model object as request attributes.
		exposeModelAsRequestAttributes(model, request);

		this.url = (String) model.get("url");
		// Determine the path for the request dispatcher.
		String dispatcherPath = prepareForRendering(request, response);

		// Obtain a RequestDispatcher for the target resource (typically a JSP).
		RequestDispatcher rd = getRequestDispatcher(request, dispatcherPath);
		if (rd == null) {
			throw new ServletException("Could not get RequestDispatcher for [" + getUrl() +
					"]: Check that the corresponding file exists within your web application archive!");
		}

		// 如果已经包含或响应已经提交，则执行include，否则转发。
		if (useInclude(request, response)) {
			response.setContentType(getContentType());
			rd.include(request, response);
			return;
		}
		else {
			rd.forward(request, response);
			return;
		}
	}
	
	/**
	 * 将资源数据放到request中
	 * 2018年1月13日
	 * zclong
	 * @param model
	 * @param request
	 * @throws Exception
	 */
	protected void exposeModelAsRequestAttributes(Map<String, Object> model, HttpServletRequest request) throws Exception {
		for (Map.Entry<String, Object> entry : model.entrySet()) {
			String modelName = entry.getKey();
			Object modelValue = entry.getValue();
			if (modelValue != null) {
				request.setAttribute(modelName, modelValue);
			}
			else {
				request.removeAttribute(modelName);
			}
		}
	}
	
	protected String prepareForRendering(HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String path = getUrl();
		if (this.preventDispatchLoop) {
			String uri = request.getRequestURI();
			if (path.startsWith("/") ? uri.equals(path) : uri.equals(StringUtils.applyRelativePath(uri, path))) {
				throw new ServletException("Circular view path [" + path + "]: would dispatch back " +
						"to the current handler URL [" + uri + "] again. Check your ViewResolver setup! " +
						"(Hint: This may be the result of an unspecified view, due to default view name generation.)");
			}
		}
		return path;
	}
	
	public String getUrl() {
		return this.url;
	}
	
	protected RequestDispatcher getRequestDispatcher(HttpServletRequest request, String path) {
		return request.getRequestDispatcher(path);
	}
	
	protected boolean useInclude(HttpServletRequest request, HttpServletResponse response) {
		return (this.alwaysInclude || WebUtils.isIncludeRequest(request) || response.isCommitted());
	}
	
	public String getContentType() {
		return this.contentType;
	}
}
