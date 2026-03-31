package com.gknust;

import java.io.IOException;
import java.sql.*;

public class App {
  public static void main(String[] args) throws IOException {
    try {
      sqlTest();
    } catch (SQLException e) {
      for (Throwable t : e)
        t.printStackTrace();
    }
  }

  public static void sqlTest() throws SQLException, IOException {
    try (Connection connection = getConnection(); Statement stat = connection.createStatement()) {
      stat.executeUpdate("CREATE TABLE foo(message VARCHAR(30))");
      stat.executeUpdate("INSERT INTO foo VALUES ('Hello, World!')");

      try (ResultSet result = stat.executeQuery("SELECT * FROM foo")) {
        if (result.next())
          System.out.println(result.getString(1));
      }
      stat.executeUpdate("DROP TABLE foo");
    }
  }

  public static Connection getConnection() throws SQLException, IOException {
    String dbUrl = System.getenv("DB_URL");
    String dbUser = System.getenv("DB_USER");
    String dbPassword = System.getenv("DB_PASSWORD");
    return DriverManager.getConnection(dbUrl, dbUser, dbPassword);
  }
}
