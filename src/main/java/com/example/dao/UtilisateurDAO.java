package com.example.dao;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.example.models.Utilisateur;
import com.example.util.HibernateUtil;

public class UtilisateurDAO {

    public boolean enregistrerUtilisateur(Utilisateur utilisateur) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(utilisateur);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }

    public Utilisateur trouverParEmail(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Utilisateur u WHERE u.email = :email";
            return session.createQuery(hql, Utilisateur.class)
                    .setParameter("email", email)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}