<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer un Compte | FinTrack.JEE</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #09090b; color: #fafafa; }
        .glass-card { background: rgba(24, 24, 27, 0.85); backdrop-filter: blur(16px); border: 1px solid rgba(255, 255, 255, 0.08); }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center bg-[#09090b] text-zinc-100 px-4 relative overflow-hidden">

    <div class="fixed inset-0 pointer-events-none">
        <div class="absolute -top-24 -right-24 w-96 h-96 bg-orange-600/20 rounded-full blur-[120px]"></div>
        <div class="absolute -bottom-24 -left-24 w-96 h-96 bg-amber-500/15 rounded-full blur-[120px]"></div>
    </div>

    <div class="relative z-10 w-full max-w-md">
        <div class="mb-6 flex items-center justify-between">
            <a href="<%= request.getContextPath() %>/index.jsp" class="inline-flex items-center gap-2 text-xs font-semibold text-zinc-400 hover:text-orange-400 transition">
                <i data-lucide="arrow-left" class="w-4 h-4"></i> Retour à l'accueil
            </a>
            <span class="font-extrabold text-base text-white">FinTrack<span class="text-orange-500">.JEE</span></span>
        </div>

        <div class="glass-card rounded-3xl p-8 shadow-2xl">
            <div class="w-12 h-12 rounded-2xl bg-gradient-to-tr from-orange-600 to-amber-500 flex items-center justify-center shadow-lg shadow-orange-500/25 mb-5">
                <i data-lucide="user-plus" class="w-6 h-6 text-white"></i>
            </div>

            <h1 class="text-2xl font-extrabold text-white">Créer un Compte</h1>
            <p class="text-sm text-zinc-400 mt-1 mb-6">Commencez à gérer vos budgets et vos alertes.</p>

            <% String err = (String) request.getAttribute("error");
               if (err != null) { %>
                <div class="mb-5 p-3.5 rounded-xl bg-red-500/10 border border-red-500/30 text-red-300 text-xs font-medium flex items-center gap-2">
                    <i data-lucide="alert-circle" class="w-4 h-4 text-red-400 shrink-0"></i>
                    <span><%= err %></span>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/register" method="post" class="space-y-4">
                <div>
                    <label for="nom" class="block text-xs font-semibold uppercase tracking-wider text-zinc-400 mb-1.5">Nom complet</label>
                    <input type="text" id="nom" name="nom" required placeholder="Ex: Anas Oubouksim"
                        class="w-full bg-zinc-900/90 border border-zinc-700/80 text-white px-4 py-3 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:border-orange-500 focus:outline-none transition">
                </div>

                <div>
                    <label for="email" class="block text-xs font-semibold uppercase tracking-wider text-zinc-400 mb-1.5">Adresse Email</label>
                    <input type="email" id="email" name="email" required placeholder="exemple@email.com"
                        class="w-full bg-zinc-900/90 border border-zinc-700/80 text-white px-4 py-3 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:border-orange-500 focus:outline-none transition">
                </div>

                <div>
                    <label for="password" class="block text-xs font-semibold uppercase tracking-wider text-zinc-400 mb-1.5">Mot de passe</label>
                    <input type="password" id="password" name="password" required placeholder="••••••••"
                        class="w-full bg-zinc-900/90 border border-zinc-700/80 text-white px-4 py-3 rounded-xl text-sm focus:ring-2 focus:ring-orange-500 focus:border-orange-500 focus:outline-none transition">
                </div>

                <button type="submit"
                    class="w-full mt-2 bg-gradient-to-r from-orange-600 to-amber-500 hover:from-orange-500 hover:to-amber-400 text-white font-bold py-3.5 rounded-xl shadow-lg shadow-orange-600/25 transition duration-200">
                    S'inscrire maintenant
                </button>
            </form>

            <div class="mt-6 pt-5 border-t border-zinc-800/80 text-center text-xs text-zinc-400">
                Déjà un compte ?
                <a href="<%= request.getContextPath() %>/login" class="text-orange-400 hover:text-orange-300 font-bold ml-1">
                    Se connecter
                </a>
            </div>
        </div>
    </div>

    <script>lucide.createIcons();</script>
</body>
</html>