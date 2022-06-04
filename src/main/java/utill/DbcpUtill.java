package utill;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DbcpUtill {
    // DBCP 커넥션 연결
    public static Connection getConnection() throws NamingException, SQLException {
        Context init = new InitialContext();
        Context envCtx = (Context) init.lookup("java:comp/env");
        DataSource ds = (DataSource) envCtx.lookup("jdbc/programingQnA");
        return ds.getConnection();
    }

    // DB 연결 관련된것들을 모두 연결 종료
    public static void close(Connection conn, PreparedStatement pstmt) {
        if(conn != null){
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if(pstmt != null){
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs){
        close(conn, pstmt);
        if(rs != null){
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
