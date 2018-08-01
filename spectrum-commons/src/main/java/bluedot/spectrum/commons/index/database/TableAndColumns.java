package bluedot.spectrum.commons.index.database;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author : Harold
 * @Description 封装了表名、表中主键和表中某些列的对象
 * @Date : 2018/1/31 16:33
 */
public class TableAndColumns{
    /** 表名*/
    private String tableName = null;

    /** 主键名 **/
    private String id;
    
    /** 需要的列名*/
    private List<String> columns = new ArrayList<String>();

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public List<String> getColumns() {
        return columns;
    }

    public void setColumns(List<String> columns) {
        this.columns = columns;
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
