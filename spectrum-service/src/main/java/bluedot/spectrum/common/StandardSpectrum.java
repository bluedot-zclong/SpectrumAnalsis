package bluedot.spectrum.common;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.HashMap;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;

import bluedot.spectrum.commons.vo.SpectrumFile;

public class StandardSpectrum {
	HashMap<String,SpectrumFile> map = new HashMap<>();
	StandardSpectrum(){
		SpectrumFile spectrum = init("C:\\Users\\WFP\\Desktop\\蓝点\\光谱第二版本\\巫发萍\\20180515\\光谱\\笨.json");
		map.put("笨", spectrum);
		spectrum = init("C:\\Users\\WFP\\Desktop\\蓝点\\光谱第二版本\\巫发萍\\20180515\\光谱\\铁.json");
		map.put("铁", spectrum);
		spectrum = init("C:\\Users\\WFP\\Desktop\\蓝点\\光谱第二版本\\巫发萍\\20180515\\光谱\\蛋白质.json");
		map.put("蛋白质", spectrum);
	}
	
	public SpectrumFile getSpectrumFileByName(String key){
		return map.containsKey(key)?map.get(key):null;
	}
	
	private SpectrumFile init(String url){
		 JsonParser js = new JsonParser();
		 JsonObject json = null;
		try {
			json = (JsonObject) js.parse(new FileReader(new File(url)));
		} catch (JsonIOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonSyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 Gson gson = new Gson();
		 SpectrumFile spectrum = gson.fromJson(json,SpectrumFile.class);  
		 return spectrum;
	}
}
