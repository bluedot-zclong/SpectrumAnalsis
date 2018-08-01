package bluedot.spectrum.common;

import java.util.List;
import java.util.Map;

public class QueryObject {
	private String viewName;  //视图名
	private Map<String, Object> condition; //and条件
	private Integer start;  //limit 开始
	private Integer end;    // limit 长度
 	private Map<String,Object> or;   //or条件
	
	/**
	 * 至少给我，视图名和condition,如果start和end为null默认全部查询，查询最好limit，有or条件放入orMap中(bug)
	 * @param viewName
	 * @param condition
	 * @param start
	 * @param end
	 * @param or
	 */
	public QueryObject(String viewName, Map<String, Object> condition, Integer start, Integer end, Map<String,Object> or) {
		super();
		this.viewName = viewName;
		this.condition = condition;
		this.start = start;
		this.end = end;
		this.or = or;
	}

	public String getViewName() {
		return viewName;
	}

	public void setViewName(String viewName) {
		this.viewName = viewName;
	}

	public Map<String, Object> getCondition() {
		return condition;
	}

	public void setCondition(Map<String, Object> condition) {
		this.condition = condition;
	}

	public Integer getStart() {
		return start;
	}

	public void setStart(Integer start) {
		this.start = start;
	}

	public Integer getEnd() {
		return end;
	}

	public void setEnd(Integer end) {
		this.end = end;
	}

	public Map<String, Object> getOr() {
		return or;
	}

	public void setOr(Map<String, Object> or) {
		this.or = or;
	}


	
	
	
	
}
