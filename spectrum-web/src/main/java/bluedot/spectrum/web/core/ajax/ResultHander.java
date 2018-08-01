package bluedot.spectrum.web.core.ajax;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

/**
 * 
 * @author longshu 2016年10月13日
 */
public abstract class ResultHander {
	protected static Logger logger = Logger.getLogger(ResultHander.class);
	protected HttpServletRequest request;
	protected HttpServletResponse response;

	public ResultHander(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}
}
