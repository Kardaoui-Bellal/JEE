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
            from {
                opacity: 0;
                transform: translateY(28px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        @keyframes floatSlow {
            0%, 100% {
                transform: translateY(0px) scale(1);
            }
            50% {
                transform: translateY(-18px) scale(1.04);
            }
        }
        @keyframes pulseGlow {
            0%, 100% {
                opacity: 0.35;
            }
            50% {
                opacity: 0.65;
            }
        }
        .animate-fade-up {
            animation: fadeInUp 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
        }
        .delay-100 { animation-delay: 0.1s; opacity: 0; }
        .delay-200 { animation-delay: 0.2s; opacity: 0; }
        .delay-300 { animation-delay: 0.3s; opacity: 0; }
        .delay-400 { animation-delay: 0.4s; opacity: 0; }
        .animate-float {
            animation: floatSlow 7s ease-in-out infinite;
        }
        .animate-glow {
            animation: pulseGlow 5s ease-in-out infinite;
        }
        .glass-panel {
            background: rgba(24, 24, 27, 0.78);
            backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.08);
        }
        .feature-card {
            transition: all 0.35s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .feature-card:hover {
            transform: translateY(-6px);
            border-color: rgba(249, 115, 22, 0.45);
            box-shadow: 0 18px 35px -10px rgba(249, 115, 22, 0.18);
        }
    </style>
</head>
<body class="min-h-screen flex flex-col justify-between bg-[#09090b] text-zinc-100 selection:bg-orange-500 selection:text-white relative">

    <div class="fixed inset-0 pointer-events-none overflow-hidden z-0">
        <div class="absolute -top-32 -left-32 w-[28rem] h-[28rem] bg-orange-600/20 rounded-full blur-[120px] animate-glow"></div>
        <div class="absolute top-1/2 -right-32 w-[26rem] h-[26rem] bg-amber-500/15 rounded-full blur-[120px] animate-float"></div>
    </div>

    <header class="relative z-10 border-b border-zinc-800/70 glass-panel">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-18 py-4 flex items-center justify-between">
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
                <a href="<%= request.getContextPath() %>/login"
                   class="px-4 py-2 rounded-xl text-sm font-semibold text-zinc-300 hover:text-white hover:bg-zinc-800/80 transition">
                    Se connecter
                </a>
                <a href="<%= request.getContextPath() %>/register"
                   class="px-5 py-2.5 rounded-xl text-sm font-bold bg-gradient-to-r from-orange-600 to-amber-500 hover:from-orange-500 hover:to-amber-400 text-white shadow-lg shadow-orange-600/25 transition duration-200">
                    Créer un compte
                </a>
            </div>
        </div>
    </header>

    <main class="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-14 sm:py-20">
        <div class="text-center max-w-3xl mx-auto">
            <div class="animate-fade-up inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-orange-500/10 border border-orange-500/25 text-orange-400 text-xs font-semibold uppercase tracking-wider mb-6">
                <i data-lucide="sparkles" class="w-3.5 h-3.5"></i>
                <span>Plateforme de Gestion Budgétaire • Jakarta EE</span>
            </div>

            <h1 class="animate-fade-up delay-100 text-4xl sm:text-6xl font-extrabold tracking-tight text-white leading-[1.12]">
                Prenez le contrôle total de vos <span class="text-transparent bg-clip-text bg-gradient-to-r from-orange-400 via-amber-400 to-orange-500">finances personnelles</span>
            </h1>

            <p class="animate-fade-up delay-200 mt-6 text-base sm:text-lg text-zinc-400 leading-relaxed max-w-2xl mx-auto">
                Centralisez vos comptes en dirhams (MAD), suivez vos revenus et dépenses au quotidien et recevez des alertes intelligentes avant tout dépassement de budget[cite: 8, 16].
            </p>

            <div class="animate-fade-up delay-300 mt-10 flex flex-col sm:flex-row items-center justify-center gap-4">
                <a href="<%= request.getContextPath() %>/register"
                   class="w-full sm:w-auto inline-flex items-center justify-center gap-2.5 px-8 py-4 rounded-2xl bg-gradient-to-r from-orange-600 to-amber-500 hover:from-orange-500 hover:to-amber-400 text-white font-bold text-base shadow-xl shadow-orange-600/30 hover:scale-[1.02] active:scale-[0.99] transition duration-200">
                    <i data-lucide="user-plus" class="w-5 h-5"></i>
                    <span>Commencer gratuitement</span>
                </a>

                <a href="<%= request.getContextPath() %>/login"
                   class="w-full sm:w-auto inline-flex items-center justify-center gap-2.5 px-8 py-4 rounded-2xl glass-panel hover:bg-zinc-800/90 text-white font-bold text-base border border-zinc-700/80 hover:border-orange-500/40 hover:scale-[1.02] active:scale-[0.99] transition duration-200">
                    <i data-lucide="log-in" class="w-5 h-5 text-orange-400"></i>
                    <span>Accéder à mon espace</span>
                </a>
            </div>
        </div>

        <div class="animate-fade-up delay-400 mt-20 grid grid-cols-1 md:grid-cols-3 gap-6">
            <div class="glass-panel feature-card rounded-3xl p-7">
                <div class="w-12 h-12 rounded-2xl bg-orange-500/15 border border-orange-500/30 flex items-center justify-center text-orange-400 mb-5">
                    <i data-lucide="landmark" class="w-6 h-6"></i>
                </div>
                <h3 class="text-lg font-bold text-white mb-2">Multi-Comptes & Soldes</h3>
                <p class="text-sm text-zinc-400 leading-relaxed">
                    Gérez vos comptes courants et d'épargne avec mise à jour automatique et instantanée du solde à chaque transaction[cite: 13, 16].
                </p>
            </div>

            <div class="glass-panel feature-card rounded-3xl p-7">
                <div class="w-12 h-12 rounded-2xl bg-amber-500/15 border border-amber-500/30 flex items-center justify-center text-amber-400 mb-5">
                    <i data-lucide="bell-ring" class="w-6 h-6"></i>
                </div>
                <h3 class="text-lg font-bold text-white mb-2">Alertes Intelligentes</h3>
                <p class="text-sm text-zinc-400 leading-relaxed">
                    Fixez un plafond mensuel par catégorie et soyez alerté automatiquement dès 80% de consommation ou en cas de dépassement[cite: 13, 16].
                </p>
            </div>

            <div class="glass-panel feature-card rounded-3xl p-7">
                <div class="w-12 h-12 rounded-2xl bg-emerald-500/15 border border-emerald-500/30 flex items-center justify-center text-emerald-400 mb-5">
                    <i data-lucide="shield-check" class="w-6 h-6"></i>
                </div>
                <h3 class="text-lg font-bold text-white mb-2">Sécurité & Persistance</h3>
                <p class="text-sm text-zinc-400 leading-relaxed">
                    Architecture MVC robuste propulsée par Java 21, Servlets, Hibernate 6 et MySQL avec isolation complète des données[cite: 15, 16, 23].
                </p>
            </div>
        </div>
    </main>

    <footer class="relative z-10 border-t border-zinc-900 py-6 text-center text-xs text-zinc-500">
        Projet J2EE — Gestion du Budget Personnel • ENSA Agadir (2026 - 2027)[cite: 3]
    </footer>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>