package com.example.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;

import com.example.dao.TransactionDAO;
import com.example.models.Depense;
import com.example.service.BudgetService;

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
            int categorieId = Integer.parseInt(request.getParameter("categorieId"));
            int compteId = 1; 
            String description = request.getParameter("description");
            String modePaiement = request.getParameter("modePaiement");
            Date date = Date.valueOf(request.getParameter("date"));

            Depense depense = new Depense();
            depense.setMontant(montant);
            depense.setDate(date);
            depense.setDescription(description);
            depense.setModePaiement(modePaiement);

            int generatedId = transactionDAO.ajouterTransaction(depense, compteId, categorieId);

            if (generatedId != -1) {
                int mois = date.toLocalDate().getMonthValue();
                budgetService.verifierBudget(categorieId, mois);
            }

            response.sendRedirect(request.getContextPath() + "/views/home.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/home.jsp?error=1");
        }
    }
}