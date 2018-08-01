package bluedot.spectrum.service.impl;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;

import bluedot.spectrum.common.Singleton;
import bluedot.spectrum.common.SpectrumAnalysisTask;
import bluedot.spectrum.common.SpectrumTaskProduce;
import bluedot.spectrum.commons.vo.Point;
import bluedot.spectrum.commons.vo.SpectrumFile;
import bluedot.spectrum.service.AlgorithmService;
import bluedot.spectrum.service.SpectrumService;
import bluedot.spectrum.util.FileUtil;
import jxau.spectrum.frame.web.annotation.Autowired;
import jxau.spectrum.frame.web.annotation.Service;
/**
 * 
 * @author Aaron
 *
 */
@Service
public class SpectrumServiceImpl implements SpectrumService {

	@Autowired
	private AlgorithmService algorithmService;
	
	private ExecutorService executor = Executors.newFixedThreadPool(10);
	
	
	@Override
	public SpectrumFile resolveSpectrum(String fileUrl) {
		BufferedReader reader = null;
		try {
			reader = FileUtil.getBufferedReader(fileUrl);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		String tempString = null;
		SpectrumFile spectrumFile = null;
        try {
        	spectrumFile = new SpectrumFile();
        	List<Point> points = new ArrayList<Point>();
			while ((tempString = reader.readLine()) != null) {
			     String[] str = tempString.split(" ");
			     if(str.length!=2){
			    	 //异常
			     }
			     String x = str[0];
			     String y = str[1];
			     Point point = new Point();
			     point.setX(Double.parseDouble(x.trim()));
			     point.setY(Double.parseDouble(y.trim()));
			     points.add(point);
			}
			spectrumFile.setPoints(points);
		}catch (IOException e) {
			e.printStackTrace();
		}
        try {
			reader.close();
		}catch (IOException e) {
			e.printStackTrace();
		}
        System.out.println(spectrumFile);
		return spectrumFile;
	}

	@Override
	public SpectrumFile pretreatment(SpectrumFile spectrum,String algorithmPath) {
		return algorithmService.pretreatmentAlgorithm(algorithmPath, spectrum);
	}

	

	@Override
	public Map<String, Object> statisticalAnalysis(Map<String, Object> condition) {
		return null;
	}
	
	public String serialSpectrumObject(SpectrumFile spectrum) throws IOException{
		String filePath  = spectrum.getFileDir();
		int index = filePath.lastIndexOf('.');
		filePath = filePath.substring(0, index);
		filePath += ".json";
		Gson gson = new Gson();
		BufferedWriter writer = new BufferedWriter(new FileWriter(new File(filePath)));
		gson.toJson(spectrum,writer);
		writer.close();
		return filePath;
	}
	
	public Object parserToJSON(String url) throws JsonIOException, JsonSyntaxException, FileNotFoundException{
		 JsonParser js = new JsonParser();
		 JsonObject json = (JsonObject) js.parse(new FileReader(new File(url)));
		 return json;
	}
	
	public SpectrumFile JsonToObject(String url) throws JsonIOException, JsonSyntaxException, FileNotFoundException{
		 JsonParser js = new JsonParser();
		 JsonObject json = (JsonObject) js.parse(new FileReader(new File(url)));
		 Gson gson = new Gson();
		 SpectrumFile spectrum = gson.fromJson(json,SpectrumFile.class);  
		 return spectrum;
	}

	/**
	 * 将光谱任务提交
	 */
	@Override
	public boolean analysisSpectrum(SpectrumFile spectrum, List<String> algorithmPathList, Long id) {
		SpectrumAnalysisTask task = new SpectrumAnalysisTask(id, spectrum, algorithmPathList);
		SpectrumTaskProduce produce = new SpectrumTaskProduce(task, algorithmService, Singleton.INSTANCE.getInstance());
		executor.execute(produce);
		return true;
	}
}
