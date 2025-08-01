Instrucciones para el profesor
Requisitos:

Oracle Database 19c/21c
Java JDK 17+
Driver ojdbc10.jar
Configuración:

Ejecutar scripts SQL en orden numérico
Configurar en Oracle:
CREATE USER pizzeria_user IDENTIFIED BY Perlaz2025;
GRANT CONNECT, RESOURCE TO pizzeria_user;
Ejecución:

javac -cp lib/ojdbc10.jar -d bin src/*.java
java -cp bin;lib/ojdbc10.jar Main
