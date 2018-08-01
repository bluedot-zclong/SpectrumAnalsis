package bluedot.spectrum.web.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bluedot.spectrum.commons.entity.Function;
import bluedot.spectrum.commons.entity.User;
import bluedot.spectrum.web.core.utils.ResourcesUtil;

/**
 * 权限过滤器
 * @author zclong
 * 2018年1月21日
 */
public class PermissionFilter implements Filter {

	// K: roleID , V: functions
    private Map<Long, List<Function>> roleFunction = new HashMap<>();
    private FilterConfig config;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
        this.config = filterConfig;
    }

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		
		// 过滤资源后缀参数
        String includeStrings = config.getInitParameter("includeStrings");
        // 没有登陆转向页面
        String redirectPath = config.getInitParameter("redirectPath");
        // 过滤器是否有效
        String disabletestfilter = config.getInitParameter("disabletestfilter");
        
        // 过滤无效
        if (disabletestfilter.toUpperCase().equals("Y")) {    
            chain.doFilter(request, response);
            return;
        }
        
		// 得到请求的url
		String url = request.getRequestURI();
		
		String[] includeList = includeStrings.split(";");
		// 只对指定过滤参数后缀进行过滤
		if (!this.isContains(url, includeList)) {
            chain.doFilter(request, response);
            return;
        }
		// 判断是否是公开 地址
		// 实际开发中需要公开 地址配置在配置文件中
		// 从配置中取逆名访问url

		List<String> open_urls = ResourcesUtil.gekeyList("anonymousURL");
		// 遍历公开 地址，如果是公开地址则放行
		for (String open_url : open_urls) {
			if (url.indexOf(open_url) >= 0) {
				// 如果是公开 地址则放行
				chain.doFilter(request, response);
				return;
			}
		}

		// 从配置文件中获取公共访问地址
		List<String> common_urls = ResourcesUtil.gekeyList("commonURL");
		// 遍历公用 地址，如果是公用 地址则放行
		for (String common_url : common_urls) {
			if (url.indexOf(common_url) >= 0) {
				// 如果是公开 地址则放行
				chain.doFilter(request, response);
				return;
			}
		}

		// 获取session
		HttpSession session = request.getSession();
		User session_user = (User) session.getAttribute("session_user");
		if (session_user == null) {
			request.getRequestDispatcher(redirectPath).forward(request, response);
            return;
        }
		// 从session中取权限范围的url
		List<Function> permissions = roleFunction.get(session_user.getRoleId());
		for (Function sysPermission : permissions) {
			// 权限的url
			String permission_url = sysPermission.getFunctionUrl();
			if (url.indexOf(permission_url) >= 0) {
				// 如果是权限的url 地址则放行
				chain.doFilter(request, response);
				return;
			}
		}
	}

	@Override
	public void destroy() {
	}
	public static boolean isContains(String container, String[] regx) {
        boolean result = false;

        for (int i = 0; i < regx.length; i++) {
            if (container.indexOf(regx[i]) != -1) {
                return true;
            }
        }
        return result;
    }
}
