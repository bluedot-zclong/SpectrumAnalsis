package bluedot.spectrum.web.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.tools.doclets.formats.html.SourceToHTMLConverter;

import bluedot.spectrum.common.EditObject;
import bluedot.spectrum.common.QueryObject;
import bluedot.spectrum.commons.entity.Algorithm;
import bluedot.spectrum.commons.entity.Dir;
import bluedot.spectrum.commons.entity.User;
import bluedot.spectrum.service.AlgorithmService;
import bluedot.spectrum.service.EditService;
import bluedot.spectrum.service.QueryService;
import bluedot.spectrum.service.impl.AlgorithmServiceImpl;
import bluedot.spectrum.utils.upload.FileDirType;
import bluedot.spectrum.utils.upload.FormData;
import bluedot.spectrum.utils.upload.ParseFile;
import bluedot.spectrum.web.core.ModelAndView;
import jxau.spectrum.frame.web.annotation.Autowired;
import jxau.spectrum.frame.web.annotation.Controller;
import jxau.spectrum.frame.web.annotation.RequestMapping;
import jxau.spectrum.frame.web.annotation.RequestParam;

/**
 * 算法业务
 * @author 巫发萍
 * 2018年1月20日
 */
@Controller
@RequestMapping("/algorithm")
public class AlgorithmController extends BaseController {

	@Autowired
	private QueryService queryService;
	@Autowired
	private EditService editService;
	
	AlgorithmServiceImpl algorithmService = new AlgorithmServiceImpl();
	
	/**
	 * 查询算法---ajax请求
	 * WFP
	 * @param req
	 * @param resp
	 * @return
	 * 2018年1月21日
	 */
	@RequestMapping("/query/ajax")
	public Object queryAlgorithmAjax(HttpServletRequest req, HttpServletResponse resp,
			@RequestParam("algorithmId")Integer algorithmId){
		Map<String ,List> model = new HashMap<>();
		
		//查询该算法信息
		Map<String ,Object> condition = new HashMap<>();
		condition.put("algorithm_id", algorithmId);
		QueryObject queryParm = new QueryObject("algorithm", condition, 0, 1, null);
		List<HashMap<String,Object>> queryResult = queryService.query(queryParm);
        List<Algorithm> algorithmList  = getBeanList(queryResult, Algorithm.class); 
        model.put("algorithmList", algorithmList);
        
        //查询该用户所有算法文件夹
        User user = (User)req.getSession().getAttribute("userSession");
        Map<String,Object> conditionDir = new HashMap<>();
        conditionDir.put("user_id", user.getUserId());
        conditionDir.put("dir_type_id", 1);
        QueryObject queryParmDir = new QueryObject("dir", conditionDir, 0, 1000, null);
        List<HashMap<String,Object>> queryResultDir = queryService.query(queryParmDir);
        List<Dir> dirInfoList  = getBeanList(queryResultDir, Dir.class);
        model.put("dirInfoList", dirInfoList);
        
        return renderSuccess(model);
        
        
	}
	
	/**
	 * 查询算法---普通请求
	 * WFP
	 * @param req
	 * @param resp
	 * @return
	 * 2018年1月21日
	 */
	@RequestMapping("/query")
	public ModelAndView queryAlgorithm(HttpServletRequest req, HttpServletResponse resp){
		//传给模板用来存储数据的model
        Map<String, Object> model = new HashMap<String, Object>();
        ModelAndView modelAndView = new ModelAndView();
        
        //往model中添加数据
        
        modelAndView.addAllObjects(model);
        modelAndView.setViewName("/algorithm/algorithmFile");
        return modelAndView;
	}
	
	/**
	 * 更新算法---ajax请求
	 * WFP
	 * @param req
	 * @param resp
	 * @return
	 * 2018年1月21日
	 */
	@RequestMapping("/update/ajax")
	public Object updateAlgorithm(HttpServletRequest req, HttpServletResponse resp){
		Algorithm algorithm = getBean(req, Algorithm.class);
		Map<String,Object> updateMap = new HashMap<>();
		updateMap.put("algorithm_name", algorithm.getAlgorithmName());
		updateMap.put("algorithm_version", algorithm.getAlgorithmVersion());
		updateMap.put("algorithm_language", algorithm.getAlgorithmLanguage());
		updateMap.put("algorithm_dscription", algorithm.getAlgorithmDscription());
		updateMap.put("algorithm_sort", algorithm.getAlgorithmSort());
		updateMap.put("dir_file_id", algorithm.getDirFileId());
		Map<String ,Object> condition = new HashMap<>();
        condition.put("algorithm_id", algorithm.getAlgorithmId());
        EditObject editParm = new EditObject("algorithm", updateMap, condition, null);
        int Result = editService.edit(editParm);
        if(Result>0){
        	return renderSuccess("success");
        }else{
        	return renderError("false");
        }
	}
	
	/**
	 * 删除算法---ajax请求
	 * WFP
	 * @param req
	 * @param resp
	 * @return
	 * 2018年1月21日
	 */
	@RequestMapping("/delete/ajax")
	public Object deleteAlgorithm(HttpServletRequest req, HttpServletResponse resp,
			@RequestParam("algorithmId")Integer algorithmId){
		Map<String,Object> updateMap = new HashMap<>();
        updateMap.put("is_deleted", 1);
		Map<String ,Object> condition = new HashMap<>();
		condition.put("algorithm_id", algorithmId);
		EditObject editObject = new EditObject("algorithm", updateMap, condition, null);
		int flag = editService.edit(editObject);
        return renderSuccess("success");
	}
	
	/**
	 * 上传算法---ajax请求
	 * WFP
	 * @param req
	 * @param resp
	 * @return
	 * 2018年1月21日
	 */
	@RequestMapping("/upload/ajax")
	public Object uploadAlgorithm(HttpServletRequest req, HttpServletResponse resp){
		Map<String,FormData>  formDatas = new HashMap();
		//获取请求头ContentType属性，判断该请求是否为multipart/form-data类型
		String contentType = req.getContentType();
		//当且仅当ContentType属性不为空，且为multipart/form-data类型时，才会执行解析表单流
		if(contentType != null && contentType.startsWith("multipart/form-data")){			
			formDatas =  ParseFile.parseForm(req,FileDirType.ALGORITHM);
		}
		
		String msg = null;
		boolean falg = algorithmService.checkAlgorithm(formDatas.get("file").getFilePath(), msg);
		if(msg!=null||!falg){
			System.out.println("编译出错："+msg);
			return renderError(msg);
		}else{
			//遍历表单数据，key对应name，value对应FormData对象
			formDatas.forEach((x,y)->System.out.println(x+"--->"+y));
			Map<String, Object> insert = new HashMap<>();
			insert.put("algorithm_version", formDatas.get("algorithmVersion").getValue());
			insert.put("algorithm_name", formDatas.get("algorithmName").getValue());
			insert.put("algorithm_sort", formDatas.get("algorithmSort").getValue());
			insert.put("algorithm_uploadtime", new Date());
			insert.put("algorithm_dscription", formDatas.get("algorithmDscription").getValue());
			insert.put("algorithm_language", "java");
			File sourceFile = new File(formDatas.get("file").getFilePath());
			insert.put("algorithm_real_path", sourceFile.getAbsoluteFile().toString().split(sourceFile.getName())[0]+"AnalyzeAlgorithm.java");
			insert.put("dir_file_id", formDatas.get("algorithmDirId").getValue());
			insert.put("is_deleted", 0);
			EditObject editParm = new EditObject(insert,"algorithm");
			int Result = editService.edit(editParm);
			System.out.println(Result);
			return renderSuccess();
		}
		
		
	}
	
	/**
	 * 下载算法---ajax请求
	 * WFP
	 * @param req
	 * @param resp
	 * @return
	 * 2018年1月21日
	 */
	@RequestMapping("/download/ajax")
	public Object downloadAlgorithm(HttpServletRequest req, HttpServletResponse resp){

        return renderSuccess();
	}
	
	
}
