package com.example.service;

import com.example.models.Categorie;
import com.example.models.Compte;
import com.example.models.Depense;
import com.example.models.ModePaiement;
import com.example.models.Revenu;
import com.example.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public class TransactionService {

    public void ajouterRevenu(BigDecimal montant, Long categorieId, Long compteId, String source, String description, LocalDate date) throws Exception {
        if (montant == null || montant.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Le montant doit être positif.");
        }

        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();

            Categorie categorie = session.get(Categorie.class, categorieId);
            Compte compte = session.get(Compte.class, compteId);

            if (categorie == null || compte == null) {
                throw new IllegalArgumentException("Catégorie ou compte introuvable.");
            }

            Revenu revenu = new Revenu();
            revenu.setMontant(montant);
            revenu.setCategorie(categorie);
            revenu.setCompte(compte);
            revenu.setSource(source);
            revenu.setDescription(description);
            revenu.setDate(date);

            compte.setSolde(compte.getSolde().add(montant));

            session.persist(revenu);
            session.merge(compte);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public List<Depense> getDepensesParUtilisateur(Long utilisateurId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                    "FROM Depense d JOIN FETCH d.categorie JOIN FETCH d.compte c WHERE c.utilisateur.id = :userId ORDER BY d.date DESC", Depense.class)
                    .setParameter("userId", utilisateurId)
                    .getResultList();
        }
    }

    public List<Revenu> getRevenusParUtilisateur(Long utilisateurId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                    "FROM Revenu r JOIN FETCH r.categorie JOIN FETCH r.compte c WHERE c.utilisateur.id = :userId ORDER BY r.date DESC", Revenu.class)
                    .setParameter("userId", utilisateurId)
                    .getResultList();
        }
    }
}