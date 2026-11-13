<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.jstl.core" %>
<%@ taglib prefix="fmt" uri="jakarta.jstl.fmt" %>
<html>
<head>
    <title>Tableau de Bord - MonProjetBudget</title>
</head>
<body>
    <div style="margin: 20px;">
        <h1>Bienvenue, ${sessionScope.utilisateur.email} !</h1>
        <p>Ceci est votre tableau de bord de gestion du budget personnel.</p>

        <hr/>

        <h2>Ajouter une Dépense</h2>
        
        <c:if test="${param.success == '1'}">
            <p style="color: green;">Dépense ajoutée avec succès !</p>
        </c:if>
        <c:if test="${param.error == '1'}">
            <p style="color: red;">Erreur lors de l'ajout de la dépense.</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/expenses/ajouter" method="post">
            <label>Montant (DH):</label><br/>
            <input type="number" step="0.01" name="montant" required /><br/><br/>
            
            <label>ID de la Catégorie:</label><br/>
            <input type="number" name="categorieId" required /><br/><br/>
            
            <label>Mode de Paiement:</label><br/>
            <input type="text" name="modePaiement" placeholder="Espèce, Carte..." /><br/><br/>

            <label>Description:</label><br/>
            <input type="text" name="description" /><br/><br/>
            
            <label>Date:</label><br/>
            <input type="date" name="date" required /><br/><br/>
            
            <button type="submit">Enregistrer la dépense</button>
        </form>

        <br/>
        <a href="${pageContext.request.contextPath}/logout">Se déconnecter</a>
    </div>
</body>
</html>