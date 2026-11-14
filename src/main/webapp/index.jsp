<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.models.Utilisateur" %>
<%
    Utilisateur utilisateurConnecte = (Utilisateur) session.getAttribute("utilisateur");
    if (utilisateurConnecte != null) {
        response.sendRedirect(request.getContextPath() + "/views/home.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FinTrack.JEE | Gestion Intelligente du Budget Personnel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #09090b;
            color: #fafafa;
            overflow-x: hidden;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(24px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes floatSlow {
            0%, 100% { transform: translateY(0px) scale(1); }
            50% { transform: translateY(-16px) scale(1.04); }
        }
        .animate-fade-up { animation: fadeInUp 0.75s cubic-bezier(0.16, 1, 0.3, 1) forwards; }
        .delay-100 { animation-delay: 0.1s; opacity: 0; }
        .delay-200 { animation-delay: 0.2s; opacity: 0; }
        .delay-300 { animation-delay: 0.3s; opacity: 0; }
        .animate-float { animation: floatSlow 7s ease-in-out infinite; }
        .glass-panel {
            background: rgba(24, 24, 27, 0.78);
            backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.08);
        }
        .choice-card {
            transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .choice-card:hover {
            transform: translateY(-5px);
            border-color: rgba(249, 115, 22, 0.5);
            box-shadow: 0 20px 40px -12px rgba(249, 115, 22, 0.22);
        }
    </style>
</head>
<body class="min-h-screen flex flex-col justify-between bg-[#09090b] text-zinc-100 selection:bg-orange-500 selection:text-white relative">

    <div class="fixed inset-0 pointer-events-none overflow-hidden z-0">
        <div class="absolute -top-32 -left-32 w-[28rem] h-[28rem] bg-orange-600/20 rounded-full blur-[120px]"></div>
        <div class="absolute top-1/2 -right-32 w-[26rem] h-[26rem] bg-amber-500/15 rounded-full blur-[120px] animate-float"></div>
    </div>

    <header class="relative z-10 border-b border-zinc-800/70 glass-panel">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 rounded-xl bg-gradient-to-tr from-orange-600 to-amber-500 flex items-center justify-center shadow-lg shadow-orange-500/25">
                    <i data-lucide="wallet" class="w-5 h-5 text-white"></i>
                </div>
                <div>
                    <span class="font-extrabold text-xl tracking-tight text-white">FinTrack<span class="text-orange-500">.JEE</span></span>
                    <span class="hidden sm:inline-block text-[11px] bg-zinc-800/90 text-zinc-400 px-2.5 py-0.5 rounded-full ml-2 border border-zinc-700/60">ENSA Agadir</span>
                </div>
            </div>

            <div class="flex items-center gap-3">
                <a href="<%= request.getContextPath() %>/register"
                class="px-4 py-2 rounded-xl text-sm font-bold bg-gradient-to-r from-orange-600 to-amber-500 hover:from-orange-500
                hover:to-amber-400 text-white shadow-lg shadow-orange-600/25 transition">
                1. Créer un compte
                </a>
                <a href="<%= request.getContextPath() %>/login"
                    class="px-4 py-2 rounded-xl text-sm font-semibold text-zinc-300 hover:text-white bg-zinc-900 border border-zinc-700 hover:border-orange-500/40 transition">
                    2. Se connecter
                </a>
            </div>
        </div>
    </header>

    <main class="relative z-10 max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-12 sm:py-16">
        <div class="text-center max-w-3xl mx-auto">
            <div
                class="animate-fade-up inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-orange-500/10 border border-orange-500/25 text-orange-400 text-xs font-semibold uppercase tracking-wider mb-5">
                <i data-lucide="sparkles" class="w-3.5 h-3.5"></i>
                <span>Sujet du Projet • Application Web de Gestion du Budget Personnel</span>
            </div>

            <h1 class="animate-fade-up delay-100 text-3xl sm:text-5xl font-extrabold tracking-tight text-white leading-[1.15]">
                Maîtrisez vos <span
                    class="text-transparent bg-clip-text bg-gradient-to-r from-orange-400 via-amber-400 to-orange-500">finances
                    personnelles</span> en toute simplicité
            </h1>

            <p class="animate-fade-up delay-200 mt-5 text-sm sm:text-base text-zinc-400 leading-relaxed max-w-2xl mx-auto">
                Centralisez vos comptes bancaires en dirhams (MAD), enregistrez vos revenus et dépenses par catégorie, fixez des
                plafonds mensuels et recevez des alertes automatiques à 80% et 100% de consommation.
            </p>
        </div>

        <div class="animate-fade-up delay-200 mt-10 grid grid-cols-1 md:grid-cols-2 gap-6 max-w-3xl mx-auto">
            <a href="<%= request.getContextPath() %>/register"
            class="choice-card glass-panel rounded-3xl p-7 border-orange-500/30 bg-gradient-to-br from-zinc-900/90 to-orange-950/20
            flex flex-col justify-between group">
            <div>
                <div class="flex items-center justify-between mb-4">
                    <span class="px-3 py-1 rounded-full text-xs font-extrabold bg-orange-500 text-white">CHOIX 01</span>
                    <div
                        class="w-11 h-11 rounded-2xl bg-orange-500/15 border border-orange-500/30 flex items-center justify-center text-orange-400 group-hover:scale-110 transition">
                        <i data-lucide="user-plus" class="w-5 h-5"></i>
                        </div>
                        </div>
                        <h2 class="text-xl font-bold text-white group-hover:text-orange-400 transition">Créer un nouveau compte</h2>
                        <p class="text-xs sm:text-sm text-zinc-400 mt-2 leading-relaxed">
                            Nouvel utilisateur ? Inscrivez-vous gratuitement pour configurer vos premiers comptes, catégories et budgets
                            mensuels.
                        </p>
                        </div>
                        <div class="mt-6 inline-flex items-center gap-2 text-sm font-bold text-orange-400">
                            <span>Commencer l'inscription</span>
                            <i data-lucide="arrow-right" class="w-4 h-4 group-hover:translate-x-1 transition"></i>
                        </div>
                        </a>

            <a href="<%= request.getContextPath() %>/login"
            class="choice-card glass-panel rounded-3xl p-7 flex flex-col justify-between group">
            <div>
                <div class="flex items-center justify-between mb-4">
                    <span
                        class="px-3 py-1 rounded-full text-xs font-extrabold bg-zinc-800 text-zinc-300 border border-zinc-700">CHOIX
                        02</span>
                    <div
                        class="w-11 h-11 rounded-2xl bg-amber-500/15 border border-amber-500/30 flex items-center justify-center text-amber-400 group-hover:scale-110 transition">
                        <i data-lucide="log-in" class="w-5 h-5"></i>
                    </div>
                    </div>
                    <h2 class="text-xl font-bold text-white group-hover:text-amber-400 transition">Se connecter à mon espace</h2>
                    <p class="text-xs sm:text-sm text-zinc-400 mt-2 leading-relaxed">
                        Vous avez déjà un compte ? Accédez directement à votre tableau de bord pour suivre vos dépenses et vos alertes.
                    </p>
                    </div>
                    <div class="mt-6 inline-flex items-center gap-2 text-sm font-bold text-amber-400">
                        <span>Accéder au tableau de bord</span>
                        <i data-lucide="arrow-right" class="w-4 h-4 group-hover:translate-x-1 transition"></i>
                    </div>
                    </a>
        </div>

        <div class="animate-fade-up delay-300 mt-14 grid grid-cols-1 md:grid-cols-3 gap-5">
            <div class="glass-panel rounded-2xl p-5">
                <div class="flex items-center gap-3 mb-2">
                    <i data-lucide="landmark" class="w-5 h-5 text-orange-400"></i>
                    <h3 class="font-bold text-sm text-white">Multi-Comptes & Soldes</h3>
                </div>
                <p class="text-xs text-zinc-400 leading-relaxed">
                    Mise à jour automatique du solde courant à chaque revenu ou dépense enregistrée.
                </p>
            </div>

            <div class="glass-panel rounded-2xl p-5">
                <div class="flex items-center gap-3 mb-2">
                    <i data-lucide="bell-ring" class="w-5 h-5 text-amber-400"></i>
                    <h3 class="font-bold text-sm text-white">Alertes Budgétaires (RG7)</h3>
                </div>
                <p class="text-xs text-zinc-400 leading-relaxed">
                    Détection automatique des seuils d'alerte (80%) et dépassements de plafond (100%).
                </p>
            </div>

            <div class="glass-panel rounded-2xl p-5">
                <div class="flex items-center gap-3 mb-2">
                    <i data-lucide="file-spreadsheet" class="w-5 h-5 text-emerald-400"></i>
                    <h3 class="font-bold text-sm text-white">Rapports & Export CSV</h3>
                </div>
                <p class="text-xs text-zinc-400 leading-relaxed">
                    Architecture MVC Jakarta EE, Hibernate 6 & MySQL avec exportation mensuelle CSV.
                </p>
            </div>
        </div>
    </main>

    <footer class="relative z-10 border-t border-zinc-900 py-5 text-center text-xs text-zinc-500">
        Projet J2EE — Gestion du Budget Personnel • ENSA Agadir (2026 - 2027)
    </footer>

    <script>lucide.createIcons();</script>
</body>
</html>