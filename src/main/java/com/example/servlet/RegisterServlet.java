package com.example.servlet;

import com.example.dao.UtilisateurDAO;
import com.example.models.Role;
import com.example.models.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (nom == null || nom.trim().isEmpty() || email == null || email.trim().isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "Veuillez remplir tous les champs.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        if (utilisateurDAO.trouverParEmail(email.trim()) != null) {
            request.setAttribute("error", "Cet email est déjà utilisé.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        Utilisateur utilisateur = new Utilisateur();
        utilisateur.setNom(nom.trim());
        utilisateur.setEmail(email.trim());
        utilisateur.setMotDePasseHash(password);
        utilisateur.setActif(true);
        utilisateur.setRole(Role.USER);
        utilisateur.setDateCreation(LocalDateTime.now());

        boolean enregistre = utilisateurDAO.enregistrerUtilisateur(utilisateur);

        if (enregistre) {
            response.sendRedirect(request.getContextPath() + "/login?registered=1");
        } else {
            request.setAttribute("error", "Erreur lors de l'enregistrement du compte.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }
    }
}