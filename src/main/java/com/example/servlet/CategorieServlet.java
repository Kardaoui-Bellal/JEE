package com.example.servlet;

import com.example.models.TypeCategorie;
import com.example.models.Utilisateur;
import com.example.service.CategorieService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/categories")
public class CategorieServlet extends HttpServlet {

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
            request.setAttribute("categories", categorieService.getCategoriesParUtilisateur(utilisateur.getId()));
            request.getRequestDispatcher("/views/categories.jsp").forward(request, response);
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
            String action = request.getParameter("action");

            if ("defaut".equals(action)) {
                categorieService.initialiserCategoriesParDefaut(utilisateur.getId());
                response.sendRedirect(request.getContextPath() + "/categories?success=defaut");
                return;
            }

            String nom = request.getParameter("nom");
            TypeCategorie type = TypeCategorie.valueOf(request.getParameter("type"));
            String couleur = request.getParameter("couleur");

            categorieService.creerCategorie(nom, type, couleur, utilisateur.getId());
            response.sendRedirect(request.getContextPath() + "/categories?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/categories?error=1");
        }
    }
}
