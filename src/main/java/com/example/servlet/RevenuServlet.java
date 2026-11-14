// package com.example.servlet;

// import java.io.IOException;
// import java.math.BigDecimal;
// import java.time.LocalDate;

// import com.example.models.Utilisateur;
// import com.example.service.CategorieService;
// import com.example.service.CompteService;
// import com.example.service.TransactionService;

// import jakarta.servlet.ServletException;
// import jakarta.servlet.annotation.WebServlet;
// import jakarta.servlet.http.HttpServlet;
// import jakarta.servlet.http.HttpServletRequest;
// import jakarta.servlet.http.HttpServletResponse;
// import jakarta.servlet.http.HttpSession;

// @WebServlet("/revenus")
// public class RevenuServlet extends HttpServlet {

//     private final TransactionService transactionService = new TransactionService();
//     private final CategorieService categorieService = new CategorieService();
//     private final CompteService compteService = new CompteService();

//     @Override
//     protected void doGet(HttpServletRequest request, HttpServletResponse response)
//             throws ServletException, IOException {

//         HttpSession session = request.getSession(false);
//         Utilisateur utilisateur = (Utilisateur) (session != null ? session.getAttribute("utilisateur") : null);

//         if (utilisateur == null) {
//             response.sendRedirect(request.getContextPath() + "/login");
//             return;
//         }

//         request.setAttribute("revenus", transactionService.getRevenusParUtilisateur(utilisateur.getId()));
//         request.setAttribute("depenses", transactionService.getDepensesParUtilisateur(utilisateur.getId()));
//         request.setAttribute("categories", categorieService.getCategoriesParUtilisateur(utilisateur.getId()));
//         request.setAttribute("comptes", compteService.getComptesParUtilisateur(utilisateur.getId()));
//         request.getRequestDispatcher("/views/depenses.jsp").forward(request, response);
//     }

//     @Override
//     protected void doPost(HttpServletRequest request, HttpServletResponse response)
//             throws ServletException, IOException {

//         HttpSession session = request.getSession(false);
//         Utilisateur utilisateur = (Utilisateur) (session != null ? session.getAttribute("utilisateur") : null);

//         if (utilisateur == null) {
//             response.sendRedirect(request.getContextPath() + "/login");
//             return;
//         }

//         try {
//             BigDecimal montant = new BigDecimal(request.getParameter("montant"));
//             Long categorieId = Long.parseLong(request.getParameter("categorieId"));
//             Long compteId = Long.parseLong(request.getParameter("compteId"));
//             String source = request.getParameter("source");
//             String description = request.getParameter("description");
//             LocalDate date = LocalDate.parse(request.getParameter("date"));

//             transactionService.ajouterRevenu(montant, categorieId, compteId, source, description, date);
//             response.sendRedirect(request.getContextPath() + "/revenus?success=1");
//         } catch (Exception e) {
//             e.printStackTrace();
//             response.sendRedirect(request.getContextPath() + "/revenus?error=1");
//         }
//     }
// }