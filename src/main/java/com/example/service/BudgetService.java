package com.example.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.example.dao.DBConnection;

public class BudgetService {

    public void verifierBudget(int categorieId, int mois) {
        String sumQuery = "SELECT SUM(montant) AS total FROM transaction WHERE categorie_id = ? AND MONTH(date) = ?";
        double totalDepense = 0;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sumQuery)) {
            
            pstmt.setInt(1, categorieId);
            pstmt.setInt(2, mois);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    totalDepense = rs.getDouble("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}