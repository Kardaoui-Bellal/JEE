package com.example.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;

import com.example.dao.TransactionDAO;
import com.example.models.Depense;
import com.example.models.Compte;
import com.example.models.Categorie;
import com.example.models.ModePaiement;
import com.example.service.BudgetService;
import com.example.util.HibernateUtil;
import org.hibernate.Session;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/expenses/ajouter")
public class TransactionServlet extends HttpServlet {

    private TransactionDAO transactionDAO = new TransactionDAO();
    private BudgetService budgetService = new BudgetService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            BigDecimal montant = new BigDecimal(request.getParameter("montant"));
            Long categorieId = Long.parseLong(request.getParameter("categorieId"));
            Long compteId = 1L;
            String description = request.getParameter("description");
            String modePaiementStr = request.getParameter("modePaiement");
            LocalDate date = LocalDate.parse(request.getParameter("date"));

            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                Compte compte = session.get(Compte.class, compteId);
                Categorie categorie = session.get(Categorie.class, categorieId);

                Depense depense = new Depense();
                depense.setMontant(montant);
                depense.setDate(date);
                depense.setDescription(description);
                depense.setModePaiement(ModePaiement.valueOf(modePaiementStr));
                depense.setCompte(compte);
                depense.setCategorie(categorie);

                transactionDAO.sauvegarderTransaction(depense);

                if (depense.getId() != null) {
                    int mois = date.getMonthValue();
                    // budgetService.verifierBudget(categorieId.intValue(), mois);
                }
            }

            response.sendRedirect(request.getContextPath() + "/views/home.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/home.jsp?error=1");
        }
    }
}