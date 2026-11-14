<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.models.Utilisateur" %>
<%@ page import="java.time.LocalDate" %>
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
    if (utilisateur == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String nomAffiche = (utilisateur.getNom() != null && !utilisateur.getNom().isEmpty())
                 ? utilisateur.getNom()
                 : utilisateur.getEmail();
    String dateAujourdhui = LocalDate.now().toString();
%>
<!DOCTYPE html>
<html lang="fr" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord | FinTrack.JEE</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #09090b;
            color: #fafafa;
        }
        .glass-card {
            background: rgba(24, 24, 27, 0.85);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.08);
        }
        .orange-glow:hover {
            box-shadow: 0 0 25px rgba(249, 115, 22, 0.18);
            border-color: rgba(249, 115, 22, 0.4);
        }
    </style>
</head>
<body class="min-h-screen flex flex-col bg-[#09090b] text-zinc-100 selection:bg-orange-500 selection:text-white">

    <header class="sticky top-0 z-50 glass-card border-b border-zinc-800/80">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-xl bg-gradient-to-tr from-orange-600 to-amber-500 flex items-center justify-center shadow-lg shadow-orange-500/20">
                    <i data-lucide="wallet" class="w-5 h-5 text-white"></i>
                </div>
                <div>
                    <span class="font-bold text-lg tracking-tight text-white">FinTrack<span class="text-orange-500">.JEE</span></span>
                    <span class="hidden sm:inline-block text-[11px] bg-zinc-800 text-zinc-400 px-2 py-0.5 rounded-full ml-2">ENSA Agadir</span>
                </div>
            </div>

            <nav class="hidden md:flex items-center gap-1 bg-zinc-900/90 p-1 rounded-xl border border-zinc-800">
                <a href="<%= request.getContextPath() %>/views/home.jsp" class="flex items-center gap-2 px-4 py-2 rounded-lg bg-orange-500 text-white text-sm font-semibold shadow-sm">
                    <i data-lucide="layout-dashboard" class="w-4 h-4"></i> Tableau de bord
                </a>
                <a href="<%= request.getContextPath() %>/comptes" class="flex items-center gap-2 px-4 py-2 rounded-lg text-zinc-400 hover:text-white hover:bg-zinc-800/60 text-sm font-medium transition">
                    <i data-lucide="landmark" class="w-4 h-4"></i> Comptes
                </a>
                <a href="<%= request.getContextPath() %>/categories" class="flex items-center gap-2 px-4 py-2 rounded-lg text-zinc-400 hover:text-white hover:bg-zinc-800/60 text-sm font-medium transition">
                    <i data-lucide="tag" class="w-4 h-4"></i> Catégories
                </a>
                <a href="<%= request.getContextPath() %>/budgets" class="flex items-center gap-2 px-4 py-2 rounded-lg text-zinc-400 hover:text-white hover:bg-zinc-800/60 text-sm font-medium transition">
                    <i data-lucide="pie-chart" class="w-4 h-4"></i> Budgets & Alertes
                </a>
                <a href="<%= request.getContextPath() %>/revenus" class="flex items-center gap-2 px-4 py-2 rounded-lg text-zinc-400 hover:text-white hover:bg-zinc-800/60 text-sm font-medium transition">
                    <i data-lucide="arrow-left-right" class="w-4 h-4"></i> Transactions
                </a>
            </nav>

            <div class="flex items-center gap-3">
                <div class="hidden sm:flex items-center gap-2 bg-zinc-900 px-3 py-1.5 rounded-full border border-zinc-800">
                    <div class="w-2 h-2 rounded-full bg-emerald-500 animate-pulse"></div>
                    <span class="text-xs font-medium text-zinc-300"><%= nomAffiche %></span>
                </div>
                <a href="<%= request.getContextPath() %>/logout" class="flex items-center gap-1.5 bg-red-500/10 hover:bg-red-500 text-red-400 hover:text-white border border-red-500/20 px-3.5 py-2 rounded-xl text-xs font-semibold transition duration-200">
                    <i data-lucide="log-out" class="w-4 h-4"></i>
                    <span>Quitter</span>
                </a>
            </div>
        </div>
    </header>

    <main class="flex-1 max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8">

        <div class="relative overflow-hidden rounded-3xl bg-gradient-to-r from-zinc-900 via-zinc-900 to-orange-950/30 border border-zinc-800 p-6 sm:p-8 mb-8">
            <div class="relative z-10 flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                <div>
                    <span class="inline-flex items-center gap-1.5 text-xs font-semibold uppercase tracking-wider text-orange-400 bg-orange-500/10 border border-orange-500/20 px-3 py-1 rounded-full mb-3">
                        <i data-lucide="sparkles" class="w-3.5 h-3.5"></i> Espace Financier Personnel
                    </span>
                    <h1 class="text-2xl sm:text-4xl font-extrabold text-white tracking-tight">
                        Bonjour, <span class="text-transparent bg-clip-text bg-gradient-to-r from-orange-400 to-amber-300"><%= nomAffiche %></span> 👋
                    </h1>
                    <p class="text-zinc-400 text-sm sm:text-base mt-1.5 max-w-2xl">
                        Suivez vos flux financiers en dirhams (MAD), maîtrisez vos plafonds mensuels par catégorie et recevez des alertes intelligentes en temps réel.
                    </p>
                </div>
                <div class="flex flex-wrap gap-3">
                    <a href="<%= request.getContextPath() %>/comptes" class="inline-flex items-center gap-2 bg-zinc-800 hover:bg-zinc-700 text-white px-4 py-2.5 rounded-xl text-sm font-semibold border border-zinc-700 transition">
                        <i data-lucide="plus-circle" class="w-4 h-4 text-orange-400"></i> Gérer mes comptes
                    </a>
                    <a href="<%= request.getContextPath() %>/categories" class="inline-flex items-center gap-2 bg-zinc-800 hover:bg-zinc-700 text-white px-4 py-2.5 rounded-xl text-sm font-semibold border border-zinc-700 transition">
                        <i data-lucide="tag" class="w-4 h-4 text-amber-400"></i> Mes catégories
                    </a>
                </div>
            </div>

            <div class="absolute -right-16 -top-16 w-64 h-64 bg-orange-500/10 rounded-full blur-3xl pointer-events-none"></div>
        </div>

        <% if ("1".equals(request.getParameter("success"))) { %>
            <div class="mb-6 p-4 rounded-2xl bg-emerald-500/10 border border-emerald-500/30 flex items-center gap-3 text-emerald-300 shadow-lg">
                <div class="p-2 bg-emerald-500/20 rounded-xl">
                    <i data-lucide="check-circle-2" class="w-5 h-5 text-emerald-400"></i>
                </div>
                <div>
                    <h4 class="font-semibold text-sm">Transaction enregistrée avec succès !</h4>
                    <p class="text-xs text-emerald-400/80">Le solde du compte et le taux de consommation du budget ont été mis à jour.</p>
                </div>
            </div>
        <% } %>
        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="mb-6 p-4 rounded-2xl bg-red-500/10 border border-red-500/30 flex items-center gap-3 text-red-300 shadow-lg">
                <div class="p-2 bg-red-500/20 rounded-xl">
                    <i data-lucide="alert-triangle" class="w-5 h-5 text-red-400"></i>
                </div>
                <div>
                    <h4 class="font-semibold text-sm">Échec de l'enregistrement</h4>
                    <p class="text-xs text-red-400/80">Vérifiez que l'ID de la catégorie et le compte existent bien dans la base de données.</p>
                </div>
            </div>
        <% } %>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">

            <div class="lg:col-span-5">
                <div class="glass-card rounded-3xl p-6 sm:p-7 orange-glow transition duration-300">
                    <div class="flex items-center justify-between mb-6">
                        <div class="flex items-center gap-3">
                            <div class="w-10 h-10 rounded-xl bg-orange-500/15 border border-orange-500/30 flex items-center justify-center text-orange-400">
                                <i data-lucide="trending-down" class="w-5 h-5"></i>
                            </div>
                            <div>
                                <h2 class="text-lg font-bold text-white">Nouvelle Dépense</h2>
                                <p class="text-xs text-zinc-400">Saisie rapide & contrôle RG7</p>
                            </div>
                        </div>
                        <span class="text-xs font-mono text-orange-400 bg-orange-500/10 px-2.5 py-1 rounded-lg border border-orange-500/20">MAD</span>
                    </div>

                    <form action="<%= request.getContextPath() %>/expenses/ajouter" method="post" class="space-y-4">
                        <div>
                            <label class="block text-xs font-semibold uppercase tracking-wider text-zinc-400 mb-1.5">Montant de l'opération *</label>
                            <div class="relative">
                                <input type="number" step="0.01" min="0.01" name="montant" required placeholder="0.00"
                                    class="w-full bg-zinc-900/90 border border-zinc-700/80 text-white text-lg font-bold px-4 py-3 rounded-xl focus:ring-2 focus:ring-orange-500 focus:border-orange-500 focus:outline-none transition placeholder:text-zinc-600">
                                <span class="absolute right-4 top-3.5 text-sm font-semibold text-zinc-500">DH</span>
                            </div>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-xs font-semibold uppercase tracking-wider text-zinc-400 mb-1.5">ID Catégorie *</label>
                                <input type="number" min="1" name="categorieId" required placeholder="Ex: 1"
                                    class="w-full bg-zinc-900/90 border border-zinc-700/80 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:border-orange-500 focus:outline-none transition">
                            </div>

                            <div>
                                <label class="block text-xs font-semibold uppercase tracking-wider text-zinc-400 mb-1.5">Paiement</label>
                                <select name="modePaiement"
                                    class="w-full bg-zinc-900/90 border border-zinc-700/80 text-white px-3.5 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:border-orange-500 focus:outline-none transition">
                                    <option value="ESPECES">💵 Espèces</option>
                                    <option value="CARTE">💳 Carte Bancaire</option>
                                    <option value="VIREMENT">🏦 Virement</option>
                                    <option value="CHEQUE">📝 Chèque</option>
                                </select>
                            </div>
                        </div>

                        <div>
                            <label class="block text-xs font-semibold uppercase tracking-wider text-zinc-400 mb-1.5">Date de transaction *</label>
                            <input type="date" name="date" value="<%= dateAujourdhui %>" required
                                class="w-full bg-zinc-900/90 border border-zinc-700/80 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:border-orange-500 focus:outline-none transition">
                        </div>

                        <div>
                            <label class="block text-xs font-semibold uppercase tracking-wider text-zinc-400 mb-1.5">Description</label>
                            <input type="text" name="description" placeholder="Ex: Courses Marjane, Facture Wi-Fi..."
                                class="w-full bg-zinc-900/90 border border-zinc-700/80 text-white px-4 py-2.5 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:border-orange-500 focus:outline-none transition placeholder:text-zinc-600">
                        </div>

                        <button type="submit"
                            class="w-full mt-2 bg-gradient-to-r from-orange-600 to-amber-500 hover:from-orange-500 hover:to-amber-400 text-white font-bold py-3.5 px-6 rounded-xl shadow-lg shadow-orange-600/25 flex items-center justify-center gap-2 transition duration-200 cursor-pointer">
                            <i data-lucide="plus" class="w-5 h-5"></i>
                            <span>Enregistrer la dépense</span>
                        </button>
                    </form>
                </div>
            </div>

            <div class="lg:col-span-7 space-y-6">

                <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                    <a href="<%= request.getContextPath() %>/comptes" class="group glass-card rounded-2xl p-5 orange-glow transition duration-300 flex items-start justify-between">
                        <div>
                            <div class="w-10 h-10 rounded-xl bg-blue-500/10 border border-blue-500/20 flex items-center justify-center text-blue-400 mb-3 group-hover:scale-110 transition">
                                <i data-lucide="landmark" class="w-5 h-5"></i>
                            </div>
                            <h3 class="font-bold text-sm text-white group-hover:text-orange-400 transition">Comptes</h3>
                            <p class="text-xs text-zinc-400 mt-1">Soldes & devises</p>
                        </div>
                        <i data-lucide="arrow-up-right" class="w-4 h-4 text-zinc-600 group-hover:text-orange-400 transition"></i>
                    </a>

                    <a href="<%= request.getContextPath() %>/categories" class="group glass-card rounded-2xl p-5 orange-glow transition duration-300 flex items-start justify-between">
                        <div>
                            <div class="w-10 h-10 rounded-xl bg-emerald-500/10 border border-emerald-500/20 flex items-center justify-center text-emerald-400 mb-3 group-hover:scale-110 transition">
                                <i data-lucide="tag" class="w-5 h-5"></i>
                            </div>
                            <h3 class="font-bold text-sm text-white group-hover:text-orange-400 transition">Catégories</h3>
                            <p class="text-xs text-zinc-400 mt-1">Postes budgétaires</p>
                        </div>
                        <i data-lucide="arrow-up-right" class="w-4 h-4 text-zinc-600 group-hover:text-orange-400 transition"></i>
                    </a>

                    <a href="<%= request.getContextPath() %>/budgets" class="group glass-card rounded-2xl p-5 orange-glow transition duration-300 flex items-start justify-between">
                        <div>
                            <div class="w-10 h-10 rounded-xl bg-amber-500/10 border border-amber-500/20 flex items-center justify-center text-amber-400 mb-3 group-hover:scale-110 transition">
                                <i data-lucide="bell-ring" class="w-5 h-5"></i>
                            </div>
                            <h3 class="font-bold text-sm text-white group-hover:text-orange-400 transition">Budgets</h3>
                            <p class="text-xs text-zinc-400 mt-1">Plafonds & alertes</p>
                        </div>
                        <i data-lucide="arrow-up-right" class="w-4 h-4 text-zinc-600 group-hover:text-orange-400 transition"></i>
                    </a>
                </div>

                <div class="glass-card rounded-3xl p-6 sm:p-7">
                    <div class="flex items-center justify-between mb-5">
                        <div class="flex items-center gap-2.5">
                            <i data-lucide="layers" class="w-5 h-5 text-orange-400"></i>
                            <h3 class="text-lg font-bold text-white">Modules & Fonctionnalités du Système</h3>
                        </div>
                        <span class="text-xs text-zinc-500 font-medium">Architecture MVC</span>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <div class="p-4 rounded-2xl bg-zinc-900/80 border border-zinc-800/90 hover:border-zinc-700 transition">
                            <div class="flex items-center gap-2.5 mb-2">
                                <span class="w-7 h-7 rounded-lg bg-orange-500/15 text-orange-400 flex items-center justify-center text-xs font-bold">01</span>
                                <h4 class="font-semibold text-sm text-zinc-100">Gestion des Comptes</h4>
                            </div>
                            <p class="text-xs text-zinc-400 leading-relaxed">
                                Création de comptes (Courant, Épargne) avec calcul et mise à jour automatique du solde à chaque opération.
                            </p>
                        </div>

                        <div class="p-4 rounded-2xl bg-zinc-900/80 border border-zinc-800/90 hover:border-zinc-700 transition">
                            <div class="flex items-center gap-2.5 mb-2">
                                <span class="w-7 h-7 rounded-lg bg-orange-500/15 text-orange-400 flex items-center justify-center text-xs font-bold">02</span>
                                <h4 class="font-semibold text-sm text-zinc-100">Revenus & Dépenses</h4>
                            </div>
                            <p class="text-xs text-zinc-400 leading-relaxed">
                                Suivi complet des transactions classées par catégories et modes de paiement (Espèces, Carte, Virement).
                            </p>
                        </div>

                        <div class="p-4 rounded-2xl bg-zinc-900/80 border border-zinc-800/90 hover:border-zinc-700 transition">
                            <div class="flex items-center gap-2.5 mb-2">
                                <span class="w-7 h-7 rounded-lg bg-orange-500/15 text-orange-400 flex items-center justify-center text-xs font-bold">03</span>
                                <h4 class="font-semibold text-sm text-zinc-100">Budgets & Alertes (RG7)</h4>
                            </div>
                            <p class="text-xs text-zinc-400 leading-relaxed">
                                Plafonds mensuels par catégorie avec génération automatique d'alertes <strong>SEUIL</strong> et <strong>DEPASSEMENT</strong>.
                            </p>
                        </div>

                        <div class="p-4 rounded-2xl bg-zinc-900/80 border border-zinc-800/90 hover:border-zinc-700 transition">
                            <div class="flex items-center gap-2.5 mb-2">
                                <span class="w-7 h-7 rounded-lg bg-orange-500/15 text-orange-400 flex items-center justify-center text-xs font-bold">04</span>
                                <h4 class="font-semibold text-sm text-zinc-100">Persistance & Sécurité</h4>
                            </div>
                            <p class="text-xs text-zinc-400 leading-relaxed">
                                Propulsé par <strong>Jakarta EE 9</strong>, <strong>Hibernate 6</strong> et <strong>MySQL 8</strong> avec isolation stricte des données par utilisateur.
                            </p>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </main>

    <footer class="border-t border-zinc-900 py-5 mt-8 text-center text-xs text-zinc-500">
        Projet J2EE — Gestion du Budget Personnel • ENSA Agadir (2026 - 2027)
    </footer>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>