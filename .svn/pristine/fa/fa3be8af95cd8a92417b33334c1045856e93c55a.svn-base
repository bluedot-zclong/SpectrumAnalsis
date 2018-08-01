package bluedot.spectrum.commons.index.database;



import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bluedot.spectrum.commons.index.exception.CloumnNotDefineException;
import bluedot.spectrum.commons.index.exception.NullFileNameException;
import bluedot.spectrum.commons.index.exception.TableNotDefineException;

/**
 * @author : Harold
 * @Description 通过数据库连接，拿到表中字段的所有数据
 * @Date : 2018/1/13 16:41
 */
public class Database {

    /** 获得数据库连接 */
    private Connection conn;
    
    /** TableAndColumns对象，峰会在那个字段、表名和主键 **/
    private TableAndColumns tableAndColumns;
    
    /**文件写入流 */
    private String filename;

    /** 私有化无参构造方法 */
    private Database() {       
    }

    /**
     * 传入表名和列名的构造方法
     * @param conn 传入的数据库连接
     * @param tableAndColumns 插入的表名和字段名集合
     * @param filename 文件名
     * @throws TableNotDefineException 表不存在的异常类
     * @throws CloumnNotDefineException
     * @throws SQLException
     * @throws NullFileNameException
     */
    public Database(Connection conn, TableAndColumns tableAndColumns, String filename)throws  TableNotDefineException, CloumnNotDefineException, SQLException, NullFileNameException{
        //对传入的tableAndColumns进行校验
    	if(tableAndColumns.getTableName() == null || "".equals(tableAndColumns.getTableName())){
            throw new TableNotDefineException("没有表名的构造方法");
        }

        if(tableAndColumns.getColumns().size() == 0){
            throw new CloumnNotDefineException("没有指定表中的字段名");
        }
        
        if(tableAndColumns.getId() == null || "".equals(tableAndColumns.getId())){
            throw new CloumnNotDefineException("没有指定表中的字段名");
        }
        
        //对filename进行校验
        if(filename == null || "".equals(filename)){
            throw new NullFileNameException("没有指定表中的字段名");
        }
        
        
        this.conn = conn;
        this.tableAndColumns = tableAndColumns;   
        this.filename = filename;
    }

    /**
     * 添加所有的数据添加到文件中
     * @return 
     * @throws SQLException
     * @throws FileNotFoundException 
     */
    public List<String> addToList() throws SQLException{
    	/** 保存表中所有选择项的数据的集合 */
        List<String> allData = new ArrayList<String>();
        
        DataToFile dataToFile= null;
    	PrintWriter printWriter = null;
   	
        try{
        	dataToFile = new DataToFile(filename);
            printWriter = dataToFile.getFileReader();
            
            //循环查询所有的列
	    	for (int i = 0; i < tableAndColumns.getColumns().size(); i++) {
	    		allData.addAll(addColumnToFile(tableAndColumns.getColumns().get(i),printWriter));
	        }
        } catch (FileNotFoundException e) {
			e.printStackTrace();
		}
        finally {
        	DataToFile.close(printWriter);
		}
        return allData;	
    }

    /** 添加一条数据到文档中*/
    private List<String> addColumnToFile(String cloumn, PrintWriter printWriter) throws SQLException{
    		
		//保存需要建索引的集合
        List<String> data = new ArrayList<String>();		        
        
        //执行查询语句，并把数据保存在List集合中
        PreparedStatement preStatement = conn.prepareStatement("SELECT `"+ cloumn + "`,`"+ tableAndColumns.getId() +"` FROM " + tableAndColumns.getTableName());            
        ResultSet resultSet = preStatement.executeQuery();
        while(resultSet.next()){
        	
        	//通过PrintWriter向文件中写入数据，数据格式如下： date id tablename
        	printWriter.print(resultSet.getString(cloumn) + " " + resultSet.getString(tableAndColumns.getId()) + " " +  tableAndColumns.getTableName() + " " + tableAndColumns.getId() + "\r\n");
        	printWriter.flush();
        	
        	//将数据加入到data中
        	data.add(resultSet.getString(cloumn)); 
        }
        
        return data;
	}   
    
}
