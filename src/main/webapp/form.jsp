<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajouter une Spécialité</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f9f9f9; }
        form { background: #fff; padding: 20px; border-radius: 5px; max-width: 500px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        textarea { height: 100px; }
        .btn-submit { background-color: #28a745; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; }
        .btn-back { display: inline-block; margin-top: 15px; text-decoration: none; color: #007bff; }
    </style>
</head>
<body>
    <h2>Ajouter une nouvelle spécialité</h2>
    <form action="ajouter" method="POST">
        <div class="form-group">
            <label for="nom">Nom :</label>
            <input type="text" id="nom" name="nom" required placeholder="Ex: DLA">
        </div>
        <div class="form-group">
            <label for="description">Description :</label>
            <textarea id="description" name="description" required placeholder="Description..."></textarea>
        </div>
        <button type="submit" class="btn-submit">+ Ajouter</button>
    </form>
    <a href="specialites" class="btn-back">Retour à la liste</a>
</body>
</html>