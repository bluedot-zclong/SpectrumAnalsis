package bluedot.spectrum.commons.index.connection;

import java.sql.Connection;

/**
 * @Author : Harold
 * @Description
 * @Date : 2018/1/13 17:38
 */
public interface SqlConnection {
    /** 获得数据库连接**/
    Connection getConnection(String name, String url, String user, String password);
    /** 关闭数据库连接*/
    void close(Connection conn);
}
