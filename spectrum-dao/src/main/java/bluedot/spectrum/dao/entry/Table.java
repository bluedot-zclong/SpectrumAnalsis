package bluedot.spectrum.dao.entry;

import java.util.List;

public class Table {
	private String tableName;
	private String tableType;
	private List<Column> columnList;
	private List<Index> indexList;
	
	private String selectTemplet;
	
	public String getTableName() {
		return tableName;
	}
	public String getTableType() {
		return tableType;
	}
	public List<Column> getColumnList() {
		return columnList;
	}
	public List<Index> getIndexList() {
		return indexList;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public void setTableType(String tableType) {
		this.tableType = tableType;
	}
	public void setColumnList(List<Column> columnList) {
		this.columnList = columnList;
	}
	public void setIndexList(List<Index> indexList) {
		this.indexList = indexList;
	}
	
	public String getSelectTemplet(){
		//加层锁，特别针对初始化的时候
		if(selectTemplet==null){
			synchronized(this){
				StringBuffer buffer = new StringBuffer("select");
				buffer.append(" ");
				for (Column column : columnList) {
					buffer.append(column.getColumnName()+",");
				}
				buffer.deleteCharAt(buffer.length()-1);
				buffer.append(" from "+tableName);	
				selectTemplet = buffer.toString();
			}
		}
		
		return selectTemplet;
		
	}
	
}
