package jxau.spectrum.frame.dataAccess.Excuter;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import com.alibaba.druid.pool.DruidDataSourceFactory;

public class SqlConnectionFactory {
	private DataSource dataSource;
	private static ThreadLocal<Connection> conn = new ThreadLocal();

	private static class SingletonHolder {
		private static final SqlConnectionFactory INSTANCE = new SqlConnectionFactory();
	}

	private SqlConnectionFactory() {
		try {
			dataSource = getDataSource();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static final SqlConnectionFactory getInstance() {
		return SingletonHolder.INSTANCE;
	}

	public static Connection getConnection() {
		if (conn.get() == null) {
			conn.set(SqlConnectionFactory.getInstance().getConn());
			return conn.get();
		} else {
			return conn.get();
		}
	}

	public final DataSource getDataSource() throws Exception {
		DataSource dataSource = null;
		Properties properties = new Properties();
		properties.load(SqlConnectionFactory.class.getClassLoader().getResourceAsStream("dbconfig.properties"));
		dataSource = DruidDataSourceFactory.createDataSource(properties);
		return dataSource;

	}

	private Connection getConn() {
		try {
			return dataSource.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

}
