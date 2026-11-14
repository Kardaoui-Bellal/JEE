package com.example.service;

import com.example.models.Compte;
import com.example.models.Utilisateur;
import com.example.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.math.BigDecimal;
import java.util.List;

public class CompteService {

    public void creerCompte(String nom, BigDecimal soldeInitial, String devise, Long utilisateurId) throws Exception {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();

            Utilisateur utilisateur = session.get(Utilisateur.class, utilisateurId);

            Compte compte = new Compte();
            compte.setNom(nom);
            compte.setSoldeInitial(soldeInitial);
            compte.setSolde(soldeInitial);
            compte.setDevise(devise != null && !devise.isEmpty() ? devise : "MAD");
            compte.setUtilisateur(utilisateur);

            session.persist(compte);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public List<Compte> getComptesParUtilisateur(Long utilisateurId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                            "FROM Compte c WHERE c.utilisateur.id = :userId", Compte.class)
                    .setParameter("userId", utilisateurId)
                    .getResultList();
        }
    }
}