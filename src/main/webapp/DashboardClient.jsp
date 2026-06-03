<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Model.Entites.Utilisateur"%>
<%@ page import="Model.Entites.Profil"%>
<%
// Récupération sécurisée de l'utilisateur connecté
Utilisateur user = (Utilisateur) session.getAttribute("utilisateurConnecte");

// Si l'utilisateur n'est pas connecté, redirection de sécurité vers la connexion
if (user == null) {
	response.sendRedirect("connexion.jsp");
	return;
}

// Récupération des compteurs envoyés par le Servlet du Dashboard (avec des valeurs par défaut au cas où)
int nbSimulations = request.getAttribute("nbSimulations") != null ? (int) request.getAttribute("nbSimulations") : 2;
int nbActivites = request.getAttribute("nbActivites") != null ? (int) request.getAttribute("nbActivites") : 60;
int nbFavoris = request.getAttribute("nbFavoris") != null ? (int) request.getAttribute("nbFavoris") : 0;
int nbRecommandations = request.getAttribute("nbRecommandations") != null
		? (int) request.getAttribute("nbRecommandations")
		: 0;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Mon_Activite - Tableau de bord</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
	rel="stylesheet">

<style>
:root {
	--sidebar-bg: #1a233d; /* Bleu très sombre de la maquette */
	--sidebar-hover: #2c3a5e; /* Couleur de survol et élément actif */
	--banner-green: #26997B; /* Le vert émeraude de la bannière */
	--main-bg: #cbd5e1; /* Gris de fond pour simuler le contour */
}

body {
	background-color: var(--sidebar-bg);
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
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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

/* Style pour l'élément actif "Tableau de bord" */
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

/* Contenu principal de droite (Panneau blanc ultra-arrondi) */
.main-panel {
	flex: 1;
	background-color: #f8fafc;
	/* Fond très légèrement grisé comme sur la maquette */
	margin: 15px 15px 15px 0;
	border-radius: 35px;
	padding: 45px;
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
}

/* Badge Profil Utilisateur en haut à droite */
.user-profile-badge {
	display: flex;
	align-items: center;
	padding: 6px 18px;
	
	
}

.user-profile-badge i {
	font-size: 28px;
	color: #000;
	margin-right: 10px;
}

/* Bannière Verte de Bienvenue */
.welcome-banner {
	background-color: var(--banner-green);
	color: white;
	border-radius: 20px;
	padding: 30px 40px;
	margin-bottom: 40px;
	box-shadow: 0 4px 15px rgba(38, 153, 123, 0.2);
}

.welcome-banner h2 {
	font-size: 24px;
	font-weight: 500;
	margin-bottom: 15px;
}

.welcome-banner p {
	font-size: 18px;
	opacity: 0.95;
	margin-bottom: 0;
	line-height: 1.5;
}

/* Grille des Cartes Statistiques */
.stat-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 25px;
	margin-bottom: 30px;
}

.stat-card {
	background: white;
	border-radius: 20px;
	padding: 25px;
	text-align: center;
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.03);
	border: 1px solid #f1f5f9;
}

.stat-title {
	font-size: 16px;
	color: #334155;
	font-weight: 500;
	margin-bottom: 12px;
}

.stat-number {
	font-size: 28px;
	font-weight: 700;
	color: #000;
}

/* Carte de Recommandation centrée en dessous */
.recom-row {
	display: flex;
	justify-content: center;
	margin-top: 5px;
}

.stat-card-large {
	background: white;
	border-radius: 20px;
	padding: 25px 50px;
	text-align: center;
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.03);
	border: 1px solid #f1f5f9;
	min-width: 320px;
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
					<li><a href="client" class="nav-item-link active"><i
							class="bi bi-house-door"></i> Tableau de bord</a></li>
					<li><a href="profil" class="nav-item-link"><i
							class="bi bi-people"></i> Renseigner Profil</a></li>
					<li><a href="SimulationRevenue" class="nav-item-link"><i
							class="bi bi-cash-coin"></i> Simuler Revenus</a></li>
					<li><a href="ListeActivitesServelet" class="nav-item-link"><i
							class="bi bi-grid-1x2"></i> Voir Liste Activité</a></li>
					<li><a href="<%=request.getContextPath()%>/Recommandation"
						class="nav-item-link"> <i class="bi bi-check-square"></i>
							Recommandation
					</a></li>
					<li><a href="#" class="nav-item-link"><i
							class="bi bi-heart"></i> Favoris</a></li>
					<li><a href="VoirProfilServlet" class="nav-item-link"><i
							class="bi bi-person"></i> Voir Profil</a></li>
				</ul>
			</div>

			<div class="d-flex align-items-center">
				<i class="bi bi-box-arrow-left text-white me-3 fs-3"></i> <a
					href="DeconnexionServelet"
					class="btn btn-logout text-decoration-none text-center">Déconnexion</a>
			</div>
		</div>

		<div class="main-panel">

			<div class="d-flex justify-content-between align-items-center mb-5">
				<h1 class="fw-bold mb-0" style="color: #000; font-size: 30px;">Tableau
					de bord client</h1>

				<div class="user-profile-badge">
					<i class="bi bi-person-circle"></i> <span
						class="fw-semibold text-dark" style="font-size: 15px;"><%=user.getPrenom()%></span>
				</div>
			</div>

			<div class="welcome-banner">
				<h2>
					Bienvenue,
					<%=user.getPrenom()%>
					<%=user.getNom()%>
					!
				</h2>
				<p>Consultez vos activités, favoris et simulations en un seul
					endroit.</p>
			</div>

			<div class="stat-grid">
				<div class="stat-card">
					<div class="stat-title">Simulation effectuée</div>
					<div class="stat-number"><%=nbSimulations%></div>
				</div>

				<div class="stat-card">
					<div class="stat-title">Nombre Activité</div>
					<div class="stat-number"><%=nbActivites%></div>
				</div>

				<div class="stat-card">
					<div class="stat-title">Nombre Favoris</div>
					<div class="stat-number"><%=nbFavoris%></div>
				</div>
			</div>

			<div class="recom-row">
				<div class="stat-card-large">
					<div class="stat-title">Nombre de recommandation</div>
					<div class="stat-number" style="color: #000;"><%=nbRecommandations%></div>
				</div>
			</div>

		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>