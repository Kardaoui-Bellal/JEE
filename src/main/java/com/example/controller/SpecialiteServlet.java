package com.example.controller;

import com.example.models.Specialite;
import com.example.dao.SpecialiteDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet({"", "/", "/specialites", "/ajouter", "/supprimer", "/modifier"})
public class SpecialiteServlet extends HttpServlet {
    private SpecialiteDao specialiteDao;

    @Override
    public void init() {
        specialiteDao = new SpecialiteDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();

        switch (action) {
            case "":
            case "/":
                resp.sendRedirect("specialites");
                break;
            case "/ajouter":
                req.getRequestDispatcher("form.jsp").forward(req, resp);
                break;
            case "/supprimer":
                int idDel = Integer.parseInt(req.getParameter("id"));
                specialiteDao.supprimerSpecialite(idDel);
                resp.sendRedirect("specialites");
                break;
            case "/modifier":
                int idMod = Integer.parseInt(req.getParameter("id"));
                Specialite spec = specialiteDao.obtenirSpecialiteParId(idMod);
                req.setAttribute("specialite", spec);
                req.getRequestDispatcher("edit.jsp").forward(req, resp);
                break;
            case "/specialites":
            default:
                List<Specialite> specialites = specialiteDao.listerSpecialites();
                req.setAttribute("specialites", specialites);
                req.getRequestDispatcher("index.jsp").forward(req, resp);
                break;
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getServletPath();

        if ("/ajouter".equals(action)) {
            String nom = req.getParameter("nom");
            String description = req.getParameter("description");
            Specialite s = new Specialite();
            s.setNom(nom);
            s.setDescription(description);
            specialiteDao.ajouterSpecialite(s);
        } else if ("/modifier".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String nom = req.getParameter("nom");
            String description = req.getParameter("description");
            Specialite s = new Specialite();
            s.setId(id);
            s.setNom(nom);
            s.setDescription(description);
            specialiteDao.modifierSpecialite(s);
        }

        resp.sendRedirect("specialites");
    }
}