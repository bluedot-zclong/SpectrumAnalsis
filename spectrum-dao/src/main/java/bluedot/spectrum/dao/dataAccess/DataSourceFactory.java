package bluedot.spectrum.dao.dataAccess;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.util.List;
import java.util.Properties;

import javax.sql.DataSource;

import com.alibaba.druid.pool.DruidDataSourceFactory;

import bluedot.spectrum.dao.entry.Column;
import bluedot.spectrum.dao.entry.DataBaseSource;
import bluedot.spectrum.dao.entry.Global;
import bluedot.spectrum.dao.entry.Index;
import bluedot.spectrum.dao.entry.Table;
import bluedot.spectrum.dao.util.JDBCUtil;
import jxau.spectrum.frame.dataAccess.Excuter.SqlConnectionFactory;

public class DataSourceFactory {

	private DataSource dataSource;
	
	private DataSourceFactory(){
		DataSource dataSource = null;
		Properties properties = new Properties();
		try {
			properties.load(SqlConnectionFactory.class.getClassLoader().getResourceAsStream("dbconfig.properties"));
			dataSource = (DataSource) DruidDataSourceFactory.createDataSource(properties);
		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.dataSource = dataSource;
		try {
			Global.databaseSource = CreateDataBaseInfo(dataSource.getConnection());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	private static class SingletonHolder {
		private static final DataSourceFactory INSTANCE = new DataSourceFactory();
	}
	
	public static final DataSourceFactory getInstance() {
		return SingletonHolder.INSTANCE;
	}
	
	public Connection getConnection() throws SQLException{
		return dataSource.getConnection();
	}
	
	/**
	 * 生成数据库中的所有表信息，列属性，列类型，索引
	 * @param connection
	 * @throws SQLException
	 */
	private DataBaseSource CreateDataBaseInfo(Connection connection) throws SQLException{
	
		DatabaseMetaData  databaseMetaData = connection.getMetaData();
		DataBaseSource database = new DataBaseSource();
		database.setDataBaseName("spectrumanalysis");
		List<Table> tablelist = JDBCUtil.getTables(databaseMetaData);
		database.setTableList(tablelist);
		for (Table table : tablelist) {
			List<Column> columnList = JDBCUtil.getCoulumns(databaseMetaData, table.getTableName());
			table.setColumnList(columnList);
			List<Index> indexList = JDBCUtil.getIndexMapper(databaseMetaData, table.getTableName());
			table.setIndexList(indexList);
		}
		return database;
	}
	
}
