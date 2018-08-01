
package bluedot.spectrum.web.filter;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * 编码过滤器
 * @author zclong
 * 2018年1月18日
 */
public class CharsetEncodingFilter implements Filter {

	private String encoding;

	public void destroy() {
		System.out.println("CharsetEncodingFilter.destroy()");
	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		// System.out.println("CharsetEncodingFilter.doFilter()");
		// 设置字符集
		request.setCharacterEncoding(encoding);
		// System.out.println("--------doFilter begin----------");
		// 如果继续执行其他的操作，必须显示的执行如下语句
		chain.doFilter(request, response);
		// System.out.println("--------doFilter end----------");
	}

	public void init(FilterConfig config) throws ServletException {
		encoding = config.getInitParameter("encoding");
	}

}
