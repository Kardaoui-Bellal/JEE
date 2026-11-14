package com.example.servlet;

import com.example.models.Utilisateur;
import com.example.service.CompteService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/comptes")
public class CompteServlet extends HttpServlet {

    private final CompteService compteService = new CompteService();

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
            request.setAttribute("comptes", compteService.getComptesParUtilisateur(utilisateur.getId()));
            request.getRequestDispatcher("/views/comptes.jsp").forward(request, response);
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
            String nom = request.getParameter("nom");
            BigDecimal soldeInitial = new BigDecimal(request.getParameter("soldeInitial"));
            String devise = request.getParameter("devise");

            compteService.creerCompte(nom, soldeInitial, devise, utilisateur.getId());
            response.sendRedirect(request.getContextPath() + "/comptes?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/comptes?error=1");
        }
    }
}