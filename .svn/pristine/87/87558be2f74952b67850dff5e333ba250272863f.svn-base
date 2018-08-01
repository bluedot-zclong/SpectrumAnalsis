package bluedot.spectrum.dao.session;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.FutureTask;

import bluedot.spectrum.dao.Thread.SqlParamterTask;
import bluedot.spectrum.dao.common.DataAccess;
import bluedot.spectrum.dao.core.DataAccessImpl;
import bluedot.spectrum.dao.entry.Column;
import bluedot.spectrum.dao.entry.DataParamter;
import bluedot.spectrum.dao.entry.Global;
import bluedot.spectrum.dao.entry.Index;
import bluedot.spectrum.dao.entry.Table;
import bluedot.spectrum.dao.entry.dto.ConditionDto;

public class Session implements AutoCloseable{
	
	private DataAccess dataAccess;
	public Session() throws Exception{
		dataAccess = new DataAccessImpl();
	} 
	
	public Object excuter(DataParamter dataParamter){
		List<Object> list = new ArrayList();
		String sql = generateSql(dataParamter,list);
		if(dataParamter.getType().getNumber()==1){
			return dataAccess.query(sql,list);
		}else{
			return dataAccess.update(sql,list);
		}
	}


	private String generateSql(DataParamter dataParamter,List<Object> list){
		switch (dataParamter.getType().getNumber()) {
		case 1:
			return generateSelect(dataParamter, list);
		case 2:
			return generateUpdate(dataParamter, list);
		case 3:
			return generateInsert(dataParamter, list);
		case 4: 
			return generateDelete(dataParamter, list);
		default:
			break;
		}
		return null;
		
	}
	
	private String generateSelect(DataParamter dataParamter,List<Object> list){
		long start = System.currentTimeMillis();
		/*//callable future异步处理参数，提高效率
		Callable<ConditionDto> callable = new SqlParamterTask(dataParamter.getViewName(), dataParamter.getCondition(),list);
		Future<ConditionDto> future = threadPool.submit(callable);
		*/
		//获取模板
		Table table = Global.databaseSource.getTable(dataParamter.getViewName());
		StringBuffer buffer = new StringBuffer(table.getSelectTemplet());
		Map<String,Object> map = dataParamter.getCondition();
		if(map==null||map.size()==0){
			if(dataParamter.getStart().intValue()!=-1&&dataParamter.getEnd().intValue()!=-1){
				buffer.append(" limit ");
				buffer.append(dataParamter.getStart()+",");
				buffer.append(dataParamter.getEnd());
			}
			return buffer.toString();
		}
		Map<String, Object> or = dataParamter.getOrCondition();
		/*//待获取参数
		ConditionDto conditionDto = null;
		try {
			conditionDto = future.get();
		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (ExecutionException e) {
			e.printStackTrace();
		}
		
		String sqlCondition = conditionDto.getSqlCondition();
		buffer.append(sqlCondition);*/
		optimizeWhereCondition(dataParamter.getViewName(), buffer,map,or, list);
		if(dataParamter.getStart().intValue()!=-1&&dataParamter.getEnd().intValue()!=-1){
			buffer.append(" limit ");
			buffer.append(dataParamter.getStart()+",");
			buffer.append(dataParamter.getEnd());
		}
		long end = System.currentTimeMillis();
		System.out.println(end - start);
		return buffer.toString();
		
	}

	private String generateInsert(DataParamter dataParamter,List<Object> list){
		if(dataParamter.getInsertMap()==null||dataParamter.getInsertMap().size()==0){
			//异常
		}
		StringBuffer buffer = new StringBuffer();
		buffer.append("insert");
		buffer.append(" ");
		buffer.append("into ");
		buffer.append(dataParamter.getViewName());
		buffer.append("(");
		Map<String,Object> map = dataParamter.getInsertMap();
		int length = map.size();
		int i = 0;
		for (String key : map.keySet()) {
			Object value = map.get(key);
			if(i==length-1){
				buffer.append(key);
			}else{
				buffer.append(key+",");
			}
			i++;
		}
		buffer.append(")");
		buffer.append(" values(");
		i=0;
		for (String key : map.keySet()) {
			Object value = map.get(key);
			list.add(value);
			if(i==length-1){
				buffer.append("?");
			}else{
				buffer.append("?,");
			}
			i++;
		}
		buffer.append(")");
		return buffer.toString();
	}
	
	private String generateUpdate(DataParamter dataParamter,List<Object> list){
		StringBuffer buffer = new StringBuffer();
		buffer.append("update");
		buffer.append(" ");
		buffer.append(dataParamter.getViewName());
		buffer.append(" ");
		buffer.append("set ");
		Map<String,Object> map = dataParamter.getUpdateMap();
		int length = map.size();
		int i = 0;
		for (String key : map.keySet()) {
			Object value = map.get(key);
			list.add(value);
			if(i==length-1){
				buffer.append(key+"=?");
			}else{
				buffer.append(key+"=?"+",");
			}
			i++;
		}
		map = dataParamter.getCondition();
		if(map==null||map.size()==0){
			return buffer.toString();
		}
		indexCondition(dataParamter.getViewName(), buffer, map,list);
		return buffer.toString();
	}
	
	
	private String generateDelete(DataParamter dataParamter,List<Object> list){
		StringBuffer buffer = new StringBuffer();
		buffer.append("delete");
		buffer.append(" ");
		buffer.append("from ");
		buffer.append(dataParamter.getViewName());
	
		Map<String,Object> map = dataParamter.getCondition();
		if(map.size()==0||map==null){
			return buffer.toString();
		}
		indexCondition(dataParamter.getViewName(), buffer, map,list);
		return buffer.toString();
	}
	
	
	/**
	 * 根据表的索引生成条件
	 * @param buffer
	 * @return
	 */
	private void indexCondition(String viewName,StringBuffer buffer,Map<String,Object> condition,List<Object> list){
		buffer.append(" where ");
		Table table = Global.databaseSource.getTable(viewName);
		List<Index> indexList = table.getIndexList();
		Map<String,Object> map = condition;
		Set keyset = map.keySet();
		//先根据索引放条件
		for (Index index : indexList) {
			String columnName = index.getColumnName();
		
			if (keyset.contains(columnName)) {
				buffer.append(columnName + "=?" + " and ");
				Object value = map.get(columnName);
				list.add(value);
				//remove
				map.remove(columnName);
				if(map.isEmpty()){
					buffer.delete(buffer.length()-4, buffer.length()-1);
				}
			}
		}
		
		if(map.isEmpty()){
			return;
		}
		for (String key : map.keySet()) {
			Object value = map.get(key);
			list.add(value);
			buffer.append(key + "=?" + " and ");
			// 这里继续移除
			//map.remove(key);
		}
	
		buffer.delete(buffer.length()-4, buffer.length()-1);
	}
	
	/**
	 * 根据or条件优化sql语句 生成union all
	 * @param viewName
	 * @param buffer
	 * @param condition
	 * @param or
	 * @param list
	 * @return
	 */
	private void unionAll(String viewName,StringBuffer buffer,Map<String, Object> or,List<Object> list){
		if(or==null||or.isEmpty()){
			return;
		}
		buffer.append(" union all ");
		Table table = Global.databaseSource.getTable(viewName);
		buffer = new StringBuffer(table.getSelectTemplet());
		buffer.append(" where ");
		List<Index> indexList = table.getIndexList();
		Map<String,Object> map = or;
		Set keyset = map.keySet();
		//先根据索引放条件
		for (Index index : indexList) {
			String columnName = index.getColumnName();
			//索引在condition中，并且索引在or中，先输出
			if (keyset.contains(columnName)&&(or.containsKey(columnName))) {
				buffer.append(columnName + "=?" + "and ");
				Object value = map.get(columnName);
				list.add(value);
				//这里将会移除or中存在的索引
				map.remove(columnName);
				//一个or 就union一条语句
				break;
			}
		}
		if(map.isEmpty()){
			return;
		}
		for (String key : map.keySet()) {
			//or不为空，且or中不存在
			if(or.containsKey(key)){
				Object value = map.get(key);
				list.add(value);
				buffer.append(key + "=?" + "and ");
				map.remove(key);
				break;
			}
		}
		buffer.delete(buffer.length()-4, buffer.length()-1);
	
	}
	/**
	 * 优化sql语句where条件
	 * @param viewName
	 * @param buffer
	 * @param condition
	 * @param or
	 * @param list
	 */
	private void optimizeWhereCondition(String viewName,StringBuffer buffer,Map<String,Object> condition,Map<String, Object> or,List<Object> list){
		indexCondition(viewName, buffer, condition, list);
		for(int i=0;or!=null&&i<or.size();){
			unionAll(viewName, buffer, or, list);
		}
	}
	
	@Override
	public void close() throws Exception {
		dataAccess.close();
	}
}
