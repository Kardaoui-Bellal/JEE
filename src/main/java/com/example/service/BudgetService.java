package com.example.servlet;

import com.example.models.Budget;
import com.example.models.Alerte;
import com.example.models.TypeAlerte;
import com.example.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class BudgetService {

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