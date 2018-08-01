package bluedot.spectrum.dao.entry;

import java.util.List;

public class DataBaseSource {
	private String DataBaseName;
	private List<Table> tableList;
	
	
	public void setDataBaseName(String dataBaseName) {
		DataBaseName = dataBaseName;
	}
	public void setTableList(List<Table> tableList) {
		this.tableList = tableList;
	}
	public String getDataBaseName() {
		return DataBaseName;
	}
	public List<Table> getTableList() {
		return tableList;
	}

	public Table getTable(String viewName){
		for (Table table : tableList) {
			if(table.getTableName().equals(viewName)){
				return table;
			}
		}
		//异常
		return null;
	}
	
}
