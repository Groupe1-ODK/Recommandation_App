<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Liste des activités</title>

<link rel="stylesheet" href="ListeDesActivites.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

</head>
<body>

<div class="container">


    <div class="sidebar">

        <div class="logo">
            <img src="assets/logo.png" alt="logo">
        </div>

        <ul class="menu">

            <li class="active">
                <i class="fa-solid fa-house"></i>
                <span>Tableau de bord</span>
            </li>

            <li>
                <i class="fa-solid fa-file"></i>
                <span>Activités</span>
            </li>

            <li>
                <i class="fa-solid fa-users"></i>
                <span>Liste des clients</span>
            </li>

        </ul>

        <div class="logout">
            <i class="fa-solid fa-right-from-bracket"></i>
            <span>Déconnexion</span>
        </div>

    </div>


    <div class="main-content">


        <div class="header">

            <h1>Liste des activites</h1>

            <div class="user">

                <div class="user-icon">
                    <i class="fa-solid fa-user"></i>
                </div>

                <span>${nomUtilisateur}</span>

            </div>

        </div>
        
        <!-- Actions -->
        <div class="actions-bar">
            <button class="filter">Filtre par </button>
            <button class="add">Ajouter </button>
        </div>

 <!-- Table -->
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>Nom</th>
                    <th>Ctgie</th>
                    <th>Dscrpt</th>
                    <th>Dispo</th>
                    <th>AccesIn</th>
                    <th>Zne</th>
                    <th>Cptl</th>
                    <th>RMin</th>
                    <th>RMax</th>
                    <th>Cptce</th>
                    <th>Risque</th>
                    <th>Mtril</th>
                    <th>Actions</th>
                </tr>
                </thead>

                <tbody>
                <tr>
                    <td colspan="13" class="empty">Aucune activité disponible</td>
                </tr>
                </tbody>

            </table>
            
        </div>


      

    </div>

</div>
    
</body>
</html>