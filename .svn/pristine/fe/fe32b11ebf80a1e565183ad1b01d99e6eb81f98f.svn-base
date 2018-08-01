package bluedot.spectrum.web.controller;

import java.util.List;
import java.util.Properties;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

import bluedot.spectrum.service.exception.ServiceException;
import bluedot.spectrum.utils.VerifyCodeUtils;
import bluedot.spectrum.utils.vcode.Captcha;
import bluedot.spectrum.utils.vcode.GifCaptcha;
import bluedot.spectrum.web.core.config.ActionConfig;
import bluedot.spectrum.web.core.utils.ResourcesUtil;
import jxau.spectrum.frame.web.annotation.Controller;
import jxau.spectrum.frame.web.annotation.RequestMapping;
import jxau.spectrum.frame.web.annotation.Token;


@Controller
public class IndexController extends BaseController{

	private static Properties views;

    static {
        views = ActionConfig.loadPropertyFile("views.properties");
    }

    /**
     * 获取视图
     *
     * @param name 视图名称
     * @return 视图路径
     */
    public static String getView(String name) {
        String view = views.getProperty("page404");// 默认404

        if (StringUtils.isNotBlank(name)) {
            view = views.getProperty(name, view);// 不存在则404
        }

        return view;
    }
    
    public void setViews(Properties views) {
        logger.debug("views:{}", views);
        this.views = views;
    }

    @RequestMapping("/")
    public String goLogin() {
        return "/login/login";
    }
    
    @RequestMapping("/index")
    public String index() {
        return "/index";
    }
    

   /* @RequestMapping("/error/{code}")
    public String error(String code, HttpServletResponse response) {
        logger.debug("code:{}", code);
        try {
            Integer keyCode = Integer.valueOf(code);
            String view = views.getProperty(code, "/error/404");
            if ("/error/404".equals(view)) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            } else {
                response.setStatus(keyCode);
            }
            return view;
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return "/error/404";
        }
    }*/

    /**
     * 根据views.properties配置文件，跳转到相应的路径
     * @param req
     * @return
     */
    @RequestMapping("/view/*")
    public String view(HttpServletRequest req) {
    	String url = req.getRequestURI();
    	if(url.indexOf(".") != -1) {
			url = url.substring(0, url.lastIndexOf("."));
		}
    	String v = url.substring(url.lastIndexOf("/")+1);
        String view = views.getProperty(v, "/error/404");
        logger.debug("v:{}, view:[{}]", v, view);
        return view;
    }
    
	/**
     * 退出
     * @return {Result}
     */
    @RequestMapping("/logout")
    public Object logout() {
        logger.info("登出");
        return renderSuccess();
    }
    
    /**
	 * 获取验证码（Gif版本）
	 * @param response
	 * @throws CustomException 
	 */
	@RequestMapping("/user/getGifCode")
	public void getGifCode(HttpServletResponse resp,HttpServletRequest req) {
		try {
			//存入session  
	        HttpSession session = req.getSession(); 
	        
			resp.setHeader("Pragma", "No-cache");  
			resp.setHeader("Cache-Control", "no-cache");  
			resp.setDateHeader("Expires", 0);  
			resp.setContentType("image/gif");  
	        /**
	         * gif格式动画验证码
	         * 宽，高，位数。
	         */
	        Captcha captcha = new GifCaptcha(146,42,4);
	        //输出
	        ServletOutputStream out = resp.getOutputStream();
	        captcha.out(out);
	        out.flush();
	        
	        session.setAttribute(VerifyCodeUtils.V_CODE, captcha.text().toLowerCase());
		} catch (Exception e) {
			throw new ServiceException("获取验证码异常！");
		}
	}
}
