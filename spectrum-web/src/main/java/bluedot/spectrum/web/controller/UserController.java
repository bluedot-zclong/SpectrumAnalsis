package bluedot.spectrum.web.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.crypto.hash.Md5Hash;

import bluedot.spectrum.common.EditObject;
import bluedot.spectrum.common.QueryObject;
import bluedot.spectrum.commons.entity.Maintenance;
import bluedot.spectrum.commons.entity.User;
import bluedot.spectrum.service.EditService;
import bluedot.spectrum.service.QueryService;
import bluedot.spectrum.utils.EncryptUtil;
import bluedot.spectrum.utils.ValidUtils;
import bluedot.spectrum.utils.VerifyCodeUtils;
import bluedot.spectrum.web.core.ModelAndView;
import jxau.spectrum.frame.web.annotation.Autowired;
import jxau.spectrum.frame.web.annotation.Controller;
import jxau.spectrum.frame.web.annotation.DevMode;
import jxau.spectrum.frame.web.annotation.RequestMapping;
import jxau.spectrum.frame.web.annotation.RequestParam;
import jxau.spectrum.frame.web.annotation.Token;

/**
 * 用户业务
 * 
 * @author 刘勋乘 2018年1月20日
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {
	// 注入查询业务
	@Autowired
	private QueryService queryService;
	@Autowired
	private EditService editService;

	@DevMode
    protected boolean devMode;


	/**
	 * 登录
	 * @param req
	 * @param email
	 * @param password
	 * @param vcode
	 * @return
	 */
	@RequestMapping("/login")
	public String login(HttpServletRequest req, @RequestParam("email") String email,
			@RequestParam("password") String password, @RequestParam("vcode") String vcode) {

		// 判断登录数据正常，验证码正确  获取session中的验证码
		if (!ValidUtils.loginVerify(email, password, vcode,
				(String) req.getSession().getAttribute(VerifyCodeUtils.V_CODE), devMode)) {
			return "redirect:/view/login";
		}

		// 数据封装
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("email", email);
		QueryObject queryObject = new QueryObject("user", condition, null, null, null);
		// 调用查询业务，得到结果
		List<HashMap<String, Object>> queryResult = queryService.query(queryObject);
		if (queryResult.size() == 0) {
			return "redirect:/view/login";
		}
		User loginUser = (User) getBean(queryResult, User.class);

		// 判断密码是否正确
		if (!EncryptUtil.md5Encode(password, loginUser.getPassword(), loginUser.getSalt())) {
			return "redirect:/view/login";
		}

		// 将密码设置为null，确保安全
		loginUser.setPassword(null);
		loginUser.setSalt(null);
		// 保存到session中
		saveSessionUser(loginUser, req.getSession());

		return "redirect:/view/index";
	}

	/**
	 * 用户注册
	 * 
	 * @param req
	 * @param resp
	 * @return需要返回一个跳转的页面将其放入ModeAndView中
	 */
	@RequestMapping("/regist")
	public ModelAndView regist(HttpServletRequest req, HttpServletResponse resp) {
		// 传给模板用来存储数据的model
		Map<String, Object> model = new HashMap<String, Object>();

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addAllObjects(model);
		modelAndView.setViewName("/login/login");
		return modelAndView;
	}

	/**
	 * 根据用户的id查询用户的信息
	 * 
	 * @param userId用户的id
	 * @return返回的是一个用户的信息放入ModeAndView中
	 */
	@RequestMapping("/query/userinfo")
	public Object queryUserInfo(@RequestParam("userId") String userId) {
		Map<String, Object> condition = new HashMap<>();
		condition.put("user_id", userId);

		QueryObject queryParm = new QueryObject("user", condition, null, null, null);
		List<HashMap<String, Object>> queryResult = queryService.query(queryParm);
		User user = getBean(queryResult, User.class);
		return renderSuccess(user);
	}

	@RequestMapping("/query/myinfo")
	public ModelAndView queryMyInfo(HttpServletRequest req, HttpServletResponse resp,  String resultMessage) {

		ModelAndView modelAndView = new ModelAndView();
		User user = (User) req.getSession().getAttribute("userSession");
		
		if(resultMessage != null){
			Map<String, String> message = new HashMap<String, String>();
			message.put("resultMessage", resultMessage);
			modelAndView.addObject(message);
		}			
		
		modelAndView.addObject(user);
		modelAndView.setViewName("/user/myinfo");
		return modelAndView;
	}

	/**
	 * 找回密码
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("/findPassword")
	public String findPassword(HttpServletRequest req, HttpServletResponse resp) {
		
		return "redirect:/view/index";
	}

	/**
	 * 改变密码
	 * 判断能否进入修改密码的页面
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("/changepassword")
	public String changePassword(HttpServletRequest req, HttpServletResponse resp) {
		if(req.getSession().getAttribute("userSession") != null){

			return "redirect:/view/user/updatepassword";
		}

		else
			return "redirect:/login/login";
	}


	/**
	 * 改变密码
	 * 修改密码
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("/updatepassword")
	public ModelAndView updatePassword(HttpServletRequest req, @RequestParam("password") String password, @RequestParam("oldpassword") String oldpassword, @RequestParam("again") String again) {
		ModelAndView modelAndView = new ModelAndView();
        Map<String,Object> condition = new HashMap<>();
        
        User user = (User)req.getSession().getAttribute("userSession");
		if(user.getUserId() == null){
			modelAndView.setViewName("/login/login");
			return modelAndView;
		}      
        
		//新密码和老密码一样
		if(password.equals(oldpassword)){
			modelAndView.addObject("error", "新密码和原来的密码相同");
			modelAndView.setViewName("user/updatepassword");
			return modelAndView;
		}
		//新密码和再次输入不同
		if(!password.equals(again)){
			modelAndView.addObject("error", "新密码和再次输入的密码不同");
			modelAndView.setViewName("user/updatepassword");
			return modelAndView;
		}
		
		//验证密码是否正确，正确，就进行下一步，不正确，就返回登录界面
		if (!EncryptUtil.md5Encode(password, user.getPassword(), user.getSalt())) {
			modelAndView.addObject("error", "新密码和再次输入的密码不同");
			request.getSession().invalidate();
			modelAndView.setViewName("/login/login");
			return modelAndView;
		}
		
		//将新密码进行加密，并保存到数据库
		Md5Hash md5Hash = new Md5Hash(again, user.getSalt(), 2);
		String password_dm5 = md5Hash.toString();
		
		condition.put("user_id",user.getUserId());
		Map<String,Object> updateMap = new HashMap<>();
	    updateMap.put("password", password_dm5);
	    EditObject editParm = new EditObject("user", updateMap, condition, null);
	    int Result = editService.edit(editParm);
		
		//密码修改成功——注销登录信息
		request.getSession().invalidate();
		modelAndView.setViewName("/login/login");
		return modelAndView;
	}

	/**
	 * 修改用户信息
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("/update/userInfo")
	public ModelAndView updateUserInfo(HttpServletRequest req, HttpServletResponse resp) {
		/**
		 * 封装返回的数据和视图
		 */
		ModelAndView modelAndView = new ModelAndView();
		
		//得到登陆的用户
		User user = (User)req.getSession().getAttribute("userSession");
		
		/**
		 * 获得传入的若干参数
		 */
		String username = req.getParameter("username");
		String sexString = req.getParameter("sex");
		int sex = 1;
		if("男".equals(sexString)){
			sex = 1;
		}else if("女".equals(sexString)){
			sex = 0;
		}else{
			return queryMyInfo(req, resp, "性别输入有误");
		}
			
		String date = req.getParameter("birthday");
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");   
		Date birthday = null;
		
		//
		try {
			birthday = format1.parse(date);
		} catch (ParseException e) {
			return queryMyInfo(req, resp, "输入日期有误");
		}
		
		String personAddress = req.getParameter("personAddress");
		String workAddress = req.getParameter("workAddress");
		
		
		
		//修改的条件
        Map<String,Object> condition = new HashMap<>();
        
       
		condition.put("user_id",user.getUserId());
		
		//需要修改的数据
		Map<String,Object> updateMap = new HashMap<>();
	    updateMap.put("user_name", username);
	    updateMap.put("birthday", birthday);
	    updateMap.put("sex", sex);
	    updateMap.put("person_address", personAddress);
	    updateMap.put("work_address", workAddress);
	   
	    EditObject editParm = new EditObject("user", updateMap, condition, null);
	    int Result = editService.edit(editParm);	
	    
		// 修改session的内容		
	    user.setBirthday(birthday);
	    user.setPersonAddress(personAddress);
	    user.setWorkAddress(workAddress);
	    user.setSex(sex);
	    user.setUserName(username);
	
		// 保存到session中
		saveSessionUser(user, req.getSession());
	    
		return queryMyInfo(req, resp, "修改成功");
	}

	/**
	 * 角色申请
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("/applyRold")
	public ModelAndView applyRold(HttpServletRequest req, HttpServletResponse resp) {
		
		return null;
	}

	/**
	 * 查询所有用户信息
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("/query/alluser")
	public ModelAndView queryAllUserInfo(HttpServletRequest req, HttpServletResponse resp) {

		ModelAndView modelAndView = new ModelAndView();
		Map<String, Object> condition = new HashMap<>();

		QueryObject queryParm = new QueryObject("user", condition, null, null, null);
		List<HashMap<String, Object>> queryResult = queryService.query(queryParm);

		List<User> userList = getBeanList(queryResult, User.class);
		modelAndView.addObject(userList);

		modelAndView.setViewName("/user/alluser");
		return modelAndView;
	}

	private void saveSessionUser(User user, HttpSession session) {
		// 把验证码去除
		session.removeAttribute(VerifyCodeUtils.V_CODE);
		// 存储用户信息
		session.setAttribute("userSession", user);
	}

	/**
	 * 用户退出
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "/login/login";
	}
}
