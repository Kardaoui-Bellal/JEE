<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Ajouter une Dépense</title></head>
<body>
    <h2>Ajouter une Nouvelle Dépense</h2>
    <form action="${pageContext.request.contextPath}/expenses/ajouter" method="post">
        <label>Montant:</label>
        <input type="number" step="0.01" name="montant" required /><br/>
        
        <label>Catégorie ID:</label>
        <input type="number" name="categorieId" required /><br/>
        
        <label>Description:</label>
        <input type="text" name="description" /><br/>
        
        <label>Date:</label>
        <input type="date" name="date" required /><br/>
        
        <button type="submit">Ajouter</button>
    </form>
</body>
</html>