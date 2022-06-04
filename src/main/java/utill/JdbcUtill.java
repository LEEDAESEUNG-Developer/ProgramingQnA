package utill;

import java.sql.*;

public class JdbcUtill {

    public static Connection getConnection(){
        Connection conn = null;
        String dbUrl = "jdbc:mysql://14.34.194.163:3306/programingQnA";
        String dbId = "ezen01";
        String dbPwd = "@@ezen01";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbId, dbPwd);
        } catch (ClassNotFoundException e) {
            System.out.println("Class.forName: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("DriverManger: " + e.getMessage());
        }
        return conn;
    }

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

    public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
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
        if(rs != null){
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }
}
