package dao;

import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {
        Connection connection = DBConnection.getConnection();
        if (connection != null) {
            System.out.println("si MYSQL connection successful!");
        } else {
            System.out.println("❌ Failed to connect to the database.");
        }
    }
}