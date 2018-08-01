package jxau.spectrum.frame.dataAccess.Excuter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * sql执行器
 * @author Aaron
 *
 */
public class SqlExcuter {
	/**
	 * 更新
	 * @param sql
	 * @param list
	 * @return
	 */
	
	public SqlExcuter(){
		
	}

	public int excuterUpdate(String sql,List<Object> list){
		Connection conn = SqlConnectionFactory.getInstance().getConnection();
		int result = -1;
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			setSqlParam(preparedStatement, list);
			result = preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	
	private void setSqlParam(PreparedStatement preparedStatement,List<Object> list) throws SQLException{
		for(int i=0;i<list.size();i++){
			preparedStatement.setObject(i+1, list.get(i));
		}
	}
	/**
	 * 查询，返回结果集
	 * @param sql
	 * @param list
	 * @return
	 */
	public ResultSet query(String sql,List<Object> list){
		Connection conn = SqlConnectionFactory.getInstance().getConnection();
		ResultSet result = null;
		try {
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			setSqlParam(preparedStatement, list);
			result = preparedStatement.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
}
