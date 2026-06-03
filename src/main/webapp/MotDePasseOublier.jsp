<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Mot de passe oublié - Mon Activité</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>

:root{
    --navy:#161d4a;
    --green:#17c58b;
    --teal:#4c7788;
    --white:#ffffff;
    --light:#f5f5f5;
}

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:#d9d9d9;
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
}

.card{
    width:1100px;
    height:650px;
    display:flex;
    border-radius:35px;
    overflow:hidden;
    background:white;
}

.left{
    width:50%;
    background: #FFFFFF;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    position:relative;
    overflow:hidden;
}


.logo{
    position:absolute;
    top:10px;
    left:15px;
    width:130px;
    height:auto;
    transition:transform 0.3s ease;
}

.logo:hover{
    transform:scale(1.05);
}

.illustration{
    width:300px;
    max-width:80%;
    height:auto;
    object-fit:contain;
    background:transparent;
    filter:none;
    box-shadow:none;
    transition:transform 0.4s ease;
}

.illustration:hover{
    transform:scale(1.03);
}

.right{
    width:50%;
    background:var(--navy);
    display:flex;
    justify-content:center;
    align-items:center;
}

.form-container{
    width:80%;
}

h1{
    color:white;
    font-size:42px;
    margin-bottom:60px;
}

.form-group{
    margin-bottom:30px;
}

label{
    color:white;
    display:block;
    margin-bottom:10px;
    font-size:18px;
}

input{
    width:100%;
    padding:18px 25px;
    border:none;
    border-radius:50px;
    outline:none;
    font-size:16px;
}

.btn{
    width:100%;
    margin-top:50px;
    padding:18px;
    border:none;
    border-radius:50px;
    background:var(--teal);
    color:white;
    font-size:22px;
    cursor:pointer;
    transition:0.3s;
}

.btn:hover{
    background:#3a6472;
}

.message{
    background:#e8fff5;
    color:#17a36a;
    padding:12px;
    border-radius:10px;
    margin-bottom:20px;
}

.erreur{
    background:#ffe9e9;
    color:#d32f2f;
    padding:12px;
    border-radius:10px;
    margin-bottom:20px;
}

.retour{
    margin-top:20px;
    text-align:center;
}

.retour a{
    color:white;
    text-decoration:none;
}

.retour a:hover{
    text-decoration:underline;
}

</style>

</head>
<body>

<div class="card">

    <!-- Partie gauche -->
    <div class="left">

        <img src="<%=request.getContextPath()%>/assets/logo.png"
             alt="Logo"
             class="logo">

        <img src="<%=request.getContextPath()%>/assets/motdepasseoublier.png"
             alt="Mot de passe oublié"
             class="illustration">

    </div>

    <!-- Partie droite -->
    <div class="right">

        <div class="form-container">

            <h1>Mot de passe oublié</h1>

            <% if(request.getAttribute("message") != null){ %>
                <div class="message">
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>

            <% if(request.getAttribute("erreur") != null){ %>
                <div class="erreur">
                    <%= request.getAttribute("erreur") %>
                </div>
            <% } %>

            <form action="<%=request.getContextPath()%>/motDePasseOublie" method="post">

                <div class="form-group">
                    <label>Numéro de téléphone</label>

                    <input
                        type="text"
                        name="telephone"
                        placeholder="Entrez votre numéro de téléphone"
                        required>
                </div>

                <div class="form-group">
                    <label>Nouveau mot de passe</label>

                    <input
                        type="password"
                        name="nouveauMotDePasse"
                        placeholder="Entrez votre nouveau mot de passe"
                        required>
                </div>

                <button type="submit" class="btn">
                    Mettre à jour
                </button>

            </form>

            <div class="retour">
                <a href="<%=request.getContextPath()%>/connexion.jsp">
                    Retour à la connexion
                </a>
            </div>

        </div>

    </div>

</div>

</body>
</html>