<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.dao.Specialite" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier une Spécialité</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f9f9f9; }
        form { background: #fff; padding: 20px; border-radius: 5px; max-width: 500px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        textarea { height: 100px; }
        .btn-submit { background-color: #ffc107; color: black; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
        .btn-back { display: inline-block; margin-top: 15px; text-decoration: none; color: #007bff; }
    </style>
</head>
<body>
    <h2>Modifier la spécialité</h2>
    <%
        Specialite s = (Specialite) request.getAttribute("specialite");
    %>
    <form action="modifier" method="POST">
        <input type="hidden" name="id" value="<%= s != null ? s.getId() : "" %>">
        <div class="form-group">
            <label for="nom">Nom :</label>
            <input type="text" id="nom" name="nom" value="<%= s != null ? s.getNom() : "" %>" required>
        </div>
        <div class="form-group">
            <label for="description">Description :</label>
            <textarea id="description" name="description" required><%= s != null ? s.getDescription() : "" %></textarea>
        </div>
        <button type="submit" class="btn-submit">Modifier</button>
    </form>
    <a href="specialites" class="btn-back">Retour à la liste</a>
</body>
</html>