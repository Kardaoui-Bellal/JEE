package com.example.servlet;

import java.io.IOException;
import java.math.BigDecimal;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.example.models.Budget;

@WebServlet("/test-view")
public class TestServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        

      /*
        Budget budget = new Budget(1, "2026-11", new BigDecimal("1000.00"), new BigDecimal("850.00"));
        request.setAttribute("testMessage", "Connexion et Modèle opérationnels !");
        request.setAttribute("plafond", budget.getPlafond());
        request.setAttribute("depense", budget.getMontantDepense());
        request.setAttribute("depasse", budget.verifierDepassement());
        request.getRequestDispatcher("/views/testView.jsp").forward(request, response);
        */
    }
}