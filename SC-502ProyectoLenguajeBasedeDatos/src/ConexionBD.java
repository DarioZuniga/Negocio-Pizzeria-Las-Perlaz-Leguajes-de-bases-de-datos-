import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
            "jdbc:oracle:thin:@localhost:1521:XE",
            "pizzeria_user",
            "Perlaz2025"
        );
    }
}