package bluedot.spectrum.dao.Thread;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Callable;

import bluedot.spectrum.dao.entry.Global;
import bluedot.spectrum.dao.entry.Index;
import bluedot.spectrum.dao.entry.Table;
import bluedot.spectrum.dao.entry.dto.ConditionDto;
/**
 * 参数与sql语句解析任务
 * @author Aaron
 *
 */
public class SqlParamterTask implements Callable<ConditionDto> {

	private Map<String,Object> condition;
	private String viewName;
	private ConditionDto conditionDto;
	
	public SqlParamterTask(String viewName,Map<String,Object> condition,List<Object> list){
		this.viewName = viewName;
		this.condition = condition;
		this.conditionDto = new ConditionDto();
		this.conditionDto.setList(list);
	}
	
	@Override
	public ConditionDto call() throws Exception {
		StringBuffer buffer = new StringBuffer();
		this.conditionDto.setSqlCondition(indexCondition(this.viewName, buffer, condition, this.conditionDto.getList()));
		return this.conditionDto;
	}
	
	


	/**
	 * 根据表的索引生成条件sql语句并封装参数进list
	 * @param buffer
	 * @return
	 */
	private String indexCondition(String viewName,StringBuffer buffer,Map<String,Object> condition,List<Object> list){
		buffer.append(" where ");
		Table table = Global.databaseSource.getTable(viewName);
		List<Index> indexList = table.getIndexList();
		Map<String,Object> map = condition;
		Set keyset = map.keySet();
		//先根据索引放条件
		for (Index index : indexList) {
			String columnName = index.getColumnName();
			if (keyset.contains(columnName)) {
				buffer.append(columnName + "=?" + ",");
				Object value = map.get(columnName);
				list.add(value);
				map.remove(columnName);
			}
		}
		int length = map.size();
		int i = 0;
		for (String key : map.keySet()) {
			Object value = map.get(key);
			list.add(value);
			buffer.append(key + "=?" + ",");
			i++;
		}
		return buffer.deleteCharAt(buffer.length()-1).toString();
	}

}
