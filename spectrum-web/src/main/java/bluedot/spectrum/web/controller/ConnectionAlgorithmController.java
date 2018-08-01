package bluedot.spectrum.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import bluedot.spectrum.common.QueryObject;
import bluedot.spectrum.commons.entity.Algorithm;
import bluedot.spectrum.commons.entity.ConnectionAlgorithmDetectedObject;
import bluedot.spectrum.commons.entity.ConnectionAlgorithmDetectionMaterial;
import bluedot.spectrum.commons.vo.DetechLine;
import bluedot.spectrum.service.QueryService;
import bluedot.spectrum.web.core.ModelAndView;
import jxau.spectrum.frame.web.annotation.Autowired;
import jxau.spectrum.frame.web.annotation.Controller;
import jxau.spectrum.frame.web.annotation.RequestMapping;

/**
 * 检验线业务
 * @author 巫发萍
 * 2018年1月20日
 */
@Controller
@RequestMapping("/connectionalgorithm")
public class ConnectionAlgorithmController extends BaseController{
	
	// 注入查询业务
	@Autowired
	private QueryService queryService;
	
	/**
	 * 查询检验线---ajax请求
	 * WFP
	 * @param req
	 * @param resp
	 * @return
	 * 2018年1月21日
	 */
	@RequestMapping("/query/ajax")
	public Object queryConnectionAlgorithmAjax (HttpServletRequest req, HttpServletResponse resp){

        return renderSuccess();
	}
	
	/**
	 * 查询检验线---普通请求
	 * dc
	 * @param req
	 * @param resp
	 * @return
	 * 2018年1月21日
	 */
	@RequestMapping("/query")
	public ModelAndView queryConnectionAlgorithm (HttpServletRequest req, HttpServletResponse resp){
		//传给模板用来存储数据的model
        Map<String, Object> model = new HashMap<String, Object>();
        ModelAndView modelAndView = new ModelAndView();
        //往model中添加数据
		// 数据封装
		Map<String, Object> condition = new HashMap<String, Object>();
		QueryObject queryObject = new QueryObject("detech_line", condition, null, null, null);
		// 调用查询业务，得到结果
		List<HashMap<String, Object>> queryResult = queryService.query(queryObject);
		List<DetechLine> beanList = getBeanList(queryResult, DetechLine.class);
		beanList.forEach(i -> {
			/**
			 * 查询预处理算法
			 */
			condition.clear();
			condition.put("algorithm_id", i.getPretreatmentAlgorithmId());
			queryObject.setViewName("algorithm");
			List<HashMap<String, Object>> list = queryService.query(queryObject);
			Algorithm bean = getBean(list, Algorithm.class);
			i.setPretreatmentAlgorithm(bean);
			
			/**
			 * 查询分析算法
			 */
			condition.clear();
			condition.put("algorithm_id", i.getAnalysisAlgorithmId());
			queryObject.setViewName("algorithm");
			list = queryService.query(queryObject);
			bean = getBean(list, Algorithm.class);
			i.setAnalysisAlgorithm(bean);
			
			/**
	        * 查询检验线的检验的对象
	        * dc 
	        */
			condition.clear();
	        condition.put("connection_algorithm_id", i.getConnectionAlgorithmId());
			queryObject.setViewName("connection_algorithm_detected_object");
			list = queryService.query(queryObject);
			i.setCado(getBeanList(list, ConnectionAlgorithmDetectedObject.class));
			
			/**
	        * 查询检验线的检验出的物质
	        * dc 
	        */
			ArrayList<ConnectionAlgorithmDetectionMaterial> arr = new ArrayList<>();
			i.getCado().forEach(j -> {
				condition.clear();
		        condition.put("cado_id", j.getCadoId());
				queryObject.setViewName("connection_algorithm_detection_material");
				List<HashMap<String, Object>> temp = queryService.query(queryObject);
				List<ConnectionAlgorithmDetectionMaterial> list2 = getBeanList(temp, ConnectionAlgorithmDetectionMaterial.class);
				arr.addAll(list2);
			});
			i.setCadm(arr);
			
		});
        modelAndView.addObject("detectLines", beanList);
        Gson create = new GsonBuilder().setPrettyPrinting().create();
        System.out.println(create.toJson(beanList));
        modelAndView.addObject("detectLinesJson", create.toJson(beanList));
        
        modelAndView.setViewName("/detectLine/detectLine");
        return modelAndView;
	}
	
	/**
	 * 更新检验线(更新、添加)---ajax请求
	 * WFP
	 * @param req
	 * @param resp
	 * @return
	 * 2018年1月21日
	 */
	@RequestMapping("/update/ajax")
	public Object updateConnectionAlgorithmAjax (HttpServletRequest req, HttpServletResponse resp){

        return renderSuccess();
	}
	
	/**
	 * 删除检验线---ajax请求
	 * WFP
	 * @param req
	 * @param resp
	 * @return
	 * 2018年1月21日
	 */
	@RequestMapping("/delete/ajax")
	public Object deleteConnectionAlgorithmAjax (HttpServletRequest req, HttpServletResponse resp){

        return renderSuccess();
	}
	
	/**
	 * 公开检验线---ajax请求
	 * WFP
	 * @param req
	 * @param resp
	 * @return
	 * 2018年1月21日
	 */
	@RequestMapping("/public/ajax")
	public Object publicConnectionAlgorithmAjax (HttpServletRequest req, HttpServletResponse resp){

        return renderSuccess();
	}
	
	
}
