package com.example.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.example.models.Alerte;
import com.example.models.Budget;
import com.example.models.Categorie;
import com.example.models.TypeAlerte;
import com.example.models.Utilisateur;
import com.example.util.HibernateUtil;
/*
public class BudgetService {

    public void creerBudget(Long categorieId, Long utilisateurId, BigDecimal plafond, BigDecimal seuilAlerte, LocalDate periode) throws Exception {
        if (plafond == null || plafond.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Le plafond doit être strictement positif.");
        }

        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();

            String hqlExist = "SELECT COUNT(b) FROM Budget b WHERE b.utilisateur.id = :userId AND b.categorie.id = :catId AND MONTH(b.periode) = :mois AND YEAR(b.periode) = :annee";
            Long count = session.createQuery(hqlExist, Long.class)
                    .setParameter("userId", utilisateurId)
                    .setParameter("catId", categorieId)
                    .setParameter("mois", periode.getMonthValue())
                    .setParameter("annee", periode.getYear())
                    .uniqueResult();

            if (count != null && count > 0) {
                throw new IllegalStateException("Un budget existe déjà pour cette catégorie et cette période.");
            }

            Categorie categorie = session.get(Categorie.class, categorieId);
            Utilisateur utilisateur = session.get(Utilisateur.class, utilisateurId);

            Budget budget = new Budget();
            budget.setCategorie(categorie);
            budget.setUtilisateur(utilisateur);
            budget.setPlafond(plafond);
            budget.setSeuilAlerte(seuilAlerte != null ? seuilAlerte : new BigDecimal("80.00"));
            budget.setPeriode(periode.withDayOfMonth(1));

            session.persist(budget);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public List<Budget> getBudgetsParUtilisateur(Long utilisateurId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                            "FROM Budget b JOIN FETCH b.categorie WHERE b.utilisateur.id = :userId ORDER BY b.periode DESC", Budget.class)
                    .setParameter("userId", utilisateurId)
                    .getResultList();
        }
    }

    public List<Alerte> getAlertesParUtilisateur(Long utilisateurId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                            "FROM Alerte a JOIN FETCH a.budget b JOIN FETCH b.categorie WHERE b.utilisateur.id = :userId ORDER BY a.id DESC", Alerte.class)
                    .setParameter("userId", utilisateurId)
                    .getResultList();
        }
    }

    public void verifierBudget(Long categorieId, int mois, int annee, Long utilisateurId) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            String hqlBudget = "FROM Budget b WHERE b.categorie.id = :catId AND b.utilisateur.id = :userId AND MONTH(b.periode) = :mois AND YEAR(b.periode) = :annee";
            Budget budget = session.createQuery(hqlBudget, Budget.class)
                    .setParameter("catId", categorieId)
                    .setParameter("userId", utilisateurId)
                    .setParameter("mois", mois)
                    .setParameter("annee", annee)
                    .uniqueResult();

            if (budget == null) {
                return;
            }

            String hqlSum = "SELECT SUM(t.montant) FROM Depense t WHERE t.categorie.id = :catId AND MONTH(t.date) = :mois AND YEAR(t.date) = :annee";
            BigDecimal totalDepense = session.createQuery(hqlSum, BigDecimal.class)
                    .setParameter("catId", categorieId)
                    .setParameter("mois", mois)
                    .setParameter("annee", annee)
                    .uniqueResult();

            if (totalDepense == null) {
                totalDepense = BigDecimal.ZERO;
            }

            BigDecimal plafond = budget.getPlafond();

            if (plafond.compareTo(BigDecimal.ZERO) > 0) {
                BigDecimal taux = totalDepense.multiply(new BigDecimal("100"))
                        .divide(plafond, 2, RoundingMode.HALF_UP);

                tx = session.beginTransaction();
                BigDecimal seuilAlerte = budget.getSeuilAlerte() != null ? budget.getSeuilAlerte() : new BigDecimal("80.00");

                if (taux.compareTo(new BigDecimal("100")) >= 0) {
                    creerAlarteSiAbsente(session, budget, TypeAlerte.DEPASSEMENT, "Congratulation you're broke now !");
                } else if (taux.compareTo(seuilAlerte) >= 0) {
                    creerAlarteSiAbsente(session, budget, TypeAlerte.SEUIL, "warning keep going and you'll end up in debt aand homeless (" + taux + "%)");
                }

                tx.commit();
            }

        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    private void creerAlarteSiAbsente(Session session, Budget budget, TypeAlerte typeAlerte, String message) {
        String hqlCheck = "SELECT COUNT(a) FROM Alerte a WHERE a.budget.id = :budgetId AND a.type = :type";
        Long count = session.createQuery(hqlCheck, Long.class)
                .setParameter("budgetId", budget.getId())
                .setParameter("type", typeAlerte)
                .uniqueResult();

        if (count == 0) {
            Alerte alerte = new Alerte();
            alerte.setType(typeAlerte);
            alerte.setMessage(message);
            alerte.setBudget(budget);
            alerte.setLue(false);
            session.persist(alerte);
        }
    }
}
*/