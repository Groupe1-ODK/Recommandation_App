<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mon Activité - Simulation Revenus</title>
    
    <!-- Lien CDN Font Awesome (Permet d'utiliser les icônes) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
   <link rel="stylesheet" href="SimulationRevenue.css">
</head>
<body>

    <div class="app-container">
        
        <!-- BARRE LATÉRALE GAUCHE -->
        <div class="sidebar">
        <div class="logo-container">
    <div class="logo-circle-bg">
        <img src="assets/images/logo.png" alt="Mon_Activite Logo">
    </div>
</div>
            
            <!-- Utilisation des classes d'icônes Font Awesome 'fa-solid' -->
            <div class="menu-item"><i class="fa-solid fa-house"></i> Tableau de bord</div>
            <div class="menu-item"><i class="fa-solid fa-user-gear"></i> Renseigner Profil</div>
            <div class="menu-item active"><i class="fa-solid fa-sack-dollar"></i> Simuler Revenus</div>
            <div class="menu-item"><i class="fa-solid fa-list-check"></i> Voir Liste Activité</div>
            <div class="menu-item"><i class="fa-solid fa-clipboard-check"></i> Recommandation</div>
            <div class="menu-item"><i class="fa-solid fa-heart"></i> Favoris</div>
            <div class="menu-item"><i class="fa-solid fa-user-tie"></i> Voir Profil</div>
            
            <div class="logout-btn"><i class="fa-solid fa-arrow-right-from-bracket"></i> Déconnexion</div>
        </div>

        <!-- ZONE DE DROITE -->
        <div class="main-content">
            
            <!-- EN-TÊTE -->
            <div class="header">
                <h1>Simulation Revenus</h1>
                <div class="user-profile">
                    <div class="avatar"><i class="fa-solid fa-circle-user"></i></div>
                    <span>Yattus</span>
                </div>
            </div>

            <!-- FORMULAIRE (Liaison Servlet) -->
            <form action="SimulationServlet" method="POST" style="display: flex; flex-direction: column; flex: 1;">
                
                <div class="form-card">
                    <!-- Champ Disponibilité -->
                    <div class="form-group">
                        <label for="disponibilite">Disponibilité</label>
                        <input type="text" id="disponibilite" name="disponibilite">
                    </div>

                    <!-- Champ Compétence (Avec la classe select-wrapper pour le design de la flèche) -->
                    <div class="form-group select-wrapper">
                        <label for="competence">Compétence</label>
                        <select id="competence" name="competence">
                            <option value=""></option>
                            <option value="Cuisine">Cuisine</option>
                            <option value="Elevage">Elevage</option>
                            <option value="Informatique">Informatique</option>
                        </select>
                    </div>

                    <!-- Champ Capital -->
                    <div class="form-group">
                        <label for="capital">Capital</label>
                        <input type="text" id="capital" name="capital">
                    </div>

                    <!-- Champ Zone -->
                    <div class="form-group select-wrapper">
                        <label for="zone">Zone</label>
                        <select id="zone" name="zone">
                            <option value=""></option>
                            <option value="Ville">Ville</option>
                            <option value="Village">Village</option>
                        </select>
                    </div>

                    <!-- Champ Accès Internet -->
                    <div class="form-group select-wrapper">
                        <label for="internet">Accès Internet</label>
                        <select id="internet" name="internet">
                            <option value=""></option>
                            <option value="oui">Oui</option>
                            <option value="non">Non</option>
                        </select>
                    </div>
                </div>

                <!-- BOUTON DE SOUMISSION -->
                <div class="actions-container">
                    <button type="submit" class="btn-simuler">Simuler</button>
                </div>
                
            </form>
            
        </div>
    </div>

</body>
</html>