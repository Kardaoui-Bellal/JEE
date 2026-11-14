package com.example.servlet;

import com.example.models.Utilisateur;
import com.example.util.HibernateUtil;
import org.hibernate.Session;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/logout"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/logout".equals(path)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Utilisateur utilisateurTrouve = null;

        try (Session hSession = HibernateUtil.getSessionFactory().openSession()) {
            Utilisateur u = hSession.createQuery(
                            "FROM Utilisateur u WHERE u.email = :email", Utilisateur.class)
                    .setParameter("email", email)
                    .uniqueResult();

            if (u != null && u.getMotDePasseHash() != null && u.getMotDePasseHash().equals(password)) {
                utilisateurTrouve = u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (utilisateurTrouve != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("utilisateur", utilisateurTrouve);
            response.sendRedirect(request.getContextPath() + "/views/home.jsp");
        } else {
            request.setAttribute("error", "Email ou mot de passe incorrect.");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}