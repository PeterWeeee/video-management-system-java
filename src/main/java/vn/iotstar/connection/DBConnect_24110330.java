package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect_24110330 {
    private static final String SERVER_NAME = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : "localhost";
    private static final String PORT = System.getenv("DB_PORT") != null ? System.getenv("DB_PORT") : "1433";
    private static final String DATABASE_NAME = System.getenv("DB_NAME") != null ? System.getenv("DB_NAME") : "WebDe04";
    private static final String USERNAME = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "sa";
    private static final String PASSWORD = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "123456";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String url = "jdbc:sqlserver://" + SERVER_NAME + ":" + PORT + ";databaseName=" + DATABASE_NAME
                    + ";user=" + USERNAME + ";password=" + PASSWORD
                    + ";encrypt=true;trustServerCertificate=true;characterEncoding=UTF-8";
            conn = DriverManager.getConnection(url);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    public static void main(String[] args) {
        Connection conn = getConnection();
        if (conn != null) {
            System.out.println("Kết nối CSDL WebDe04 thành công!");
        } else {
            System.out.println("Kết nối CSDL thất bại!");
        }
    }
}
