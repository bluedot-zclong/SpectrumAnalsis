package bluedot.spectrum.web.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.google.gson.JsonSyntaxException;

import bluedot.spectrum.common.EditObject;
import bluedot.spectrum.common.QueryObject;
import bluedot.spectrum.common.Report;
import bluedot.spectrum.common.Singleton;
import bluedot.spectrum.common.SpectrumResultSet;
import bluedot.spectrum.commons.entity.Algorithm;
import bluedot.spectrum.commons.entity.ConnectionAlgorithmDetectedObject;
import bluedot.spectrum.commons.entity.ConnectionAlgorithmDetectionMaterial;
import bluedot.spectrum.commons.entity.DetectedObject;
import bluedot.spectrum.commons.entity.Dir;
import bluedot.spectrum.commons.entity.Hardware;
import bluedot.spectrum.commons.entity.SpectrumType;
import bluedot.spectrum.commons.entity.Spectruminfo;
import bluedot.spectrum.commons.entity.User;
import bluedot.spectrum.commons.vo.DetechLine;
import bluedot.spectrum.commons.vo.SpectrumFile;
import bluedot.spectrum.service.EditService;
import bluedot.spectrum.service.QueryService;
import bluedot.spectrum.service.SpectrumService;
import bluedot.spectrum.utils.upload.FileDirType;
import bluedot.spectrum.utils.upload.FormData;
import bluedot.spectrum.utils.upload.ParseFile;
import bluedot.spectrum.web.core.ModelAndView;
import jxau.spectrum.frame.web.annotation.Autowired;
import jxau.spectrum.frame.web.annotation.Controller;
import jxau.spectrum.frame.web.annotation.RequestMapping;
import jxau.spectrum.frame.web.annotation.RequestParam;

/**
 * 光谱业务
 * 
 * @author wfp
 *
 */
@Controller
@RequestMapping("/spectrum")
public class SpectrumController extends BaseController {

	@Autowired
	private QueryService queryService;

	@Autowired
	private EditService editService;

	@Autowired
	private SpectrumService spectrumService;

	/**
	 * 查询光谱---ajax请求 WFP
	 * 
	 * @param req
	 * @param resp
	 * @return 2018年1月21日
	 */
	@RequestMapping("/query/ajax")
	public Object querySpectrumAjax(@RequestParam("spectrumId") Integer id, HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> condition = new HashMap<>();
		condition.put("spectruminfo_id", id);
		QueryObject queryParm = new QueryObject("spectruminfo", condition, 0, 1, null);
		List<HashMap<String, Object>> queryResult = queryService.query(queryParm);
		List<Spectruminfo> spectrumInfo = getBeanList(queryResult, Spectruminfo.class);
		Spectruminfo spectrum = spectrumInfo.get(0);
		
		condition.clear();
		condition.put("detected_objects_id", spectrum.getDetectedId());
		queryParm = new QueryObject("detected_object", condition, 0, 1, null);
		queryResult = queryService.query(queryParm);
		List<DetectedObject> detectedObjectList = getBeanList(queryResult, DetectedObject.class);
		DetectedObject detectedObject = detectedObjectList.get(0);
		
		condition.clear();
		queryParm = new QueryObject("spectrum_type", condition, null, null, null);
		queryResult = queryService.query(queryParm);
		List<SpectrumType> spectrumTypeList = getBeanList(queryResult, SpectrumType.class);
		
		condition.clear();
		User user = (User)req.getSession().getAttribute("userSession");
		condition.put("user_id", user.getUserId());
		condition.put("dir_type_id", 0);
		queryParm = new QueryObject("dir", condition, null, null, null);
		queryResult = queryService.query(queryParm);
		List<Dir> fileList = getBeanList(queryResult, Dir.class);
		
		Map<String,Object> map = new HashMap<>();
		map.put("spectrum", spectrum);
		map.put("spectrumType", spectrumTypeList);
		map.put("fileList", fileList);
		map.put("detectedObject",detectedObject);
		return renderSuccess(map);
	}

	/**
	 * 查询光谱---普通请求 WFP
	 * 
	 * @param req
	 * @param resp
	 * @return 2018年1月21日
	 */
	@RequestMapping("/showSpectrumInfo")
	public ModelAndView querySpectrum(@RequestParam("id") Integer id, HttpServletRequest req,
			HttpServletResponse resp) {
		ModelAndView modelAndView = new ModelAndView();
		Map<String, Object> condition = new HashMap<>();
		condition.put("spectruminfo_id", id);
		QueryObject queryParm = new QueryObject("spectruminfo", condition, 0, 1, null);
		List<HashMap<String, Object>> queryResult = queryService.query(queryParm);
		List<Spectruminfo> spectrumInfo = getBeanList(queryResult, Spectruminfo.class);
		modelAndView.addObject("spectrum", spectrumInfo.get(0));
		modelAndView.setViewName("/spectrum/spectruminfo");
		return modelAndView;
	}

	/**
	 * 更新光谱(更新)  未完成 和序列化未关联
	 * 
	 * @param req
	 * @param resp
	 * @return 2018年1月21日
	 */
	@RequestMapping("/update")
	public ModelAndView updateSpectrumAjax(HttpServletRequest req, HttpServletResponse resp) {
		String spectrumName = req.getParameter("spectrumName");
		String spectruminfoId = req.getParameter("spectruminfoId");
		String categoryOrigin = req.getParameter("categoryOrigin");
		String detectedId = req.getParameter("detectedId");
		String spectrumTypeName = req.getParameter("spectrumTypeName");
		String fileId = req.getParameter("fileId");
		String XUnit = req.getParameter("XUnit");
		String YUnit = req.getParameter("YUnit");
		String spectrumDescription = req.getParameter("spectrumDescription");
		System.out.println("fileId:"+fileId);
		Map<String,Object> updateMap = new HashMap<>();
		updateMap.put("spectrum_name", spectrumName);
		updateMap.put("category_origin", categoryOrigin);
		updateMap.put("detected_id", Integer.parseInt(detectedId));
		updateMap.put("spectrum_type_name", spectrumTypeName);
		updateMap.put("file_id", fileId);
		updateMap.put("spectrum_description", spectrumDescription);
		Map<String ,Object> condition = new HashMap<>();
        condition.put("spectruminfo_id", Integer.parseInt(spectruminfoId));
        EditObject editParm = new EditObject("spectruminfo", updateMap, condition, null);
        editService.edit(editParm);
		return querySpectrum(Integer.parseInt(spectruminfoId), req, resp);
	}

	/**
	 * 删除光谱---ajax请求 WFP
	 * 
	 * @param req
	 * @param resp
	 * @return 2018年1月21日
	 */
	@RequestMapping("/delete/ajax")
	public Object deleteSpectrumAjax(@RequestParam("spectrumId") Integer id, HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> condition = new HashMap<>();
		condition.put("spectruminfo_id", id);
		Map<String, Object> updateMap = new HashMap<>();
		updateMap.put("is_delete", 1);
		EditObject editParm = new EditObject("spectruminfo", updateMap, condition, null);
		int Result = editService.edit(editParm);
		return renderSuccess();
	}

	/**
	 * 光谱分析
	 * @param spectrumId
	 * @param pretreatmentAlgorithmId
	 * @param analysisAlgorithmId
	 * @param req
	 * @param resp
	 * @return
	 */
	private boolean analysisSpectrum(@RequestParam("spectrumId")Integer spectrumId,@RequestParam("pretreatmentAlgorithmId")Integer pretreatmentAlgorithmId,@RequestParam("analysisAlgorithmId")Integer analysisAlgorithmId,HttpServletRequest req, HttpServletResponse resp) {
		/** 获取光谱对象 */
		Map<String, Object> condition = new HashMap<>();
		condition.put("spectruminfo_id", spectrumId);
		QueryObject queryParm = new QueryObject("spectruminfo", condition, 0, 1, null);
		List<HashMap<String, Object>> queryResult = queryService.query(queryParm);
		List<Spectruminfo> spectrumInfo = getBeanList(queryResult, Spectruminfo.class);
		SpectrumFile spectrum = null;
		try {
			spectrum = spectrumService.JsonToObject(spectrumInfo.get(0).getSpectrumFileUrl());
		} catch (JsonIOException | JsonSyntaxException | FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/** 预处理算法处理 */
		condition.clear();
		condition.put("algorithm_id", pretreatmentAlgorithmId);
		queryParm = new QueryObject("algorithm", condition, 0, 1, null);
		queryResult = queryService.query(queryParm);
		List<Algorithm> pretreatmentAlgorithmList = getBeanList(queryResult, Algorithm.class);
		
		/** 分析算法处理   */
		condition.clear();
		condition.put("algorithm_id", analysisAlgorithmId);
		queryParm = new QueryObject("algorithm", condition, 0, 1, null);
		queryResult = queryService.query(queryParm);
		List<Algorithm> analysisAlgorithmList = getBeanList(queryResult, Algorithm.class);
		
		List<String> algorithmPathList = new ArrayList<>();
		algorithmPathList.add(pretreatmentAlgorithmList.get(0).getAlgorithmRealPath());
		algorithmPathList.add(analysisAlgorithmList.get(0).getAlgorithmRealPath());
		
		User user = (User)req.getSession().getAttribute("userSession");
		boolean flag = spectrumService.analysisSpectrum(spectrum, algorithmPathList, user.getUserId());
		return flag;
	}

	/**
	 * 取得光谱点数据---ajax请求 WFP
	 * 
	 * @param req
	 * @param resp
	 * @return 2018年1月21日
	 */
	@RequestMapping("/getPoint/ajax")
	public Object getPointSpectrumAjax(HttpServletRequest req, HttpServletResponse resp) {

		return renderSuccess();
	}

	/**
	 * 导出光谱图片---ajax请求 WFP
	 * 
	 * @param req
	 * @param resp
	 * @return 2018年1月21日
	 */
	@RequestMapping("/exportimage/ajax")
	public Object exportImageSpectrumAjax(HttpServletRequest req, HttpServletResponse resp) {

		return renderSuccess();
	}

	/**
	 * 查询光谱类型---ajax请求 WFP
	 * 
	 * @param req
	 * @param resp
	 * @return 2018年1月21日
	 */
	@RequestMapping("/querytype/ajax")
	public Object queryTypeSpectrumAjax(HttpServletRequest req, HttpServletResponse resp) {

		return renderSuccess();
	}

	/**
	 * 查询光谱类型---普通请求 WFP
	 * 
	 * @param req
	 * @param resp
	 * @return 2018年1月21日
	 */
	@RequestMapping("/querytype")
	public Object queryTypeSpectrum(HttpServletRequest req, HttpServletResponse resp) {
		// 传给模板用来存储数据的model
		Map<String, Object> model = new HashMap<String, Object>();
		ModelAndView modelAndView = new ModelAndView();

		// 往model中添加数据

		modelAndView.addAllObjects(model);
		modelAndView.setViewName("/");
		return modelAndView;
	}

	/**
	 * 更新光谱类型---ajax请求 WFP
	 * 
	 * @param req
	 * @param resp
	 * @return 2018年1月21日
	 */
	@RequestMapping("/updatetype/ajax")
	public Object updateTypeSpectrumAjax(HttpServletRequest req, HttpServletResponse resp) {
		return renderSuccess();
	}
	
	/**
	 * 上传之前的显示下拉框，还差被检测物
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping("/getSpectrumType/ajax")
	public Object getSpectrumTypeAjax(HttpServletRequest req, HttpServletResponse resp) {
		
		QueryObject queryParm = new QueryObject("spectrum_type", null, null, null, null);
		List<HashMap<String, Object>> queryResult = queryService.query(queryParm);
		List<SpectrumType> spectrumTypeList = getBeanList(queryResult, SpectrumType.class);
		
		queryParm = new QueryObject("hardware", null, null, null, null);
		queryResult = queryService.query(queryParm);
		List<Hardware> hardwareList = getBeanList(queryResult, Hardware.class);
		Map<String,Object> map = new HashMap<>();
		map.put("spectrumTypeList", spectrumTypeList);
		map.put("hardwareList", hardwareList);
		return renderSuccess(map);
	}
	
	/**
	 * 上传---ajax请求
	 */
	@RequestMapping("/upload/ajax")
	public Object uploadSpectrum(HttpServletRequest req, HttpServletResponse resp){
		Map<String,FormData>  formDatas = new HashMap();
		//获取请求头ContentType属性，判断该请求是否为multipart/form-data类型
		String contentType = req.getContentType();
		//当且仅当ContentType属性不为空，且为multipart/form-data类型时，才会执行解析表单流
		if(contentType != null && contentType.startsWith("multipart/form-data")){			
			formDatas =  ParseFile.parseForm(req,FileDirType.SPECTRUM);
		}
		SpectrumFile spectrumFile = spectrumService.resolveSpectrum(formDatas.get("file").getFilePath());
		spectrumFile.setxAsix(formDatas.get("XUnit").getValue());
		spectrumFile.setyAsix(formDatas.get("YUnit").getValue());
		spectrumFile.setFileName(formDatas.get("spectrumName").getValue());
		spectrumFile.setFileDir(formDatas.get("file").getFilePath());
		String jsonPath = null;
		try {
			jsonPath = spectrumService.serialSpectrumObject(spectrumFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		Map<String, Object> insert = new HashMap<>();
		insert.put("spectrum_name", formDatas.get("spectrumName").getValue());
		insert.put("category_origin", formDatas.get("categoryOrigin").getValue());
		insert.put("detected_id", formDatas.get("detectedId").getValue());
		insert.put("spectrum_type_name", formDatas.get("spectrumTypeName").getValue());
		insert.put("spectrum_description", formDatas.get("description").getValue());
		insert.put("spectrum_file_url", jsonPath);
		insert.put("save_time", new Date());
		insert.put("file_id", formDatas.get("fileId").getValue());
		insert.put("hardware_name", formDatas.get("hardware").getValue());
		EditObject editParm = new EditObject(insert,"spectruminfo");
		int Result = editService.edit(editParm);
		return renderSuccess();
	}
	
	/**
	 * 得到光谱图
	 * 
	 * @param req
	 * @param resp
	 * @return 2018年1月21日
	 */
	@RequestMapping("/getSpectrumImage/ajax")
	public Object getSpectrumImageAjax(@RequestParam("spectrumId") Integer id,HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> condition = new HashMap<>();
		condition.put("spectruminfo_id", id);
		QueryObject queryParm = new QueryObject("spectruminfo", condition, 0, 1, null);
		List<HashMap<String, Object>> queryResult = queryService.query(queryParm);
		List<Spectruminfo> spectrumInfo = getBeanList(queryResult, Spectruminfo.class);
		Spectruminfo spectrum = spectrumInfo.get(0);
		
		String url = spectrum.getSpectrumFileUrl();
		Object obj = null;
		try {
			obj = spectrumService.parserToJSON(url);
		} catch (JsonIOException | JsonSyntaxException | FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return renderSuccess(obj);
	}
	
	/**
	 * 查询检验线---普通请求
	 * 
	 * @param req
	 * @param resp
	 * @return
	 * 2018年1月21日
	 */
	@RequestMapping("/queryDetechLine")
	public ModelAndView queryConnectionAlgorithm (@RequestParam("id")String id, HttpServletRequest req, HttpServletResponse resp){
		System.out.println("****"+id);
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
        modelAndView.addObject("spectrumId", id);
        Gson create = new GsonBuilder().setPrettyPrinting().create();
        System.out.println(create.toJson(beanList));
        modelAndView.addObject("detectLinesJson", create.toJson(beanList));
        
        modelAndView.setViewName("/spectrum/detectLine");
        return modelAndView;
	}
	
	@RequestMapping("/getAnalysisReport")
	public ModelAndView getAnalysisReport (HttpServletRequest req, HttpServletResponse resp){
		ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/spectrum/analysisInfo");
        SpectrumResultSet set = Singleton.INSTANCE.getInstance();
        User user = (User)req.getSession().getAttribute("userSession");
        LinkedList<Report> list = set.getSpectrumSet(user.getUserId());
        modelAndView.addObject("spetrumList", list);
        return modelAndView;
	}
	
	@RequestMapping("/analysis")
	public Object analysis(@RequestParam("spectrumId")String ids,@RequestParam("pretreatmentAlgorithmId")Integer pretreatmentAlgorithmId,@RequestParam("analysisAlgorithmId")Integer analysisAlgorithmId,HttpServletRequest req, HttpServletResponse resp){
		String[] array = ids.split(",");
		int length = array.length;
		boolean flag = true;
		for(int i=0;i<length;i++){
			Integer spectrumId = Integer.parseInt(array[i]);
			flag &= analysisSpectrum(spectrumId, pretreatmentAlgorithmId, analysisAlgorithmId, req, resp);
		}
		return renderSuccess(flag);
	}
	
	@RequestMapping("/reportById")
	public ModelAndView reportById(HttpServletRequest req, HttpServletResponse resp,@RequestParam("id") Integer index){
		ModelAndView modelAndView = new ModelAndView();
		SpectrumResultSet set = Singleton.INSTANCE.getInstance();
        User user = (User)req.getSession().getAttribute("userSession");
        Report report = set.getSpectrumByIndex(user.getUserId(), index);
        modelAndView.addObject("report", report);
        modelAndView.setViewName("/spectrum/analysisreport");
        return modelAndView;
	}
}
