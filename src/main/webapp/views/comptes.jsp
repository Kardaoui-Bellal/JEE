<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.models.Compte" %>
<%@ page import="com.example.models.Utilisateur" %>
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
    if (utilisateur == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<Compte> comptes = (List<Compte>) request.getAttribute("comptes");
    if (comptes == null) {
        response.sendRedirect(request.getContextPath() + "/comptes");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comptes Financiers | FinTrack.JEE</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #09090b; color: #fafafa; }
        .glass-card { background: rgba(24, 24, 27, 0.85); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.08); }
        .orange-glow:hover { box-shadow: 0 0 25px rgba(249, 115, 22, 0.16); border-color: rgba(249, 115, 22, 0.35); }
    </style>
</head>
<body class="min-h-screen flex flex-col bg-[#09090b] text-zinc-100 selection:bg-orange-500 selection:text-white">

    <header class="sticky top-0 z-50 glass-card border-b border-zinc-800/80">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-xl bg-gradient-to-tr from-orange-600 to-amber-500 flex items-center justify-center shadow-lg shadow-orange-500/20">
                    <i data-lucide="wallet" class="w-5 h-5 text-white"></i>
                </div>
                <span class="font-bold text-lg text-white">FinTrack<span class="text-orange-500">.JEE</span></span>
            </div>

            <nav class="hidden md:flex items-center gap-1 bg-zinc-900/90 p-1 rounded-xl border border-zinc-800">
                <a href="<%= request.getContextPath() %>/views/home.jsp" class="px-4 py-2 rounded-lg text-zinc-400 hover:text-white text-sm font-medium transition">Tableau de bord</a>
                <a href="<%= request.getContextPath() %>/comptes" class="px-4 py-2 rounded-lg bg-orange-500 text-white text-sm font-semibold shadow-sm">Comptes</a>
                <a href="<%= request.getContextPath() %>/categories" class="px-4 py-2 rounded-lg text-zinc-400 hover:text-white text-sm font-medium transition">Catégories</a>
                <a href="<%= request.getContextPath() %>/budgets" class="px-4 py-2 rounded-lg text-zinc-400 hover:text-white text-sm font-medium transition">Budgets & Alertes</a>
                <a href="<%= request.getContextPath() %>/revenus" class="px-4 py-2 rounded-lg text-zinc-400 hover:text-white text-sm font-medium transition">Transactions</a>
            </nav>

            <a href="<%= request.getContextPath() %>/logout" class="flex items-center gap-1.5 bg-red-500/10 hover:bg-red-500 text-red-400 hover:text-white border border-red-500/20 px-3.5 py-2 rounded-xl text-xs font-semibold transition">
                <i data-lucide="log-out" class="w-4 h-4"></i>
                <span>Quitter</span>
            </a>
        </div>
    </header>

    <main class="flex-1 max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="mb-8">
            <h1 class="text-3xl font-extrabold text-white">Mes Comptes Financiers</h1>
            <p class="text-zinc-400 text-sm mt-1">Gérez vos comptes bancaires, espèces ou épargne et suivez vos soldes en temps réel.</p>
        </div>

        <% if ("1".equals(request.getParameter("success"))) { %>
            <div class="mb-6 p-4 rounded-2xl bg-emerald-500/10 border border-emerald-500/30 flex items-center gap-3 text-emerald-300 text-sm">
                <i data-lucide="check-circle-2" class="w-5 h-5 text-emerald-400 shrink-0"></i>
                <span>Compte enregistré avec succès !</span>
            </div>
        <% } %>
        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="mb-6 p-4 rounded-2xl bg-red-500/10 border border-red-500/30 flex items-center gap-3 text-red-300 text-sm">
                <i data-lucide="alert-triangle" class="w-5 h-5 text-red-400 shrink-0"></i>
                <span>Une erreur est survenue lors de l'enregistrement du compte.</span>
            </div>
        <% } %>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
            <div class="lg:col-span-4">
                <div class="glass-card rounded-3xl p-6 orange-glow transition duration-300">
                    <div class="flex items-center gap-3 mb-6">
                        <div class="w-10 h-10 rounded-xl bg-orange-500/15 border border-orange-500/30 flex items-center justify-center text-orange-400">
                            <i data-lucide="landmark" class="w-5 h-5"></i>
                        </div>
                        <div>
                            <h2 class="text-lg font-bold text-white">Nouveau Compte</h2>
                            <p class="text-xs text-zinc-400">Courant, Épargne ou Espèces</p>
                        </div>
                    </div>

                    <form action="<%= request.getContextPath() %>/comptes" method="POST" class="space-y-4">
                        <div>
                            <label class="block text-xs font-semibold uppercase tracking-wider text-zinc-400 mb-1.5">Nom du compte *</label>
                            <input type="text" name="nom" required placeholder="Ex: Compte Courant CIH"
                                class="w-full bg-zinc-900/90 border border-zinc-700/80 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:border-orange-500 focus:outline-none transition placeholder:text-zinc-600">
                        </div>

                        <div>
                            <label class="block text-xs font-semibold uppercase tracking-wider text-zinc-400 mb-1.5">Solde initial *</label>
                            <input type="number" step="0.01" min="0" name="soldeInitial" required placeholder="0.00"
                                class="w-full bg-zinc-900/90 border border-zinc-700/80 text-white px-4 py-2.5 rounded-xl text-sm font-semibold focus:ring-2 focus:ring-orange-500 focus:border-orange-500 focus:outline-none transition placeholder:text-zinc-600">
                        </div>

                        <div>
                            <label class="block text-xs font-semibold uppercase tracking-wider text-zinc-400 mb-1.5">Devise *</label>
                            <select name="devise"
                                class="w-full bg-zinc-900/90 border border-zinc-700/80 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:border-orange-500 focus:outline-none transition">
                                <option value="MAD">MAD — Dirham Marocain</option>
                                <option value="EUR">EUR — Euro</option>
                                <option value="USD">USD — Dollar US</option>
                            </select>
                        </div>

                        <button type="submit"
                            class="w-full mt-2 bg-gradient-to-r from-orange-600 to-amber-500 hover:from-orange-500 hover:to-amber-400 text-white font-bold py-3 rounded-xl shadow-lg shadow-orange-600/25 flex items-center justify-center gap-2 transition duration-200">
                            <i data-lucide="plus" class="w-4 h-4"></i>
                            <span>Enregistrer le compte</span>
                        </button>
                    </form>
                </div>
            </div>

            <div class="lg:col-span-8">
                <div class="glass-card rounded-3xl p-6">
                    <div class="flex items-center justify-between mb-5">
                        <h2 class="text-lg font-bold text-white">Comptes Actifs</h2>
                        <span class="text-xs font-semibold bg-zinc-800 text-zinc-300 px-3 py-1 rounded-full border border-zinc-700">
                            <%= comptes.size() %> compte(s)
                        </span>
                    </div>

                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="border-b border-zinc-800 text-xs uppercase text-zinc-400">
                                    <th class="py-3 px-4">ID</th>
                                    <th class="py-3 px-4">Nom du compte</th>
                                    <th class="py-3 px-4">Solde Initial</th>
                                    <th class="py-3 px-4">Solde Courant</th>
                                    <th class="py-3 px-4">Devise</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-zinc-800/70 text-sm">
                                <% if (!comptes.isEmpty()) {
                                    for (Compte compte : comptes) { %>
                                    <tr class="hover:bg-zinc-900/60 transition">
                                        <td class="py-3.5 px-4 font-mono text-orange-400 font-bold">#<%= compte.getId() %></td>
                                        <td class="py-3.5 px-4 font-semibold text-white"><%= compte.getNom() %></td>
                                        <td class="py-3.5 px-4 text-zinc-400"><%= String.format("%.2f", compte.getSoldeInitial()) %></td>
                                        <td class="py-3.5 px-4 font-bold text-emerald-400"><%= String.format("%.2f", compte.getSolde()) %></td>
                                        <td class="py-3.5 px-4">
                                            <span class="px-2.5 py-1 rounded-lg text-xs font-bold bg-zinc-800 text-zinc-300 border border-zinc-700">
                                                <%= compte.getDevise() %>
                                            </span>
                                        </td>
                                    </tr>
                                <% } } else { %>
                                    <tr>
                                        <td colspan="5" class="py-10 text-center text-zinc-500">
                                            Aucun compte trouvé. Créez votre premier compte via le formulaire à gauche.
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="border-t border-zinc-900 py-5 mt-8 text-center text-xs text-zinc-500">
        Projet J2EE — Gestion du Budget Personnel • ENSA Agadir (2026 - 2027)
    </footer>

    <script>lucide.createIcons();</script>
</body>
</html>