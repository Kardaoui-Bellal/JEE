<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.YearMonth" %>
<%@ page import="com.example.models.Budget" %>
<%@ page import="com.example.models.Categorie" %>
<%@ page import="com.example.models.Alerte" %>
<%@ page import="com.example.models.Utilisateur" %>
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
    if (utilisateur == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<Budget> budgets = (List<Budget>) request.getAttribute("budgets");
    List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
    List<Alerte> alertes = (List<Alerte>) request.getAttribute("alertes");
    String moisCourant = YearMonth.now().toString();
%>
<!DOCTYPE html>
<html lang="fr" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Budgets & Alertes | FinTrack.JEE</title>
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
                <a href="<%= request.getContextPath() %>/budgets" class="px-4 py-2 rounded-lg bg-orange-500 text-white text-sm font-semibold">Budgets & Alertes</a>
            </nav>
            <a href="<%= request.getContextPath() %>/logout" class="bg-red-500/10 hover:bg-red-500 text-red-400 hover:text-white border border-red-500/20 px-3.5 py-2 rounded-xl text-xs font-semibold transition">Quitter</a>
        </div>
    </header>

    <main class="flex-1 max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="mb-8">
            <h1 class="text-3xl font-extrabold text-white">Budgets Mensuels & Alertes</h1>
            <p class="text-zinc-400 text-sm mt-1">Définissez vos plafonds par catégorie et surveillez vos notifications automatiques.</p>
        </div>

        <% if ("1".equals(request.getParameter("success"))) { %>
            <div class="mb-6 p-4 rounded-2xl bg-emerald-500/10 border border-emerald-500/30 text-emerald-300 text-sm">
                Budget mensuel défini avec succès !
            </div>
        <% } %>
        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="mb-6 p-4 rounded-2xl bg-red-500/10 border border-red-500/30 text-red-300 text-sm">
                Erreur lors de l'enregistrement du budget (vérifiez qu'un budget n'existe pas déjà pour cette catégorie ce mois-ci).
            </div>
        <% } %>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
            <div class="lg:col-span-4">
                <div class="glass-card rounded-3xl p-6">
                    <h2 class="text-lg font-bold text-white mb-5 flex items-center gap-2">
                        <i data-lucide="pie-chart" class="w-5 h-5 text-orange-400"></i> Définir un Budget
                    </h2>
                    <form action="<%= request.getContextPath() %>/budgets" method="POST" class="space-y-4">
                        <div>
                            <label class="block text-xs font-semibold uppercase text-zinc-400 mb-1.5">Catégorie *</label>
                            <select name="categorieId" required class="w-full bg-zinc-900 border border-zinc-700 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:outline-none">
                                <% if (categories != null) {
                                    for (Categorie c : categories) { %>
                                    <option value="<%= c.getId() %>"><%= c.getNom() %> (<%= c.getType() %>)</option>
                                <% } } %>
                            </select>
                        </div>
                        <div>
                            <label class="block text-xs font-semibold uppercase text-zinc-400 mb-1.5">Mois concerné *</label>
                            <input type="month" name="periode" value="<%= moisCourant %>" required
                                class="w-full bg-zinc-900 border border-zinc-700 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:outline-none">
                        </div>
                        <div>
                            <label class="block text-xs font-semibold uppercase text-zinc-400 mb-1.5">Plafond (MAD) *</label>
                            <input type="number" step="0.01" min="1" name="plafond" required placeholder="Ex: 2000.00"
                                class="w-full bg-zinc-900 border border-zinc-700 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:outline-none">
                        </div>
                        <div>
                            <label class="block text-xs font-semibold uppercase text-zinc-400 mb-1.5">Seuil d'alerte (%) *</label>
                            <input type="number" step="1" min="1" max="100" name="seuilAlerte" value="80" required
                                class="w-full bg-zinc-900 border border-zinc-700 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:outline-none">
                        </div>
                        <button type="submit" class="w-full bg-gradient-to-r from-orange-600 to-amber-500 hover:from-orange-500 hover:to-amber-400 text-white font-bold py-3 rounded-xl shadow-lg transition">
                            Enregistrer le budget
                        </button>
                    </form>
                </div>
            </div>

            <div class="lg:col-span-8 space-y-6">
                <div class="glass-card rounded-3xl p-6">
                    <h2 class="text-lg font-bold text-white mb-4 flex items-center gap-2">
                        <i data-lucide="bell-ring" class="w-5 h-5 text-amber-400"></i> Alertes Déclenchées
                    </h2>
                    <div class="space-y-3">
                        <% if (alertes != null && !alertes.isEmpty()) {
                            for (Alerte alerte : alertes) {
                                boolean isDepassement = "DEPASSEMENT".equals(alerte.getType().name()); %>
                            <div class="p-4 rounded-2xl border <%= isDepassement ? "bg-red-500/10 border-red-500/30 text-red-300" : "bg-amber-500/10 border-amber-500/30 text-amber-300" %> flex items-center justify-between">
                                <div>
                                    <span class="text-xs font-bold uppercase tracking-wider px-2 py-0.5 rounded <%= isDepassement ? "bg-red-500/20 text-red-400" : "bg-amber-500/20 text-amber-400" %>">
                                        <%= alerte.getType() %> • <%= alerte.getBudget().getCategorie().getNom() %>
                                    </span>
                                    <p class="text-sm font-medium mt-1.5"><%= alerte.getMessage() %></p>
                                </div>
                                <i data-lucide="alert-circle" class="w-5 h-5 shrink-0"></i>
                            </div>
                        <% } } else { %>
                            <p class="text-sm text-zinc-500 py-3">Aucune alerte générée pour le moment.</p>
                        <% } %>
                    </div>
                </div>

                <div class="glass-card rounded-3xl p-6">
                    <h2 class="text-lg font-bold text-white mb-4">Budgets Actifs</h2>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="border-b border-zinc-800 text-xs uppercase text-zinc-400">
                                    <th class="py-3 px-4">Catégorie</th>
                                    <th class="py-3 px-4">Période</th>
                                    <th class="py-3 px-4">Plafond</th>
                                    <th class="py-3 px-4">Seuil</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-zinc-800/70 text-sm">
                                <% if (budgets != null && !budgets.isEmpty()) {
                                    for (Budget b : budgets) { %>
                                    <tr class="hover:bg-zinc-900/60 transition">
                                        <td class="py-3.5 px-4 font-semibold text-white"><%= b.getCategorie().getNom() %></td>
                                        <td class="py-3.5 px-4 text-zinc-400"><%= b.getPeriode().toString().substring(0, 7) %></td>
                                        <td class="py-3.5 px-4 font-bold text-orange-400"><%= String.format("%.2f", b.getPlafond()) %> MAD</td>
                                        <td class="py-3.5 px-4 text-zinc-300"><%= b.getSeuilAlerte() %>%</td>
                                    </tr>
                                <% } } else { %>
                                    <tr>
                                        <td colspan="4" class="py-6 text-center text-zinc-500">Aucun budget configuré.</td>
                                    </tr>
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
</html>