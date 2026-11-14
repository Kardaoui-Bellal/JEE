package com.example.service;

import com.example.models.Categorie;
import com.example.models.TypeCategorie;
import com.example.models.Utilisateur;
import com.example.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class CategorieService {

    public void creerCategorie(String nom, TypeCategorie type, String couleur, Long utilisateurId) throws Exception {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();

            Utilisateur utilisateur = session.get(Utilisateur.class, utilisateurId);

            Categorie categorie = new Categorie();
            categorie.setNom(nom);
            categorie.setType(type);
            categorie.setCouleur(couleur != null && !couleur.isEmpty() ? couleur : "#f97316");
            categorie.setUtilisateur(utilisateur);

            session.persist(categorie);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public List<Categorie> getCategoriesParUtilisateur(Long utilisateurId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                            "FROM Categorie c WHERE c.utilisateur.id = :userId", Categorie.class)
                    .setParameter("userId", utilisateurId)
                    .getResultList();
        }
    }
}