<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.models.Categorie" %>
<%@ page import="com.example.models.Utilisateur" %>
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
    if (utilisateur == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html lang="fr" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catégories | FinTrack.JEE</title>
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
                <a href="<%= request.getContextPath() %>/categories" class="px-4 py-2 rounded-lg bg-orange-500 text-white text-sm font-semibold">Catégories</a>
                <a href="<%= request.getContextPath() %>/budgets" class="px-4 py-2 rounded-lg text-zinc-400 hover:text-white text-sm font-medium transition">Budgets & Alertes</a>
            </nav>
            <a href="<%= request.getContextPath() %>/logout" class="bg-red-500/10 hover:bg-red-500 text-red-400 hover:text-white border border-red-500/20 px-3.5 py-2 rounded-xl text-xs font-semibold transition">Quitter</a>
        </div>
    </header>

    <main class="flex-1 max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="mb-8">
            <h1 class="text-3xl font-extrabold text-white">Gestion des Catégories</h1>
            <p class="text-zinc-400 text-sm mt-1">Organisez vos revenus et dépenses par postes budgétaires.</p>
        </div>

        <% if ("1".equals(request.getParameter("success"))) { %>
            <div class="mb-6 p-4 rounded-2xl bg-emerald-500/10 border border-emerald-500/30 text-emerald-300 text-sm">
                Catégorie créée avec succès !
            </div>
        <% } %>
        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="mb-6 p-4 rounded-2xl bg-red-500/10 border border-red-500/30 text-red-300 text-sm">
                Erreur lors de la création de la catégorie.
            </div>
        <% } %>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
            <div class="lg:col-span-4">
                <div class="glass-card rounded-3xl p-6">
                    <h2 class="text-lg font-bold text-white mb-5 flex items-center gap-2">
                        <i data-lucide="tag" class="w-5 h-5 text-orange-400"></i> Nouvelle Catégorie
                    </h2>
                    <form action="<%= request.getContextPath() %>/categories" method="POST" class="space-y-4">
                        <div>
                            <label class="block text-xs font-semibold uppercase text-zinc-400 mb-1.5">Nom *</label>
                            <input type="text" name="nom" required placeholder="Ex: Alimentation, Transport, Salaire"
                                class="w-full bg-zinc-900 border border-zinc-700 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:outline-none">
                        </div>
                        <div>
                            <label class="block text-xs font-semibold uppercase text-zinc-400 mb-1.5">Type *</label>
                            <select name="type" class="w-full bg-zinc-900 border border-zinc-700 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:outline-none">
                                <option value="DEPENSE">Dépense</option>
                                <option value="REVENU">Revenu</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-xs font-semibold uppercase text-zinc-400 mb-1.5">Couleur d'affichage</label>
                            <input type="color" name="couleur" value="#f97316"
                                class="w-full h-11 bg-zinc-900 border border-zinc-700 rounded-xl cursor-pointer p-1">
                        </div>
                        <button type="submit" class="w-full bg-gradient-to-r from-orange-600 to-amber-500 hover:from-orange-500 hover:to-amber-400 text-white font-bold py-3 rounded-xl shadow-lg transition">
                            Ajouter la catégorie
                        </button>
                    </form>
                </div>
            </div>

            <div class="lg:col-span-8">
                <div class="glass-card rounded-3xl p-6">
                    <h2 class="text-lg font-bold text-white mb-5">Mes Catégories (Utilisez l'ID lors de l'ajout d'une dépense)</h2>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="border-b border-zinc-800 text-xs uppercase text-zinc-400">
                                    <th class="py-3 px-4">ID</th>
                                    <th class="py-3 px-4">Couleur</th>
                                    <th class="py-3 px-4">Nom</th>
                                    <th class="py-3 px-4">Type</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-zinc-800/70 text-sm">
                                <% if (categories != null && !categories.isEmpty()) {
                                    for (Categorie cat : categories) { %>
                                    <tr class="hover:bg-zinc-900/60 transition">
                                        <td class="py-3.5 px-4 font-mono text-orange-400 font-bold">#<%= cat.getId() %></td>
                                        <td class="py-3.5 px-4">
                                            <span class="inline-block w-5 h-5 rounded-full border border-white/20" style="background-color: <%= cat.getCouleur() %>;"></span>
                                        </td>
                                        <td class="py-3.5 px-4 font-semibold text-white"><%= cat.getNom() %></td>
                                        <td class="py-3.5 px-4">
                                            <% if ("DEPENSE".equals(cat.getType().name())) { %>
                                                <span class="px-2.5 py-1 rounded-full text-xs font-semibold bg-red-500/15 text-red-400 border border-red-500/20">DÉPENSE</span>
                                            <% } else { %>
                                                <span class="px-2.5 py-1 rounded-full text-xs font-semibold bg-emerald-500/15 text-emerald-400 border border-emerald-500/20">REVENU</span>
                                            <% } %>
                                        </td>
                                    </tr>
                                <% } } else { %>
                                    <tr>
                                        <td colspan="4" class="py-8 text-center text-zinc-500">Aucune catégorie enregistrée.</td>
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