<!-- <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.example.models.Depense" %>
<%@ page import="com.example.models.Revenu" %>
<%@ page import="com.example.models.Categorie" %>
<%@ page import="com.example.models.Compte" %>
<%@ page import="com.example.models.Utilisateur" %>
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
    if (utilisateur == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<Depense> depenses = (List<Depense>) request.getAttribute("depenses");
    List<Revenu> revenus = (List<Revenu>) request.getAttribute("revenus");
    List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
    List<Compte> comptes = (List<Compte>) request.getAttribute("comptes");
    String dateAujourdhui = LocalDate.now().toString();
%>
<!DOCTYPE html>
<html lang="fr" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transactions & Rapports | FinTrack.JEE</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #09090b; color: #fafafa; }
        .glass-card { background: rgba(24, 24, 27, 0.85); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.08); }
    </style>
</head>
<body class="min-h-screen flex flex-col bg-[#09090b] text-zinc-100">

    <header class="sticky top-0 z-50 glass-card border-b border-zinc-800/80">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-xl bg-gradient-to-tr from-orange-600 to-amber-500 flex items-center justify-center shadow-lg">
                    <i data-lucide="wallet" class="w-5 h-5 text-white"></i>
                </div>
                <span class="font-bold text-lg text-white">FinTrack<span class="text-orange-500">.JEE</span></span>
            </div>
            <nav class="hidden md:flex items-center gap-1 bg-zinc-900/90 p-1 rounded-xl border border-zinc-800">
                <a href="<%= request.getContextPath() %>/views/home.jsp" class="px-4 py-2 rounded-lg text-zinc-400 hover:text-white text-sm font-medium transition">Tableau de bord</a>
                <a href="<%= request.getContextPath() %>/comptes" class="px-4 py-2 rounded-lg text-zinc-400 hover:text-white text-sm font-medium transition">Comptes</a>
                <a href="<%= request.getContextPath() %>/categories" class="px-4 py-2 rounded-lg text-zinc-400 hover:text-white text-sm font-medium transition">Catégories</a>
                <a href="<%= request.getContextPath() %>/budgets" class="px-4 py-2 rounded-lg text-zinc-400 hover:text-white text-sm font-medium transition">Budgets</a>
                <a href="<%= request.getContextPath() %>/revenus" class="px-4 py-2 rounded-lg bg-orange-500 text-white text-sm font-semibold">Transactions</a>
            </nav>
            <a href="<%= request.getContextPath() %>/logout" class="bg-red-500/10 hover:bg-red-500 text-red-400 hover:text-white border border-red-500/20 px-3.5 py-2 rounded-xl text-xs font-semibold transition">Quitter</a>
        </div>
    </header>

    <main class="flex-1 max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8">
            <div>
                <h1 class="text-3xl font-extrabold text-white">Transactions & Export CSV</h1>
                <p class="text-zinc-400 text-sm mt-1">Ajoutez vos revenus et consultez l'historique complet de vos mouvements.</p>
            </div>
            <a href="<%= request.getContextPath() %>/rapports" class="inline-flex items-center gap-2 bg-emerald-600 hover:bg-emerald-500 text-white font-bold px-5 py-2.5 rounded-xl shadow-lg transition text-sm">
                <i data-lucide="download" class="w-4 h-4"></i> Exporter Rapport CSV
            </a>
        </div>

        <% if ("1".equals(request.getParameter("success"))) { %>
            <div class="mb-6 p-4 rounded-2xl bg-emerald-500/10 border border-emerald-500/30 text-emerald-300 text-sm">
                Revenu enregistré et solde du compte mis à jour !
            </div>
        <% } %>
        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="mb-6 p-4 rounded-2xl bg-red-500/10 border border-red-500/30 text-red-300 text-sm">
                Erreur lors de l'enregistrement du revenu.
            </div>
        <% } %>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
            <div class="lg:col-span-4">
                <div class="glass-card rounded-3xl p-6">
                    <h2 class="text-lg font-bold text-white mb-5 flex items-center gap-2">
                        <i data-lucide="trending-up" class="w-5 h-5 text-emerald-400"></i> Nouveau Revenu
                    </h2>
                    <form action="<%= request.getContextPath() %>/revenus" method="POST" class="space-y-4">
                        <div>
                            <label class="block text-xs font-semibold uppercase text-zinc-400 mb-1.5">Montant (MAD) *</label>
                            <input type="number" step="0.01" min="0.01" name="montant" required placeholder="0.00"
                                class="w-full bg-zinc-900 border border-zinc-700 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:outline-none">
                        </div>
                        <div>
                            <label class="block text-xs font-semibold uppercase text-zinc-400 mb-1.5">Compte à créditer *</label>
                            <select name="compteId" required class="w-full bg-zinc-900 border border-zinc-700 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:outline-none">
                                <% if (comptes != null) {
                                    for (Compte cpt : comptes) { %>
                                    <option value="<%= cpt.getId() %>"><%= cpt.getNom() %> (<%= cpt.getSolde() %> MAD)</option>
                                <% } } %>
                            </select>
                        </div>
                        <div>
                            <label class="block text-xs font-semibold uppercase text-zinc-400 mb-1.5">Catégorie *</label>
                            <select name="categorieId" required class="w-full bg-zinc-900 border border-zinc-700 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:outline-none">
                                <% if (categories != null) {
                                    for (Categorie cat : categories) { %>
                                    <option value="<%= cat.getId() %>"><%= cat.getNom() %> (<%= cat.getType() %>)</option>
                                <% } } %>
                            </select>
                        </div>
                        <div>
                            <label class="block text-xs font-semibold uppercase text-zinc-400 mb-1.5">Source</label>
                            <input type="text" name="source" placeholder="Ex: Salaire, Freelance..."
                                class="w-full bg-zinc-900 border border-zinc-700 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:outline-none">
                        </div>
                        <div>
                            <label class="block text-xs font-semibold uppercase text-zinc-400 mb-1.5">Date *</label>
                            <input type="date" name="date" value="<%= dateAujourdhui %>" required
                                class="w-full bg-zinc-900 border border-zinc-700 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:outline-none">
                        </div>
                        <div>
                            <label class="block text-xs font-semibold uppercase text-zinc-400 mb-1.5">Description</label>
                            <input type="text" name="description" placeholder="Détails optionnels"
                                class="w-full bg-zinc-900 border border-zinc-700 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:outline-none">
                        </div>
                        <button type="submit" class="w-full bg-gradient-to-r from-emerald-600 to-teal-500 hover:from-emerald-500 hover:to-teal-400 text-white font-bold py-3 rounded-xl shadow-lg transition">
                            Enregistrer le revenu
                        </button>
                    </form>
                </div>
            </div>

            <div class="lg:col-span-8 space-y-6">
                <div class="glass-card rounded-3xl p-6">
                    <h2 class="text-lg font-bold text-white mb-4">Historique des Dépenses</h2>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="border-b border-zinc-800 text-xs uppercase text-zinc-400">
                                    <th class="py-3 px-4">Date</th>
                                    <th class="py-3 px-4">Catégorie</th>
                                    <th class="py-3 px-4">Compte</th>
                                    <th class="py-3 px-4">Description</th>
                                    <th class="py-3 px-4">Montant</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-zinc-800/70 text-sm">
                                <% if (depenses != null && !depenses.isEmpty()) {
                                    for (Depense d : depenses) { %>
                                    <tr class="hover:bg-zinc-900/60 transition">
                                        <td class="py-3 px-4 text-zinc-400"><%= d.getDate() %></td>
                                        <td class="py-3 px-4 font-semibold text-white"><%= d.getCategorie().getNom() %></td>
                                        <td class="py-3 px-4 text-zinc-300"><%= d.getCompte().getNom() %></td>
                                        <td class="py-3 px-4 text-zinc-400"><%= d.getDescription() != null ? d.getDescription() : "-" %></td>
                                        <td class="py-3 px-4 font-bold text-red-400">-<%= String.format("%.2f", d.getMontant()) %> MAD</td>
                                    </tr>
                                <% } } else { %>
                                    <tr><td colspan="5" class="py-6 text-center text-zinc-500">Aucune dépense enregistrée.</td></tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="glass-card rounded-3xl p-6">
                    <h2 class="text-lg font-bold text-white mb-4">Historique des Revenus</h2>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="border-b border-zinc-800 text-xs uppercase text-zinc-400">
                                    <th class="py-3 px-4">Date</th>
                                    <th class="py-3 px-4">Catégorie</th>
                                    <th class="py-3 px-4">Compte</th>
                                    <th class="py-3 px-4">Source</th>
                                    <th class="py-3 px-4">Montant</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-zinc-800/70 text-sm">
                                <% if (revenus != null && !revenus.isEmpty()) {
                                    for (Revenu r : revenus) { %>
                                    <tr class="hover:bg-zinc-900/60 transition">
                                        <td class="py-3 px-4 text-zinc-400"><%= r.getDate() %></td>
                                        <td class="py-3 px-4 font-semibold text-white"><%= r.getCategorie().getNom() %></td>
                                        <td class="py-3 px-4 text-zinc-300"><%= r.getCompte().getNom() %></td>
                                        <td class="py-3 px-4 text-zinc-400"><%= r.getSource() != null ? r.getSource() : "-" %></td>
                                        <td class="py-3 px-4 font-bold text-emerald-400">+<%= String.format("%.2f", r.getMontant()) %> MAD</td>
                                    </tr>
                                <% } } else { %>
                                    <tr><td colspan="5" class="py-6 text-center text-zinc-500">Aucun revenu enregistré.</td></tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script>lucide.createIcons();</script>
</body>
</html> -->