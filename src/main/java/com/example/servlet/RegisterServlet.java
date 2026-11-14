// package com.example.servlet;

// import java.io.IOException;

// import jakarta.servlet.ServletException;
// import jakarta.servlet.annotation.WebServlet;
// import jakarta.servlet.http.HttpServlet;
// import jakarta.servlet.http.HttpServletRequest;
// import jakarta.servlet.http.HttpServletResponse;

// @WebServlet("/register")
// public class RegisterServlet extends HttpServlet {

//     @Override
//     protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//         request.getRequestDispatcher("/views/register.jsp").forward(request, response);
//     }

//     @Override
//     protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//         String nom = request.getParameter("nom");
//         String email = request.getParameter("email");
//         String password = request.getParameter("password");

//         if (nom != null && !nom.isEmpty() && email != null && password != null) {

//             response.sendRedirect(request.getContextPath() + "/login");
//         } else {
//             request.setAttribute("error", "Veuillez remplirTous les Champs.");
//             request.getRequestDispatcher("/views/register.jsp").forward(request, response);
//         }
//     }
// }