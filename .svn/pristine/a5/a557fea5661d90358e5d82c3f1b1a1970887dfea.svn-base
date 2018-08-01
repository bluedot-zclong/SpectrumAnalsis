package bluedot.spectrum.dao;

import java.util.HashMap;
import java.util.Map;

import bluedot.spectrum.dao.entry.DataParamter;
import bluedot.spectrum.dao.entry.DataResult;
import bluedot.spectrum.dao.session.Session;


public class test {
	
	public static void main(String[] args) {
		try (Session session = new Session();)
		{
			Map<String,Object> map = new HashMap<>();
			map.put("role_id", 1);
			
			DataParamter dataParamter = new DataParamter("role", null, map,null, null,null);

			DataResult dataResult = (DataResult) session.excuter(dataParamter);
			System.out.println(dataResult.getBoy().toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		
	
}
