package bluedot.spectrum.dao.common;

import java.util.HashMap;
import java.util.List;

import bluedot.spectrum.dao.entry.DataResult;

public interface DataAccess {
	
	public DataResult query(String sql,List<Object> list);
	
	public DataResult update(String sql,List<Object> list);
	
	public void close();
}
