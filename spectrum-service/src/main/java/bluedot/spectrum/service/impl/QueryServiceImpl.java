package bluedot.spectrum.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bluedot.spectrum.common.QueryObject;
import bluedot.spectrum.dao.entry.DataParamter;
import bluedot.spectrum.dao.entry.DataResult;
import bluedot.spectrum.dao.session.Session;
import bluedot.spectrum.service.QueryService;
import jxau.spectrum.frame.web.annotation.Service;
/**
 * 
 * @author Aaron
 * 
 */
@Service
public class QueryServiceImpl implements QueryService{

	/**
	 * 查询
	 */
	@Override
	public List<HashMap<String, Object>> query(QueryObject object) {
		DataResult<List<HashMap<String, Object>>> dataResult = null;
		String viewName = object.getViewName();
		Map<String,Object> condition = object.getCondition();
		Integer start = object.getStart();
		Integer end = object.getEnd();
		Map<String, Object> orCondition = object.getOr();  
		try (Session session = new Session();)
		{
			DataParamter dataParamter = new DataParamter(viewName, null, condition,orCondition, start,end);
			dataResult = (DataResult<List<HashMap<String, Object>>>) session.excuter(dataParamter);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataResult.getBoy();
	}

	

}
