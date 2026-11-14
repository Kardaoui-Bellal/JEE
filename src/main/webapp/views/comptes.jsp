<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.models.Compte" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des Comptes - Budget Personnel</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen">

    <nav class="bg-indigo-600 text-white shadow-md">
        <div class="max-w-7xl mx-auto px-4 py-3 flex justify-between items-center">
            <h1 class="text-xl font-bold">Mon Budget Personnel</h1>
            <div class="space-x-4">
                <a href="<%= request.getContextPath() %>/views/home.jsp" class="hover:underline">Tableau de bord</a>
                <a href="<%= request.getContextPath() %>/comptes" class="underline font-semibold">Comptes</a>
                <a href="<%= request.getContextPath() %>/logout" class="bg-red-500 px-3 py-1 rounded hover:bg-red-600">Déconnexion</a>
            </div>
        </div>
    </nav>

    <div class="max-w-6xl mx-auto px-4 py-8">
        <h2 class="text-2xl font-bold text-gray-800 mb-6">Mes Comptes Financiers</h2>

        <% if ("1".equals(request.getParameter("success"))) { %>
            <div class="mb-4 p-4 bg-green-100 border border-green-400 text-green-700 rounded-lg">
                Opération effectuée avec succès !
            </div>
        <% } %>
        <% if ("1".equals(request.getParameter("error"))) { %>
            <div class="mb-4 p-4 bg-red-100 border border-red-400 text-red-700 rounded-lg">
                Une erreur est survenue lors de l'opération.
            </div>
        <% } %>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <!-- Formulaire d'ajout de compte -->
            <div class="bg-white p-6 rounded-xl shadow-md md:col-span-1">
                <h3 class="text-lg font-semibold text-gray-700 mb-4">Ajouter un compte</h3>
                <form action="<%= request.getContextPath() %>/comptes" method="POST" class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-600 mb-1">Nom du compte</label>
                        <input type="text" name="nom" required placeholder="Ex: Compte Courant"
                            class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-indigo-500 focus:outline-none">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-600 mb-1">Solde initial (MAD)</label>
                        <input type="number" step="0.01" name="soldeInitial" required placeholder="0.00"
                            class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-indigo-500 focus:outline-none">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-600 mb-1">Devise</label>
                        <input type="text" name="devise" value="MAD" required
                            class="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-indigo-500 focus:outline-none">
                    </div>
                    <button type="submit"
                        class="w-full bg-indigo-600 text-white py-2 rounded-lg font-semibold hover:bg-indigo-700 transition">
                        Enregistrer le compte
                    </button>
                </form>
            </div>

            <!-- Liste des comptes existants -->
            <div class="bg-white p-6 rounded-xl shadow-md md:col-span-2">
                <h3 class="text-lg font-semibold text-gray-700 mb-4">Liste des comptes actifs</h3>
                <div class="overflow-x-auto">
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="bg-gray-100 text-gray-600 text-sm">
                                <th class="p-3 border-b">Nom</th>
                                <th class="p-3 border-b">Solde Initial</th>
                                <th class="p-3 border-b">Solde Courant</th>
                                <th class="p-3 border-b">Devise</th>
                            </tr>
                        </thead>
                        <tbody class="text-gray-700 text-sm">
                            <%
                                List<Compte> comptes = (List<Compte>) request.getAttribute("comptes");
                                if (comptes != null && !comptes.isEmpty()) {
                                    for (Compte compte : comptes) {
                            %>
                                <tr class="hover:bg-gray-50">
                                    <td class="p-3 border-b font-medium"><%= compte.getNom() %></td>
                                    <td class="p-3 border-b"><%= String.format("%.2f", compte.getSoldeInitial()) %></td>
                                    <td class="p-3 border-b font-semibold text-indigo-600"><%= String.format("%.2f", compte.getSolde()) %></td>
                                    <td class="p-3 border-b"><%= compte.getDevise() %></td>
                                </tr>
                            <%
                                    }
                                } else {
                            %>
                                <tr>
                                    <td colspan="4" class="p-4 text-center text-gray-500">Aucun compte trouvé.</td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>