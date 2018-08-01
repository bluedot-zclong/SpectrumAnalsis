package bluedot.spectrum.commons.index.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author : Harold
 * @Description 建立数据库之间的连接
 * @Date : 2018/1/13 17:15
 */
public class MySqlConnection implements SqlConnection{

    /**
     * 获取连接
     * @param name 驱动地址
     * @param url 数据库 url
     * @param user 用户名
     * @param password 密码
     * @return 返回数据库连接
     */
    public Connection getConnection(String name, String url, String user, String password) {
        Connection conn = null;
        try {
            Class.forName(name);//指定连接类型
            conn = DriverManager.getConnection(url, user, password);//获取连接
            return conn;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    /**
     * 关闭连接
     */
    public void close(Connection conn) {
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
