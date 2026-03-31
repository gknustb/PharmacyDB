package com.gknust;

import java.sql.*;

public class App {
  public static void main(String[] args) {
    try {
      Connection connection = DriverManager.getConnection(System.getenv("DB_URL"), System.getenv("DB_USER"),
          System.getenv("DB_PASSWORD"));
      Statement stmt = connection.createStatement();
      stmt.executeUpdate("CREATE TABLE a (id int not null primary key, value varchar(20))");
      stmt.close();
      connection.close();
    } catch (Exception e) {
      System.out.println("hi!");
    }
  }
}
