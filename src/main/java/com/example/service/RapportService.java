package com.example.service;

import java.util.List;

import org.hibernate.Session;

import com.example.models.Depense;
import com.example.models.Revenu;
import com.example.util.HibernateUtil;

public class RapportService {

    public String genererCsvMensuel(Long utilisateurId, int mois, int annee) {
        StringBuilder csv = new StringBuilder();
        csv.append("Type;Date;Categorie;Compte;Description;Montant (MAD)\n");

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            List<Depense> depenses = session.createQuery(
                    "FROM Depense d JOIN FETCH d.categorie JOIN FETCH d.compte c WHERE c.utilisateur.id = :userId AND MONTH(d.date) = :mois AND YEAR(d.date) = :annee ORDER BY d.date ASC", Depense.class)
                    .setParameter("userId", utilisateurId)
                    .setParameter("mois", mois)
                    .setParameter("annee", annee)
                    .getResultList();

            for (Depense d : depenses) {
                csv.append("DEPENSE;")
                   .append(d.getDate()).append(";")
                   .append(d.getCategorie().getNom()).append(";")
                   .append(d.getCompte().getNom()).append(";")
                   .append(d.getDescription() != null ? d.getDescription().replace(";", ",") : "").append(";")
                   .append("-").append(d.getMontant()).append("\n");
            }

            List<Revenu> revenus = session.createQuery(
                    "FROM Revenu r JOIN FETCH r.categorie JOIN FETCH r.compte c WHERE c.utilisateur.id = :userId AND MONTH(r.date) = :mois AND YEAR(r.date) = :annee ORDER BY r.date ASC", Revenu.class)
                    .setParameter("userId", utilisateurId)
                    .setParameter("mois", mois)
                    .setParameter("annee", annee)
                    .getResultList();

            for (Revenu r : revenus) {
                csv.append("REVENU;")
                   .append(r.getDate()).append(";")
                   .append(r.getCategorie().getNom()).append(";")
                   .append(r.getCompte().getNom()).append(";")
                   .append(r.getDescription() != null ? r.getDescription().replace(";", ",") : "").append(";")
                   .append("+").append(r.getMontant()).append("\n");
            }
        }

        return csv.toString();
    }
}