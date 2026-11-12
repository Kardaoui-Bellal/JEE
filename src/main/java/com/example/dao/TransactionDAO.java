package com.example.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.example.models.Depense;
import com.example.models.Revenu;
import com.example.models.Transaction;

public class TransactionDAO {

    // 1. إضافة معاملة مالية وإرجاع الـ ID المُتولّد (يدعم الـ Transaction Service والـ Budget Service)
    public int ajouterTransaction(Transaction transaction, int compteId, int categorieId) {
        String query = "INSERT INTO transaction (montant, date, description, source, modePaiement, compte_id, categorie_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        int generatedId = -1;

        try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setBigDecimal(1, transaction.getMontant());
            pstmt.setDate(2, new java.sql.Date(transaction.getDate().getTime()));
            pstmt.setString(3, transaction.getDescription());

            // التعامل مع الوراثة (Revenu أو Depense)
            if (transaction instanceof Revenu) {
                pstmt.setString(4, ((Revenu) transaction).getSource());
                pstmt.setNull(5, Types.VARCHAR);
            } else if (transaction instanceof Depense) {
                pstmt.setNull(4, Types.VARCHAR);
                pstmt.setString(5, ((Depense) transaction).getModePaiement());
            } else {
                pstmt.setNull(4, Types.VARCHAR);
                pstmt.setNull(5, Types.VARCHAR);
            }

            pstmt.setInt(6, compteId);
            pstmt.setInt(7, categorieId);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getInt(1); 
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    public List<Transaction> listerTransactionsParCompte(int compteId) {
        List<Transaction> transactions = new ArrayList<>();
        String query = "SELECT * FROM transaction WHERE compte_id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, compteId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    String source = rs.getString("source");
                    Transaction t;
                    if (source != null) {
                        Revenu rev = new Revenu();
                        rev.setSource(source);
                        t = rev;
                    } else {
                        Depense dep = new Depense();
                        dep.setModePaiement(rs.getString("modePaiement"));
                        t = dep;
                    }
                    t.setId(rs.getInt("id"));
                    t.setMontant(rs.getBigDecimal("montant"));
                    t.setDate(rs.getDate("date"));
                    t.setDescription(rs.getString("description"));
                    transactions.add(t);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }

    public boolean supprimerTransaction(int id) {
        String query = "DELETE FROM transaction WHERE id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
