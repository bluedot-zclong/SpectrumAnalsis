package bluedot.spectrum.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bluedot.spectrum.common.EditObject;
import bluedot.spectrum.common.QueryObject;
import bluedot.spectrum.commons.entity.Apply;
import bluedot.spectrum.commons.entity.DetectionMaterialCategory;
import bluedot.spectrum.commons.entity.Hardware;
import bluedot.spectrum.commons.entity.User;
import bluedot.spectrum.service.EditService;
import bluedot.spectrum.service.QueryService;
import bluedot.spectrum.web.core.ModelAndView;
import jxau.spectrum.frame.web.annotation.Autowired;
import jxau.spectrum.frame.web.annotation.Controller;
import jxau.spectrum.frame.web.annotation.RequestMapping;
import jxau.spectrum.frame.web.annotation.RequestParam;

/**
 * 申请业务
 * 2018年1月20日
 */
@Controller
@RequestMapping("/apply")
public class ApplyController extends BaseController{
	
	@Autowired
	private QueryService queryService;
	@Autowired
	private EditService editService;
	/**
	 * 查询所有的审核申请
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/checkApply")
	public ModelAndView checkApply(HttpServletRequest request, HttpServletResponse response){
		//传给模板用来存储数据的model
        Map<String, Object> model = new HashMap<String, Object>();
        ModelAndView modelAndView = new ModelAndView();
        //往model中添加数据
        Map<String,Object> condition = new HashMap<>();
        QueryObject queryParm = new QueryObject("apply", condition, null, null, null);
        List<HashMap<String,Object>> queryResult = queryService.query(queryParm);
        List<Apply> AllApplyInfoList  = getBeanList(queryResult, Apply.class);
        modelAndView.addObject(AllApplyInfoList);
        modelAndView.setViewName("/apply/checkmanage");
        return modelAndView;
	}
	
	/**
	 * 根据条件查询所有的申请   -----ajax请求
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/listApplyByCondition")
	public Object listApplyByCondition(@RequestParam("applyObjectId")String applyObjectId,@RequestParam("applyType")String applyType,@RequestParam("userId")String userId,HttpServletRequest request, HttpServletResponse response){
		System.out.println(applyObjectId+","+applyType+","+userId);
		//传给模板用来存储数据的model
        Map<String, Object> model = new HashMap<String, Object>();
        ModelAndView modelAndView = new ModelAndView();
        //往model中添加数据
        Map<String,Object> condition = new HashMap<>();
        condition.put("apply_object_id", applyObjectId);
        condition.put("apply_type", applyType);
        QueryObject queryParm = new QueryObject("apply", condition, null, null, null);
        List<HashMap<String,Object>> queryResult = queryService.query(queryParm);
        Apply applyInfoList  = getBean(queryResult, Apply.class);
        	condition.clear();
        	condition.put("user_id",userId);
        	queryParm = new QueryObject("user", condition, null, null, null);
            List<HashMap<String,Object>> userResult = queryService.query(queryParm);
            User userInfoList  = getBean(userResult, User.class);
            	 System.out.println(applyInfoList);

          
           	 System.out.println(userInfoList);
           
        
        model.put("applyInfoList",applyInfoList);
        model.put("userInfoList",userInfoList);
        return renderSuccess(model);
	}
	
	/**
	 * 下载申请文件
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/downApplyFile")
	public Object updateHardware(HttpServletRequest request, HttpServletResponse response){
		return null;
	}
	
	/**
	 * 根据申请类型和审核状态查询需要审核的光谱
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/listApplyByTypeAndStatus")
	public Object listApplyByTypeAndStatus(HttpServletRequest request, HttpServletResponse response){
		return null;
	}
	
	/**
	 * 实验员对操作员提交的申请光谱进行审核
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/resolveApplication")
	public Object queryHardware(HttpServletRequest request, HttpServletResponse response){
		return null;
	}
	
	/**
	 *审核光谱
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/updateApply")
	public Object updateApply(@RequestParam("applyId")String applyId,@RequestParam("applyReason")String applyReason,@RequestParam("applyStatus")String applyStatus,@RequestParam("upstatus")String upstatus,HttpServletRequest request, HttpServletResponse response){
		//往model中添加数据
				System.out.println(applyId);
				applyStatus=upstatus;
				Map<String,Object> condition = new HashMap<>();
		        condition.put("apply_id",applyId);
		        Map<String,Object> updateMap = new HashMap<>();
		        updateMap.put("apply_reason", applyReason);
		        updateMap.put("apply_status", applyStatus);
		        EditObject editParm = new EditObject("apply", updateMap, condition, null);
		        int Result = editService.edit(editParm);
		        System.out.println(applyId+","+applyReason);
		        return "redirect:/apply/checkApply";
	}
	
	
}
