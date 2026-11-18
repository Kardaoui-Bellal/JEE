package com.example.dao;

import com.example.models.Specialite;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SpecialiteDao {

    public List<Specialite> listerSpecialites() {
        List<Specialite> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM specialite");
            while (rs.next()) {
                list.add(new Specialite(rs.getInt("id"), rs.getString("nom"), rs.getString("description")));
            }
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void ajouterSpecialite(Specialite s) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("INSERT INTO specialite(nom, description) VALUES(?, ?)");
            ps.setString(1, s.getNom());
            ps.setString(2, s.getDescription());
            ps.executeUpdate();
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void supprimerSpecialite(int id) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM specialite WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public Specialite obtenirSpecialiteParId(int id) {
        Specialite s = null;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM specialite WHERE id=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                s = new Specialite(rs.getInt("id"), rs.getString("nom"), rs.getString("description"));
            }
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
        return s;
    }

    public void modifierSpecialite(Specialite s) {
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE specialite SET nom=?, description=? WHERE id=?");
            ps.setString(1, s.getNom());
            ps.setString(2, s.getDescription());
            ps.setInt(3, s.getId());
            ps.executeUpdate();
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
    }
}