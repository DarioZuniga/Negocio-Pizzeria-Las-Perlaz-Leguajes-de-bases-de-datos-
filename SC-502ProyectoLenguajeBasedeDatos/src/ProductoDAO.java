
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

public class ProductoDAO {
    public static void registrar(String nombre, double precio) {
        try (Connection conn = ConexionBD.getConnection();
             CallableStatement stmt = conn.prepareCall("{call sp_insertar_producto(?, ?, ?)}")) {
            
            stmt.setString(1, nombre);
            stmt.setDouble(2, precio);
            stmt.registerOutParameter(3, Types.INTEGER);
            
            stmt.execute();
            System.out.println("ID generado: " + stmt.getInt(3));
        } catch (SQLException e) {
        }
    }
}