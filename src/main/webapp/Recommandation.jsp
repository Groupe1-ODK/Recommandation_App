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
    <title>Mes recommendations</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        :root {
            --sidebar-bg: #1a233d;      /* Bleu très sombre de la maquette */
            --sidebar-hover: #2c3a5e;   /* Couleur de survol et élément actif */
            --main-bg: #cbd5e1;         /* Fond gris de la page */
        }

        body {
            background-color: var(--sidebar-bg); /* Contour extérieur sombre */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
            margin: 0;
            padding: 0;
        }

        /* Conteneur global */
        .app-container {
            min-height: 100vh;
            display: flex;
        }

        /* Barre latérale gauche (Sidebar) */
        .sidebar {
            width: 260px;
            background-color: var(--sidebar-bg);
            padding: 30px 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .brand-logo {
            background-color: white;
            width: 90px;
            height: 90px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 40px auto;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .brand-logo img {
            width: 70px;
            height: auto;
        }

        .nav-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .nav-item-link {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            margin-bottom: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .nav-item-link i {
            font-size: 20px;
            margin-right: 15px;
        }

        .nav-item-link:hover {
            background-color: var(--sidebar-hover);
            color: white;
        }

        .nav-item-link.active {
            background-color: #cbd5e1;
            color: #1a233d !important;
            font-weight: bold;
        }

        .btn-logout {
            background-color: #cbd5e1;
            color: #1a233d;
            border-radius: 12px;
            padding: 10px;
            font-weight: bold;
            border: none;
            width: 80%;
            transition: background-color 0.2s;
        }

        .btn-logout:hover {
            background-color: #94a3b8;
        }

        /* Contenu principal de droite (Panneau blanc) */
        .main-panel {
            flex: 1;
            background-color: white;
            margin: 15px 15px 15px 0;
            border-radius: 35px;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .user-profile-badge {
            display: flex;
            align-items: center;
            background-color: #f8fafc;
            padding: 8px 20px;
            border-radius: 30px;
            border: 1px solid #e2e8f0;
        }

        .user-profile-badge i {
            font-size: 32px;
            color: #1a233d;
            margin-right: 10px;
        }

        .btn-filter {
            border: 1px solid #e2e8f0;
            background: white;
            border-radius: 20px;
            padding: 6px 18px;
            font-weight: 500;
            color: #4a5568;
        }

        /* En-têtes de colonnes stricts (Nom, Description, Action) */
        .table-header-custom {
            font-weight: bold;
            color: #000;
            padding: 0 25px 15px 25px;
            font-size: 15px;
            border-bottom: 1px solid #f1f5f9;
        }

        /* Scrollbar discret pour naviguer à travers les 60 lignes */
        .scrollable-activity-list {
            max-height: 520px;
            overflow-y: auto;
            padding-right: 5px;
            margin-top: 15px;
        }

        .scrollable-activity-list::-webkit-scrollbar {
            width: 5px;
        }
        .scrollable-activity-list::-webkit-scrollbar-thumb {
            background-color: #e2e8f0;
            border-radius: 10px;
        }

        /* Cartes de lignes identiques à ta maquette */
        .activity-row {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            padding: 18px 25px;
            margin-bottom: 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.01);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .activity-row:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.04);
            border-color: #cbd5e1;
        }

        /* Bouton "Voir détails" exact */
        .btn-details {
            background-color: #cbd5e1; 
            color: #1a233d;
            border-radius: 20px;
            padding: 8px 24px;
            border: none;
            font-weight: bold;
            font-size: 14px;
            transition: all 0.2s;
        }

        .btn-details:hover {
            background-color: #1a233d;
            color: white;
        }
    </style>
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
                    <li><a href="ListeActivitesServelet" class="nav-item-link "><i class="bi bi-grid-1x2"></i> Liste Activité</a></li>
                    <li><a href="Recommandation" class="nav-item-link active"><i class="bi bi-check-square"></i> Recommandation</a></li>
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
                    <h1 class="fw-bold mb-0" style="color: #000; font-size: 36px;">Mes recommandations</h1>
                    
                    <div class="user-profile-badge">
                        <i class="bi bi-person-circle"></i>
                        <span class="fw-semibold text-dark"><%= user.getPrenom() %></span>
                    </div>
                </div>

                <div class="mb-4">
                    <button class="btn btn-filter shadow-sm">
                        Filtrer par <i class="bi bi-sliders ms-2"></i>
                    </button>
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
                                <div class="row activity-row align-items-center mx-0">
                                    <div class="col-md-4 fw-semibold text-dark" style="font-size: 16px;"><%= act.getNom() %></div>
                                    
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
                <span class="fw-bold text-dark">Total d'activités : <%= totalActivites %></span>
            </div>l

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>