package bluedot.spectrum.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bluedot.spectrum.common.EditObject;
import bluedot.spectrum.dao.entry.DataParamter;
import bluedot.spectrum.dao.entry.DataResult;
import bluedot.spectrum.dao.session.Session;
import bluedot.spectrum.service.EditService;
import jxau.spectrum.frame.web.annotation.Service;
@Service
public class EditServiceImpl implements EditService{

	private int delete(EditObject param) {
		DataResult<Integer> dataResult = null;
		String viewName = param.getViewName();
		Map<String,Object> condition = param.getCondition();
		try (Session session = new Session();)
		{
			DataParamter dataParamter = new DataParamter(condition,viewName);
			dataResult = (DataResult<Integer>) session.excuter(dataParamter);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataResult.getBoy();
	}

	private int add(EditObject param) {
		DataResult<Integer> dataResult = null;
		String viewName = param.getViewName();
		Map<String,Object> insertMap = param.getInsert();
		try (Session session = new Session();)
		{
			DataParamter dataParamter = new DataParamter(viewName,insertMap);
			dataResult = (DataResult<Integer>) session.excuter(dataParamter);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataResult.getBoy();
	}

	private int update(EditObject param) {
		DataResult<Integer> dataResult = null;
		String viewName = param.getViewName();
		Map<String,Object> condition = param.getCondition();
		Map<String,Object> orcondition = param.getOr();
		Map<String,Object> updateMap = param.getUpdateMap();
		try (Session session = new Session();)
		{
			DataParamter dataParamter = new DataParamter(viewName,updateMap,condition);
			dataResult = (DataResult<Integer>) session.excuter(dataParamter);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataResult.getBoy();
	}

	@Override
	public int edit(EditObject param) {
		String type = param.getType();
		if(type.equals("update")){
			return update(param);
		}else if(type.equals("insert")){
			return add(param);
		}else{
			return delete(param);
		}
	}

}
