package bluedot.spectrum.dao.dataAccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jxau.spectrum.frame.dataAccess.Excuter.SqlConnectionFactory;

public class DataAccessObject  {
	
	private ThreadLocal<Connection> conn = new ThreadLocal<>();
	
	public DataAccessObject(){
		Connection connection = null;
		try {
			if(this.conn.get()==null){
				connection = DataSourceFactory.getInstance().getConnection();
				this.conn.set(connection);
			}else{
				connection = this.conn.get();
			}
			//关闭自动提交
			connection.setAutoCommit(false);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	public int excuterUpdate(String sql,List<Object> list){
		Connection conn = this.conn.get();
		int result = -1;
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			setSqlParam(preparedStatement, list);
			result = preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	private void setSqlParam(PreparedStatement preparedStatement,List<Object> list) throws SQLException{
		for(int i=0;i<list.size();i++){
			preparedStatement.setObject(i+1, list.get(i));
		}
	}
	
	public List<HashMap<String,Object>> query(String sql,List<Object> list){
		Connection conn = this.conn.get();
		ResultSet result = null;
		List<HashMap<String,Object>> resultlist = new ArrayList();
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			setSqlParam(preparedStatement, list);
			result = preparedStatement.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				conn.commit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		try {
			while(result.next()){
				HashMap<String,Object> map = new HashMap();
				//获取表的列数
				ResultSetMetaData rsmd=result.getMetaData();//使用 getMetaData() 方法从 ResultSet 中获取 ResultSetMetaData 对象。您可以使用此对象获得列的数目和类型以及每一列的名称。 
				int columnCount=rsmd.getColumnCount();
				//map存放行中的所有列key是列名 value是列值
				for(int i=1;i<=columnCount;i++) {
					String k=rsmd.getColumnName(i);
					Object v=result.getObject(i);
					map.put(k, v);
				}
				resultlist.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultlist;
	}
	
	public void close(){
		Connection connection = conn.get();
		try {
			if(connection!=null&&!connection.isClosed()){
				connection.commit();
				connection.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
