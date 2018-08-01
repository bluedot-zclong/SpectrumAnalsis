package bluedot.spectrum.common;

import java.util.List;
import java.util.Map;
/**
 * 编辑对象
 * @author Aaron
 *
 */
public class EditObject {
	
	private String type;
	private Map<String,Object> insert;  //插入时候的属性
	private String viewName;	//视图/表名
	private Map<String,Object> updateMap;//更新键值对
	private Map<String,Object> condition;//and条件
	private Map<String,Object> or;//or条件
	
	/**
	 * 插入构造
	 * @param insert
	 * @param viewName
	 */
	public EditObject(Map<String,Object> insert,String viewName){
		this.insert = insert;
		this.viewName = viewName;
		this.type = "insert";
	}
	/**
	 * 删除构造
	 * @param viewName
	 * @param condition
	 * @param or
	 */
	public EditObject(String viewName,Map<String,Object> condition,Map<String,Object> or){
		this.condition = condition;
		this.viewName = viewName;
		this.or = or;
		this.type = "delete";
		
	}
	/**
	 * 更新构造
	 * @param viewName
	 * @param updateMap
	 * @param condition
	 * @param or
	 */
	public EditObject(String viewName,Map<String,Object> updateMap,Map<String,Object> condition,Map<String,Object> or){
		this.condition = condition;
		this.viewName = viewName;
		this.or = or;
		this.updateMap = updateMap;
		this.type = "update";
	}
	public String getType() {
		return type;
	}
	public Map<String, Object> getInsert() {
		return insert;
	}
	public String getViewName() {
		return viewName;
	}
	public Map<String, Object> getUpdateMap() {
		return updateMap;
	}
	public Map<String, Object> getCondition() {
		return condition;
	}
	public Map<String, Object> getOr() {
		return or;
	}
	
}
