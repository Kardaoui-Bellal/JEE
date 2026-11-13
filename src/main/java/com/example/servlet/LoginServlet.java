package com.example.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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

    if ("admin@admin.com".equals(email) && "1234".equals(password)) {
        HttpSession session = request.getSession();
        session.setAttribute("user", email);
        
        response.sendRedirect(request.getContextPath() + "/views/home.jsp"); 
    } else {
        request.setAttribute("error", "Email ou mot de passe incorrect.");
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }
}}