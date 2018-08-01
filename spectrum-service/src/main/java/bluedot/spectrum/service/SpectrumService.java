package bluedot.spectrum.service;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonSyntaxException;

import bluedot.spectrum.commons.vo.SpectrumFile;

/**
 * 光谱模块
 * @author zclong
 * 2018年1月20日
 */
public interface SpectrumService {

	/**
	 * 解析光谱
	 * 2018年1月20日
	 * zclong
	 * @param fileUrl 光谱路径
	 * @return T 光谱对象
	 */
	SpectrumFile resolveSpectrum(String fileUrl);
	 
	 /**
	  * 光谱预处理
	  * 2018年1月20日
	  * zclong
	  * @param clazz 光谱对象
	  * @return T 光谱对象
	  */
	SpectrumFile pretreatment(SpectrumFile spectrum,String algorithmPath);
	 
	 /**
	  * 光谱分析
	  * 2018年1月20日
	  * zclong
	  * @param clazz
	  * @return
	  */
	boolean analysisSpectrum(SpectrumFile spectrum,List<String> algorithmPathList,Long id);
	 
	 /**
	  * 统计分析
	  * 2018年1月20日
	  * zclong
	  * @param condition ： 条件
	  * @return 
	  */
	 Map<String, Object> statisticalAnalysis(Map<String, Object> condition);

	 public Object parserToJSON(String url) throws JsonIOException, JsonSyntaxException, FileNotFoundException;
	 public String serialSpectrumObject(SpectrumFile spectrum) throws IOException;
	 public SpectrumFile JsonToObject(String url) throws JsonIOException, JsonSyntaxException, FileNotFoundException;
}
