package bluedot.spectrum.service;

import java.util.Map;

/**
 * 统一传参接口
 * @author zclong
 * 2018年1月20日
 * @param <T>
 */
public class BaseService<T> {
	 
	
	private String param1;
	
	private Integer param2;
	
	private Map<String,Object> condition;
	
	private T clazz;

	
	public BaseService(String param1, Integer param2, Map<String, Object> condition, T clazz) {
		this.param1 = param1;
		this.param2 = param2;
		this.condition = condition;
		this.clazz = clazz;
	}


	public String getParam1() {
		return param1;
	}


	public void setParam1(String param1) {
		this.param1 = param1;
	}


	public Integer getParam2() {
		return param2;
	}


	public void setParam2(Integer param2) {
		this.param2 = param2;
	}


	public T getClazz() {
		return clazz;
	}


	public void setClazz(T clazz) {
		this.clazz = clazz;
	}


	@Override
	public String toString() {
		return "BaseService [param1=" + param1 + ", param2=" + param2 + ", condition=" + condition + ", clazz=" + clazz
				+ "]";
	}
}
