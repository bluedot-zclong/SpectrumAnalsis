package bluedot.spectrum.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bluedot.spectrum.common.QueryObject;

/**
 * 查询模块接口
 * @author Aaron
 * 2018年1月20日
 */
public interface QueryService {
	
	List<HashMap<String,Object>> query(QueryObject object);
	
}
