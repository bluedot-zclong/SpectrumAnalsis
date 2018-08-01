package bluedot.spectrum.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bluedot.spectrum.common.EditObject;
import bluedot.spectrum.common.QueryObject;
import bluedot.spectrum.commons.entity.DetectedCategory;
import bluedot.spectrum.commons.entity.DetectedObject;
import bluedot.spectrum.commons.entity.DetectionMaterial;
import bluedot.spectrum.commons.entity.DetectionMaterialCategory;
import bluedot.spectrum.commons.entity.Dir;
import bluedot.spectrum.commons.entity.User;
import bluedot.spectrum.service.EditService;
import bluedot.spectrum.service.QueryService;
import bluedot.spectrum.web.core.ModelAndView;
import jxau.spectrum.frame.web.annotation.Autowired;
import jxau.spectrum.frame.web.annotation.Controller;
import jxau.spectrum.frame.web.annotation.RequestMapping;
import jxau.spectrum.frame.web.annotation.RequestParam;

/**
 * 检测物、被检测物模块
 * 2018年1月20日
 */
@Controller
@RequestMapping("/detect")
public class DetectedObjectMaterialController extends BaseController{
	@Autowired
	private QueryService queryService;
	@Autowired
	private EditService editService;
	
	/**
	 * 添加被检测物
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/addDetected")
	public Object addDetected(@RequestParam("detectedTypeId")String detectedTypeId,@RequestParam("detectedObjectsName")String detectedObjectsName,HttpServletRequest request, HttpServletResponse response){
		Map<String,Object> insert = new HashMap<>();
		System.out.println(detectedTypeId+","+detectedObjectsName);
		insert.put("detected_type_id", detectedTypeId);
		insert.put("detected_objects_name", detectedObjectsName);
		EditObject editParm = new EditObject(insert, "detected_object"); 
		int Result = editService.edit(editParm);
		return "redirect:/detect/listAllDectect";
	}
	
	/**
	 * 添加检测内容
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/addContent")
	public Object addContent(@RequestParam("categoryId")String categoryId,@RequestParam("name")String detectionMaterialName,HttpServletRequest request, HttpServletResponse response){
		Map<String,Object> insert = new HashMap<>();
		System.out.println(categoryId+","+detectionMaterialName);
		insert.put("category_id", categoryId);
		insert.put("detection_material_name", detectionMaterialName);
		EditObject editParm = new EditObject(insert, "detection_material"); 
		int Result = editService.edit(editParm);
		return "redirect:/detect/listAllDectect";
	}
	
	/**
	 * 添加分类
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/addCategory")
	public Object addCategory(@RequestParam("type")String type,@RequestParam("name")String name,HttpServletRequest request, HttpServletResponse response){
		/**
		 * 传入参数type和name
		 * type 0=检测内容分类	1=被检测物一级分类	2=被检测物二级分类
		 * name 分类名称
		 * */
		Map<String,Object> insert = new HashMap<>();
		EditObject editParm=new EditObject(insert, null);
		System.out.println(name+","+type);
		try {
			if (("0").equals(type)) {
				insert.put("category__name", name);
				editParm = new EditObject(insert, "detection_material_category"); 
			} else if (("1").equals(type)) {
				insert.put("first_classification", name);
				editParm = new EditObject(insert, "detected_category"); 
			}else if (("2").equals(type)) {
				/*insert.put("secondary_classification_id", secId);*/
				insert.put("secondary_classification", name);
				editParm = new EditObject(insert, "detected_category"); 
			}
			int Result = editService.edit(editParm);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/detect/listAllDectect";
	}
	
	/**
	 * 修改被检测物
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/updateDetected")
	public Object updateDetected(@RequestParam("detectedObjectsId")Long detectedObjectsId,@RequestParam("detectedObjectsName")String detectedObjectsName,HttpServletRequest request, HttpServletResponse response){
		//往model中添加数据
        Map<String,Object> condition = new HashMap<>();
        condition.put("detected_objects_id",detectedObjectsId);
        Map<String,Object> updateMap = new HashMap<>();
        updateMap.put("detected_objects_name", detectedObjectsName);
        EditObject editParm = new EditObject("detected_object", updateMap, condition, null);
        int Result = editService.edit(editParm);
        System.out.println(detectedObjectsId+","+detectedObjectsName);
        return "redirect:/detect/listAllDectect";
	}
	
	/**
	 * 修改检测内容
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/updateContent")
	public Object updateContent(@RequestParam("detectionMaterialId")Long detectionMaterialId,@RequestParam("detectionMaterialName")String detectionMaterialName,HttpServletRequest request, HttpServletResponse response){
		//往model中添加数据
        Map<String,Object> condition = new HashMap<>();
        condition.put("detection_material_id",detectionMaterialId);
        Map<String,Object> updateMap = new HashMap<>();
        updateMap.put("detection_material_name", detectionMaterialName);
        EditObject editParm = new EditObject("detection_material", updateMap, condition, null);
        int Result = editService.edit(editParm);
        System.out.println(detectionMaterialId+","+detectionMaterialName);
        return "redirect:/detect/listAllContent";
	}
	
	/**
	 * 删除被检测物和检测内容
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/deleteDecAndCon")
	public Object deleteDecAndCon(@RequestParam("detectedObjectsId")Long detectedObjectsId,HttpServletRequest request, HttpServletResponse response){
		Map<String,Object> condition = new HashMap<>();
        condition.put("detected_objects_id",detectedObjectsId);
        EditObject editParm = new EditObject("detected_object",condition, null);
        int Result = editService.edit(editParm);
        System.out.println("============");
        System.out.println(detectedObjectsId);
        return renderSuccess("success");
	}
	
	
	/**
	 * 查询所有被检测物 ---普通请求
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/listAllDectect")
	public ModelAndView listAllDectect(HttpServletRequest request, HttpServletResponse response){
		//传给模板用来存储数据的model
        Map<String, Object> model = new HashMap<String, Object>();
        ModelAndView modelAndView = new ModelAndView();
        //往model中添加数据
        Map<String,Object> condition = new HashMap<>();
        QueryObject queryParm = new QueryObject("dec_cate_mv", condition, null, null, null);
        List<HashMap<String,Object>> queryResult = queryService.query(queryParm);
        List<DetectedObject> decInfoList  = getBeanList(queryResult, DetectedObject.class);
        modelAndView.addObject(decInfoList);
        List<DetectedCategory> cateInfoList  = getBeanList(queryResult, DetectedCategory.class);
        modelAndView.addObject(cateInfoList);
        modelAndView.setViewName("/substance/substanceManage");
        
        return modelAndView;
	}
	
	/**
	 * 查询所有被检测物的分类 ----ajax请求
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/ajax/listAllDectectCategory")
	public Object listAllDectectCategory(HttpServletRequest request, HttpServletResponse response){
		//传给模板用来存储数据的model
        Map<String, Object> model = new HashMap<String, Object>();
        ModelAndView modelAndView = new ModelAndView();
        //往model中添加数据
        Map<String,Object> condition = new HashMap<>();
        QueryObject queryParm = new QueryObject("detected_category", condition, 0, 1000, null);
        List<HashMap<String,Object>> queryResult = queryService.query(queryParm);
        //queryresult查出来了 但是getBeanList封装bean根据类来来的，不能对两个类分开封装
        List<DetectedCategory> DecCateInfoList  = getBeanList(queryResult, DetectedCategory.class);
        modelAndView.addObject(queryResult);
        modelAndView.setViewName("/substance/substanceManage");
        for(DetectedCategory l1 : DecCateInfoList) {
      	  System.out.println(l1.toString());
      	}
       
        model.put("DecCateInfoList",DecCateInfoList);
        return renderSuccess(model);
	}
	
	
	/**
	 * 查询所有检测内容的分类
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/listAllContentCategory")
	public ModelAndView listAllContentCategory(HttpServletRequest request, HttpServletResponse response){
		//传给模板用来存储数据的model
        Map<String, Object> model = new HashMap<String, Object>();
        ModelAndView modelAndView = new ModelAndView();
        //往model中添加数据
        Map<String,Object> condition = new HashMap<>();
        QueryObject queryParm = new QueryObject("detection_material_category", condition, null, null, null);
        List<HashMap<String,Object>> queryResult = queryService.query(queryParm);
        List<DetectionMaterialCategory> ConCateInfoList  = getBeanList(queryResult, DetectionMaterialCategory.class);
        modelAndView.addObject(ConCateInfoList);
        modelAndView.setViewName("/substance/substanceManage");
        for(DetectionMaterialCategory l1 : ConCateInfoList) {
        	  System.out.println(l1.getCategoryName());
        	}
        return modelAndView;
	}
	
	/**
	 * 查询所有检测内容的分类 -------ajax请求
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/query/ajax")
	public Object listAllContentCategoryAjax(HttpServletRequest request, HttpServletResponse response){
		//传给模板用来存储数据的model
        Map<String, Object> model = new HashMap<String, Object>();
        ModelAndView modelAndView = new ModelAndView();
        //往model中添加数据
        Map<String,Object> condition = new HashMap<>();
        QueryObject queryParm = new QueryObject("detection_material_category", condition, null, null, null);
        List<HashMap<String,Object>> queryResult = queryService.query(queryParm);
        List<DetectionMaterialCategory> ConCateInfoList  = getBeanList(queryResult, DetectionMaterialCategory.class);
        for(DetectionMaterialCategory d : ConCateInfoList){
        	System.out.println(d.toString());
        }
        model.put("ConCateInfoList",ConCateInfoList);
        return renderSuccess(model);
	}
	
	
	/**
	 * 查询所有检测内容
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/listAllContent")
	public ModelAndView listAllContent(HttpServletRequest request, HttpServletResponse response){
		//传给模板用来存储数据的model
        Map<String, Object> model = new HashMap<String, Object>();
        ModelAndView modelAndView = new ModelAndView();
        //往model中添加数据
        Map<String,Object> condition = new HashMap<>();
        QueryObject queryParm = new QueryObject("detection_material", condition, 0, 1000, null);
        List<HashMap<String,Object>> queryResult = queryService.query(queryParm);
        List<DetectionMaterial> ConInfoList  = getBeanList(queryResult, DetectionMaterial.class);
        modelAndView.addObject(ConInfoList);
        modelAndView.setViewName("/substance/substanceManage");
        for(DetectionMaterial l1 : ConInfoList) {
        	  System.out.println(l1.getDetectionMaterialName());
        	}
        return modelAndView;
	}
	
	/**
	 * 查询单条被检测物
	 * 2018年1月21日
	 * @param request	
	 * @param response
	 * @return
	 */
	@RequestMapping("/listDectectById")
	public ModelAndView listDectectById(@RequestParam("detectedObjectsId")Long detectedObjectsId,HttpServletRequest request, HttpServletResponse response){
		//传给模板用来存储数据的model
        Map<String, Object> model = new HashMap<String, Object>();
        ModelAndView modelAndView = new ModelAndView();
        //往model中添加数据
        Map<String,Object> condition = new HashMap<>();
        condition.put("detected_objects_id", detectedObjectsId);
        QueryObject queryParm = new QueryObject("detected_object", condition, null, null, null);
        List<HashMap<String,Object>> queryResult = queryService.query(queryParm);
        List<DetectedObject> DecInfoList  = getBeanList(queryResult, DetectedObject.class);
        modelAndView.addObject(DecInfoList);
        modelAndView.setViewName("/substance/substanceManage");
        return modelAndView;
	}
	
}
