package bluedot.spectrum.web.controller;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bluedot.spectrum.common.EditObject;
import bluedot.spectrum.common.QueryObject;
import bluedot.spectrum.commons.entity.Maintenance;
import bluedot.spectrum.commons.entity.User;
import bluedot.spectrum.service.EditService;
import bluedot.spectrum.service.QueryService;
import bluedot.spectrum.web.core.ModelAndView;
import jxau.spectrum.frame.web.annotation.Autowired;
import jxau.spectrum.frame.web.annotation.Controller;
import jxau.spectrum.frame.web.annotation.RequestMapping;
import jxau.spectrum.frame.web.annotation.RequestParam;

/**
 * 回收站业务( 针对于algorithm， spectruminfo)
 * @author 龚志鹏
 * 2018年1月20日
 */
@Controller
@RequestMapping("/recyclebin")
public class RecycleController extends BaseController{
	
	@Autowired
	private QueryService queryService;
	@Autowired
	private EditService editService;
	
	/**
	 * 获得个人回收站所有文件
	 * 2018年1月21日
	 * zclong
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getall")
	public ModelAndView listAllRecycleBins( HttpServletRequest request, HttpServletResponse response){
		
        Map<String, Object> model = new HashMap<String, Object>();
        ModelAndView modelAndView = new ModelAndView();
        Map<String,Object> condition = new HashMap<>();
        
       
        //文件结果集
        List<HashMap<String,Object>> resultList = new ArrayList<HashMap<String,Object>>();
        
        User user = (User) request.getSession().getAttribute("userSession");
        
        //添加查询条件
        condition.put("user_id", user.getUserId());
        QueryObject queryParm = new QueryObject("dir", condition, null, null, null);
        List<HashMap<String,Object>> dirResult = queryService.query(queryParm);
        
        //移除查询条件user_id
        condition.remove("user_id");
    
        
        //临时保存文件夹id
        BigInteger dirId = null;
        //临时保存文件夹类型id
        Boolean dirTypeId = null;
        //遍历用户的文件夹id，并去除对应的文件		
        for(HashMap<String,Object> dir : dirResult){
        	
        	dirId =  (BigInteger) dir.get("dir_id");        	
        	dirTypeId = (Boolean) dir.get("dir_type_id");
        	//算法文件
        	if(dirTypeId){
        		condition.put("dir_file_id", dirId);
        		 //添加判断是否在回收站的条件is_deleted
                condition.put("is_deleted", "1");
        		queryParm = new QueryObject("algorithm", condition, null, null, null);
        		
        		try{
        			resultList.addAll(queryService.query(queryParm));
        		}catch(Exception e){
        		}
        		condition.remove("is_deleted");
        	}
        	//光谱文件
        	else if(!dirTypeId){
        		condition.put("file_id", dirId);
        		//添加判断是否在回收站的条件is_deleted
                condition.put("is_delete", "1");
        		queryParm = new QueryObject("spectruminfo", condition, null, null, null);
        		try{
        			resultList.addAll(queryService.query(queryParm));
        		}catch(Exception e){
        		}
        		condition.remove("is_delete");
        	}
        	condition.remove("dir_id");
        }
          
        modelAndView.addObject("resultList", resultList);
        modelAndView.setViewName("/recycle/recycle");
        return modelAndView;
	}
	
	/**
	 * 更新回收站文件状态
	 * 2018年1月21日
	 * zclong
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/update")
	public String updateRecycleBinStatus(HttpServletRequest request, HttpServletResponse response){
		//封装修改条件
		Map<String,Object> updateMap = new HashMap<>();
		//封装where的选择条件
		Map<String,Object> condition = new HashMap<>();
		
		//算法文件id
		String alid = request.getParameter("alid");
		//光谱文件id
		String speid = request.getParameter("speid");
		//文件状态
		String state = request.getParameter("state");
		EditObject editParm = null;
		//修改的是算法文件的状态
		if(alid != null){
			condition.put("algorithm_id", alid);
			//2代表彻底删除， 0代表撤回删除状态
			if("2".equals(state) || "0".equals(state)){
				updateMap.put("is_deleted", state);
			}
			//非法的文件状态更改请求
			else{
				
			}
			editParm = new EditObject("algorithm", updateMap, condition, null);
		}
		//修改的是光谱文件的状态
		else if(speid != null){
			condition.put("spectruminfo_id", speid);
			//2代表彻底删除， 0代表撤回删除状态
			if("2".equals(state) || "0".equals(state)){
				updateMap.put("is_delete", state);
			}
			//非法的文件状态更改请求
			else{
				
			}
			editParm = new EditObject("spectruminfo", updateMap, condition, null);
		}
		//错误的请求文件
		else{
			
		}
		return "redirect:/view/user/updatepassword";
	}	
}
