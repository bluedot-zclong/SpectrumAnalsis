package bluedot.spectrum.web.controller;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import bluedot.spectrum.utils.BeanUtil;
import bluedot.spectrum.web.core.utils.Result;

/**
 * 所有controller的父类
 * @author zclong
 * 2018年1月20日
 */
public abstract class BaseController{
	// 控制器本来就是单例，这样似乎更加合理
    protected Logger logger = LoggerFactory.getLogger(getClass());
    
    protected HttpServletRequest request;
    protected HttpServletResponse response;
    protected HttpSession session;

    protected Cookie[] cookies;
    protected String userAgent;

    void init(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        this.request = request;
        this.response = response;
        this.session = session;
    }
    
    
    /**
     * ajax失败
     * @param msg 失败的消息
     * @return {Object}
     */
    public Object renderError(String msg) {
        Result result = new Result();
        result.setMsg(msg);
        return result;
    }
    
    /**
     * ajax成功
     * @return {Object}
     */
    public Object renderSuccess() {
        Result result = new Result();
        result.setSuccess(true);
        return result;
    }
    
    /**
     * ajax成功
     * @param msg 消息
     * @return {Object}
     */
    public Object renderSuccess(String msg) {
        Result result = new Result();
        result.setSuccess(true);
        result.setMsg(msg);
        return result;
    }

    /**
     * ajax成功
     * @param obj 成功时的对象
     * @return {Object}
     */
    public Object renderSuccess(Object obj) {
        Result result = new Result();
        result.setSuccess(true);
        result.setObj(obj);
        return result;
    }
    
    /**
     * 通过reques进行bean对象的封装
     * @param req
     * @param beanClass
     * @return
     */
    public <T> T getBean(HttpServletRequest req, Class<T> beanClass) {
        return BeanUtil.mapToBean(getParameterMap(req), beanClass);
    }
    
    /**
     * 通过传入的map进行bean的封装
     * @param beanMap
     * @param beanClass
     * @return
     */
    public <T> T getBean(List<HashMap<String,Object>> queryResult, Class<T> beanClass) {
    	if(queryResult.size() != 0) {
    		Map<String, Object> beanMap = queryResult.get(0);
        	beanMap = BeanUtil.mapToCamel(beanMap);
            return BeanUtil.mapToBean(beanMap, beanClass);
    	}else {
    		return null;
    	}
    }
    
    /**
     * 通过传入的map进行bean的封装
     * @param <T>
     * @param beanMap
     * @param beanClass
     * @return
     */
    public <T> List<T> getBeanList(List<HashMap<String,Object>> queryResult, Class<T> beanClass) {
    	List<T> listBean = new ArrayList<T>();
    	if(queryResult.size() != 0) {
    		for (HashMap<String, Object> hashMap : queryResult) {
//    			Map<String, Object> beanMap = queryResult.get(0);
    			Map<String, Object> beanMap = BeanUtil.mapToCamel(hashMap);
                listBean.add(BeanUtil.mapToBean(beanMap, beanClass));
			}
    	}
    	return listBean;
    }

    public String getHeader(String name) {
        return request.getHeader(name);
    }

    public String getParameter(String name) {
        return request.getParameter(name);
    }

    public Enumeration<String> getParameterNames() {
        return request.getParameterNames();
    }

    public String[] getParameterValues(String name) {
        return request.getParameterValues(name);
    }

    public Map<String, String[]> getParameterMap(HttpServletRequest request) {
        return request.getParameterMap();
    }

    @SuppressWarnings("unchecked")
    public <T> T getRequestAttribute(String name) {
        return (T) request.getAttribute(name);
    }

    public void setRequestAttribute(String name, Object value) {
        request.setAttribute(name, value);
    }

    @SuppressWarnings("unchecked")
    public <T> T getSessionAttribute(String name) {
        return (T) request.getSession().getAttribute(name);
    }

    public void setSessionAttribute(String name, Object value) {
        request.getSession().setAttribute(name, value);
    }
    
    @SuppressWarnings("unchecked")
    public static <T> T getSessionUser(HttpSession session) {
        return (T) session.getAttribute("loginUser");
    }



    /**
     * Get cookie object by cookie name.
     */
    public Cookie getCookieObject(String name) {
        Cookie[] cookies = getCookieObjects();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(name)) {
                return cookie;
            }
        }
        return null;
    }

    /**
     * Get all cookie objects.
     */
    public Cookie[] getCookieObjects() {
        if (null == cookies) {
            cookies = request.getCookies();
        }
        return cookies != null ? cookies : new Cookie[0];
    }

    /**
     * Get cookie value by cookie name.
     */
    public String getCookie(String name, String defaultValue) {
        Cookie cookie = getCookieObject(name);
        return cookie != null ? cookie.getValue() : defaultValue;
    }

    /**
     * Get cookie value by cookie name.
     */
    public String getCookie(String name) {
        return getCookie(name, null);
    }

    /**
     * Set Cookie to response.
     *
     * @param name            cookie name
     * @param value           cookie value
     * @param maxAgeInSeconds -1: clear cookie when close browser. 0: clear cookie immediately.  n>0 : max age in n seconds.
     * @param path            see Cookie.setPath(String)
     * @param domain          the domain name within which this cookie is visible; form is according to RFC 2109
     * @param isHttpOnly      true if this cookie is to be marked as HttpOnly, false otherwise
     */
    public BaseController setCookie(String name, String value, int maxAgeInSeconds, String path, String domain, boolean isHttpOnly) {
        return doSetCookie(name, value, maxAgeInSeconds, path, domain, isHttpOnly);
    }

    /**
     * {@link #setCookie(String, String, int, String, String, boolean)}
     */
    public BaseController setCookie(String name, String value, int maxAgeInSeconds, String path, boolean isHttpOnly) {
        return doSetCookie(name, value, maxAgeInSeconds, path, null, isHttpOnly);
    }

    /**
     * {@link #setCookie(String, String, int, String, String, boolean)}
     */
    public BaseController setCookie(String name, String value, int maxAgeInSeconds, String path) {
        return doSetCookie(name, value, maxAgeInSeconds, path, null, null);
    }

    /**
     * {@link #setCookie(String, String, int, String, String, boolean)}
     */
    public BaseController setCookie(String name, String value, int maxAgeInSeconds, boolean isHttpOnly) {
        return doSetCookie(name, value, maxAgeInSeconds, null, null, isHttpOnly);
    }

    /**
     * {@link #setCookie(String, String, int, String, String, boolean)}
     */
    public BaseController setCookie(String name, String value, int maxAgeInSeconds) {
        return doSetCookie(name, value, maxAgeInSeconds, null, null, null);
    }

    private BaseController doSetCookie(String name, String value, int maxAgeInSeconds, String path, String domain, Boolean isHttpOnly) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAgeInSeconds);
        // set the default path value to "/"
        if (path == null) {
            path = "/";
        }
        cookie.setPath(path);

        if (domain != null) {
            cookie.setDomain(domain);
        }
        if (isHttpOnly != null) {
            cookie.setHttpOnly(isHttpOnly);
        }
        response.addCookie(cookie);
        return this;
    }
}
