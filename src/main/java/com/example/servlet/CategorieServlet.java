package com.example.servlet;

import com.example.models.Categorie;
import com.example.models.TypeCategorie;
import com.example.models.Utilisateur;
import com.example.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/categories")
public class CategorieServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = (Utilisateur) (session != null ? session.getAttribute("utilisateur") : null);

        if (utilisateur == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try (Session hSession = HibernateUtil.getSessionFactory().openSession()) {
            List<Categorie> categories = hSession.createQuery(
                            "FROM Categorie c WHERE c.utilisateur.id = :userId", Categorie.class)
                    .setParameter("userId", utilisateur.getId())
                    .getResultList();

            request.setAttribute("categories", categories);
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
            String nom = request.getParameter("nom");
            String typeStr = request.getParameter("type");
            String couleur = request.getParameter("couleur");

            Transaction tx = null;
            try (Session hSession = HibernateUtil.getSessionFactory().openSession()) {
                tx = hSession.beginTransaction();

                Categorie categorie = new Categorie();
                categorie.setNom(nom);
                categorie.setType(TypeCategorie.valueOf(typeStr));
                categorie.setCouleur(couleur != null && !couleur.isEmpty() ? couleur : "#f97316");
                categorie.setUtilisateur(utilisateur);

                hSession.persist(categorie);
                tx.commit();
            } catch (Exception e) {
                if (tx != null) tx.rollback();
                throw e;
            }

            response.sendRedirect(request.getContextPath() + "/categories?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/categories?error=1");
        }
    }
}