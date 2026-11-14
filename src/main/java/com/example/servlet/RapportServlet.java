package com.example.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

import com.example.models.Utilisateur;
import com.example.service.RapportService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/rapports")
public class RapportServlet extends HttpServlet {

    private final RapportService rapportService = new RapportService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = (Utilisateur) (session != null ? session.getAttribute("utilisateur") : null);

        if (utilisateur == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        LocalDate now = LocalDate.now();
        int mois = request.getParameter("mois") != null ? Integer.parseInt(request.getParameter("mois")) : now.getMonthValue();
        int annee = request.getParameter("annee") != null ? Integer.parseInt(request.getParameter("annee")) : now.getYear();

        String csvContent = rapportService.genererCsvMensuel(utilisateur.getId(), mois, annee);

        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"rapport_budget_" + annee + "_" + mois + ".csv\"");

        try (PrintWriter writer = response.getWriter()) {
            writer.write("\uFEFF");
            writer.write(csvContent);
        }
    }
}
