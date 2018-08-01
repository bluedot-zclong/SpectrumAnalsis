package bluedot.spectrum.dao.entry;

import java.util.List;
import java.util.Map;

import bluedot.spectrum.dao.enmu.SQLType;

/**
 * 待完成，调用dao层是的参数
 * @author Aaron
 *
 * @param <T>
 */
public class DataParamter {
	
	//类型
	private SQLType type;
	//视图
	private String viewName;
	//查询属性
	private List<String> fields;
	//条件
	private Map<String,Object> condition;
	//更新条件
	private Map<String,Object> updateMap;
	//插入
	private Map<String,Object> insertMap;
	//or条件name
	private Map<String,Object> orCondition;
	//分页
	private Integer start;
	private Integer end;
	
	private DataParamter(SQLType type,String viewName,Map<String,Object> condition,Map<String,Object> updateMap,Map<String,Object> insertMap,List<String> list,Integer start,Integer end){
		this.start = start==null?-1:start;
		this.end = end==null?-1:end;
		
		this.type = type;
		this.viewName = viewName;
		switch (type.getNumber()) {
		case 1:
			fields = list;
			this.condition = condition;
			break;
		case 2:
			this.condition = condition;
			this.updateMap = updateMap;
			break;
		case 3:
			this.insertMap = insertMap;
			break;
		case 4: 
			this.condition = condition;
			break;
		default:
			break;
		}
		
	}
	/**
	 * 插入参数封装
	 * @param viewName
	 * @param insertMap
	 */
	public DataParamter(String viewName,Map<String,Object> insertMap){
		this(SQLType.INSERT,viewName,null,null,insertMap,null,null,null);
	}
	/**
	 * 删除参数
	 * @param condition
	 * @param viewName
	 */
	public DataParamter(Map<String,Object> condition,String viewName){
		this(SQLType.DELETE,viewName,condition,null,null,null,null,null);
	}
	/**
	 * 更新参数
	 * @param updateMap
	 * @param condition
	 */
	public DataParamter(String viewName,Map<String,Object> updateMap,Map<String,Object> condition){
		this(SQLType.UPDATE,viewName,condition,updateMap,null,null,null,null);
	}
	
	/**
	 * select查询参数
	 * @param viewName
	 * @param list
	 * @param condition
	 * @param start
	 * @param end
	 */
	public DataParamter(String viewName,List<String> list,Map<String,Object> condition,Map<String,Object> orCondition,Integer start,Integer end){
		this(SQLType.SEKECT,viewName,condition,null,null,list,start,end);
		this.orCondition = orCondition;
	}
		
	public SQLType getType() {
		return type;
	}


	public String getViewName() {
		return viewName;
	}


	public List<String> getFields() {
		return fields;
	}


	public Map<String, Object> getCondition() {
		return condition;
	}


	public Map<String, Object> getUpdateMap() {
		return updateMap;
	}


	public Map<String, Object> getInsertMap() {
		return insertMap;
	}


	public Integer getStart() {
		return start;
	}


	public Integer getEnd() {
		return end;
	}
	
	public Map<String,Object> getOrCondition() {
		return orCondition;
	}
	
	
	
}
