# Negocio-Pizzeria-Las-Perlaz-Leguajes-de-bases-de-datos-
Este es un proyecto colaborativo,basado en un negocio real "Pizzeria las Perlaz"

# Pizzería Las Perlaz - Segundo Avance

## Requisitos
- Oracle Database 19c/21c
- Java JDK 11+
- Driver JDBC para Oracle (ojdbc10.jar)

## Instrucciones
1. Ejecutar los scripts SQL en orden (01_conexion.sql, 02_procedimientos.sql, etc.).
2. Compilar y ejecutar `Prueba.java` para verificar .

   

# Instrucciones para el profesor

1. **Requisitos**:
   - Oracle Database 19c/21c
   - Java JDK 17+
   - Driver ojdbc10.jar

2. **Configuración**:
   - Ejecutar scripts SQL en orden numérico
   - Configurar en Oracle:
     ```sql
     CREATE USER pizzeria_user IDENTIFIED BY Perlaz2025;
     GRANT CONNECT, RESOURCE TO pizzeria_user;
     ```

3. **Ejecución**:
   ```bash
   javac -cp lib/ojdbc10.jar -d bin src/*.java
   java -cp bin;lib/ojdbc10.jar Main
