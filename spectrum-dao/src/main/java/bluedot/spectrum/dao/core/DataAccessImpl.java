package bluedot.spectrum.dao.core;

import java.util.HashMap;
import java.util.List;

import bluedot.spectrum.dao.common.DataAccess;
import bluedot.spectrum.dao.dataAccess.DataAccessObject;
import bluedot.spectrum.dao.entry.DataResult;

public class DataAccessImpl implements DataAccess {

	private DataAccessObject dataAccess = new DataAccessObject();
	
	@Override
	public DataResult<List<HashMap<String,Object>>> query(String sql,List<Object> list) {
		List<HashMap<String,Object>> result = dataAccess.query(sql, list);
		DataResult<List<HashMap<String,Object>>> dataResult = new DataResult<>(1,result);
		return dataResult;
	}
	
	@Override
	public DataResult<Integer> update(String sql,List<Object> list) {
		DataResult<Integer> dataResult = new DataResult<>(2, dataAccess.excuterUpdate(sql, list));
		return dataResult;
	}
	@Override
	public void close(){
		dataAccess.close();
	}

}
