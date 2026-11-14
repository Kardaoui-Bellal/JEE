<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test View - Mon Projet Budget</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f7f6; padding: 20px; }
        .card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); max-width: 500px; margin: auto; }
        h2 { color: #2c3e50; }
        .success { color: green; font-weight: bold; }
        .alert { color: red; font-weight: bold; }
    </style>
</head>
<body>

<div class="card">
    <h2>🧪 Page de Test & Affichage</h2>
    <p>Message du Servlet : <strong><c:out value="${testMessage}" /></strong></p>
    
    <hr>
    
    <h3>Résultat du Budget :</h3>
    <p>Montant Plafond : <strong>${plafond} DH</strong></p>
    <p>Montant Dépensé : <strong>${depense} DH</strong></p>
    
    <c:choose>
        <c:when test="${depasse}">
            <p class="alert">⚠️ Attention : Le budget est dépassé !</p>
        </c:when>
        <c:otherwise>
            <p class="success"> Le budget est respecté.</p>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>