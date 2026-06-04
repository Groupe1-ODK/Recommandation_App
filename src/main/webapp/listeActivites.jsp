<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Entites.Activite" %>
<%@ page import="Model.Entites.Utilisateur" %>
<%
    // 1. Récupération sécurisée de l'utilisateur connecté depuis la session
    Utilisateur user = (Utilisateur) session.getAttribute("utilisateurConnecte");
    if (user == null) {
        response.sendRedirect("connexion.jsp");
        return;
    }

    // 2. Récupération de la liste des activités envoyée par le Servlet
    List<Activite> listActivites = (List<Activite>) request.getAttribute("activites");
    int totalActivites = (listActivites != null) ? listActivites.size() : 0;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon_Activite - Liste des Activités</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="ListeDesActivites.css">
    
   
</head>
<body>

    <div class="app-container">
        
        <div class="sidebar">
            <div>
                <div class="brand-logo">
                    <img src="assets/logo.png" alt="Mon_Activite Logo">
                </div>

                <ul class="nav-menu">
                    <li><a href="client" class="nav-item-link"><i class="bi bi-house-door"></i> Tableau de bord</a></li>
                    <li><a href="CreerProfilServelet" class="nav-item-link"><i class="bi bi-people"></i> Renseigner Profil</a></li>
                    <li><a href="#" class="nav-item-link"><i class="bi bi-cash-coin"></i> Simuler Revenus</a></li>
                    <li><a href="ListeActivitesServelet" class="nav-item-link active"><i class="bi bi-grid-1x2"></i> Liste Activité</a></li>
                    <li><a href="#" class="nav-item-link"><i class="bi bi-check-square"></i> Recommandation</a></li>
                    <li><a href="#" class="nav-item-link"><i class="bi bi-heart"></i> Favoris</a></li>
                    <li><a href="VoirProfilServlet" class="nav-item-link"><i class="bi bi-person"></i> Voir Profil</a></li>
                </ul>
            </div>

            <div class="d-flex align-items-center">
                <i class="bi bi-box-arrow-left text-white me-3 fs-3"></i>
                <a href="DeconnexionServelet" class="btn btn-logout text-decoration-none text-center">Déconnexion</a>
            </div>
        </div>

        <div class="main-panel">
            
            <div>
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="fw-bold mb-0" style="color: #000; font-size: 36px;">Liste des Activités</h1>
                    
                    <div class="user-profile-badge">
                        <i class="bi bi-person-circle"></i>
                        <span class="fw-semibold text-dark"><%= user.getPrenom() %></span>
                    </div>
                </div>

                <div class="mb-4 dropdown">
                    <button class="btn btn-filter shadow-sm dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                        Filtrer : <span id="current-filter" class="fw-bold text-dark"></span> <i class="bi bi-sliders ms-2"></i>
                    </button>
                    <ul class="dropdown-menu shadow border-0 mt-2" aria-labelledby="dropdownMenuButton" style="border-radius: 12px;">
                        <li><a class="dropdown-item py-2" href="#" onclick="filtrerParNom('TOUT', 'Tous')"><i class="bi bi-globe me-2"></i> Toutes les activités</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item py-2" href="#" onclick="filtrerParNom('production', 'Production / Culture')"><i class="bi bi-flower1 me-2"></i> Production & Culture</a></li>
                        <li><a class="dropdown-item py-2" href="#" onclick="filtrerParNom('élevage', 'Élevage / Pisciculture')"><i class="bi bi-egg-fried me-2"></i> Élevage & Animaux</a></li>
                        <li><a class="dropdown-item py-2" href="#" onclick="filtrerParNom('vente', 'Vente / Commerce')"><i class="bi bi-shop me-2"></i> Vente & Commerce</a></li>
                        <li><a class="dropdown-item py-2" href="#" onclick="filtrerParNom('service', 'Services / Conseils')"><i class="bi bi-briefcase me-2"></i> Services & Conseils</a></li>
                        <li><a class="dropdown-item py-2" href="#" onclick="filtrerParNom('maintenance', 'Réparation / Technique')"><i class="bi bi-tools me-2"></i> Réparation & Technique</a></li>
                        <li><a class="dropdown-item py-2" href="#" onclick="filtrerParNom('fabrication', 'Atelier / Fabrication')"><i class="bi bi-hammer me-2"></i> Atelier & Fabrication</a></li>
                    </ul>
                </div>

                <div class="row table-header-custom align-items-center mx-0">
                    <div class="col-md-4">Nom</div>
                    <div class="col-md-5">Description</div>
                    <div class="col-md-3 text-end">Action</div>
                </div>

                <div class="scrollable-activity-list">
                    <% 
                        if (listActivites != null && !listActivites.isEmpty()) {
                            for (Activite act : listActivites) {
                    %>
                                <div class="row activity-row align-items-center mx-0 target-activity">
                                    <div class="col-md-4 fw-semibold text-dark activity-name" style="font-size: 16px;"><%= act.getNom() %></div>
                                    
                                    <div class="col-md-5 text-secondary text-truncate" title="<%= act.getDescription() %>" style="font-size: 15px;">
                                        <%= (act.getDescription() != null) ? act.getDescription() : "Aucune description" %>
                                    </div>
                                    
                                    <div class="col-md-3 text-end">
                                        <a href="DetailsActiviteServlet?id=<%= act.getId() %>" class="btn btn-details text-decoration-none">Voir détails</a>
                                    </div>
                                </div>
                    <% 
                            }
                        } else {
                    %>
                            <div class="text-center p-5 text-muted">
                                Aucun élément trouvé dans le catalogue.
                            </div>
                    <% 
                        }
                    %>
                </div>
            </div>

            <div class="text-center pt-3 border-top mt-3">
                <span class="fw-bold text-dark">Total affiché : <span id="counter-display"><%= totalActivites %></span></span>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function filtrerParNom(motCle, labelTxt) {
            // 1. Mettre à jour le texte du filtre sélectionné
            document.getElementById('current-filter').innerText = labelTxt;

            // 2. Scanner les lignes d'activités
            const rows = document.querySelectorAll('.target-activity');
            let compteurVisibles = 0;

            rows.forEach(row => {
                const nomActivite = row.querySelector('.activity-name').innerText.toLowerCase();
                let correspond = false;
                
                if (motCle === 'TOUT') {
                    correspond = true;
                } else if (motCle === 'élevage' && (nomActivite.includes('elevage') || nomActivite.includes('pisciculture') || nomActivite.includes('œufs'))) {
                    correspond = true;
                } else if (motCle === 'maintenance' && (nomActivite.includes('maintenance') || nomActivite.includes('réparation') || nomActivite.includes('garage') || nomActivite.includes('installation'))) {
                    correspond = true;
                } else if (motCle === 'service' && (nomActivite.includes('service') || nomActivite.includes('freelance') || nomActivite.includes('manager') || nomActivite.includes('agence') || nomActivite.includes('consultant') || nomActivite.includes('conseiller'))) {
                    correspond = true;
                } else if (nomActivite.includes(motCle)) {
                    correspond = true;
                }

                // 3. Afficher ou masquer
                if (correspond) {
                    row.style.setProperty('display', 'flex', 'important');
                    compteurVisibles++;
                } else {
                    row.style.setProperty('display', 'none', 'important');
                }
            });

            // 4. Actualiser le nombre total affiché
            document.getElementById('counter-display').innerText = compteurVisibles;
        }
    </script>
</body>
</html>