package bluedot.spectrum.service;

import java.util.Map;

/**
 * 权限控制模块
 * @author zclong
 * 2018年1月20日
 */
public interface AuthorityService {
	
	/**
	 * 判断用户是否有权限访问该数据
	 * 2018年1月20日
	 * zclong
	 * @param userId
	 * @param params
	 * @return
	 */
	boolean dataAuthority(int userId, Map<String, Object> params);
	
	/**
	 * 判断用户是否有权限访问该路径，方法
	 * 2018年1月20日
	 * zclong
	 * @param userId
	 * @param method
	 * @return
	 */
	boolean urlAuthority(int userId, String method);
	
}
