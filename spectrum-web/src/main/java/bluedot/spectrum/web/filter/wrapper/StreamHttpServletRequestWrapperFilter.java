package bluedot.spectrum.web.filter.wrapper;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
/**
 * 通过Filter，将HttpServletRequest包装成StreamHpptServletRequestWrapper
 * @ClassName: StreamHttpServletRequestWrapperFilter
 * @author WFP
 * @date 2018年3月24日 上午10:57:53
 * @Description: TODO
 *
 */
public class StreamHttpServletRequestWrapperFilter implements Filter{

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		ServletRequest servletRequest = null;

		if(request instanceof HttpServletRequest){
			HttpServletRequest httpServletRequest = (HttpServletRequest) request;
			
            String method = httpServletRequest.getMethod().toUpperCase();  
    		// 得到请求的url
    		String url = ((HttpServletRequest) request).getRequestURI();
    		System.out.println(url.contains("/upload"));
            if(url.contains("/upload")&&"POST".equals(method)){
            	servletRequest = new StreamHpptServletRequestWrapper((HttpServletRequest) request);
            }

		}
		if (servletRequest == null) {    
            chain.doFilter(request, response);    
        } else {    
            chain.doFilter(servletRequest, response);     
        }    
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

}
