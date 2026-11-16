package com.example.servlet;

import com.example.models.Utilisateur;
import com.example.service.BudgetService;
import com.example.service.CategorieService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;

@WebServlet("/budgets")
public class BudgetServlet extends HttpServlet {

    private final BudgetService budgetService = new BudgetService();
    private final CategorieService categorieService = new CategorieService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = (Utilisateur) (session != null ? session.getAttribute("utilisateur") : null);

        if (utilisateur == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            request.setAttribute("budgets", budgetService.getBudgetsParUtilisateur(utilisateur.getId()));
            request.setAttribute("categories", categorieService.getCategoriesParUtilisateur(utilisateur.getId()));
            request.setAttribute("alertes", budgetService.getAlertesParUtilisateur(utilisateur.getId()));
            request.getRequestDispatcher("/views/budgets.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/home.jsp?error=1");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = (Utilisateur) (session != null ? session.getAttribute("utilisateur") : null);

        if (utilisateur == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            Long categorieId = Long.parseLong(request.getParameter("categorieId"));
            BigDecimal plafond = new BigDecimal(request.getParameter("plafond"));
            BigDecimal seuilAlerte = new BigDecimal(request.getParameter("seuilAlerte"));
            LocalDate periode = LocalDate.parse(request.getParameter("periode") + "-01");

            budgetService.creerBudget(categorieId, utilisateur.getId(), plafond, seuilAlerte, periode);
            response.sendRedirect(request.getContextPath() + "/budgets?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/budgets?error=1");
        }
    }
}