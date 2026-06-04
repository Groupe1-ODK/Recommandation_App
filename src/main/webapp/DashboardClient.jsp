<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.Entites.Utilisateur"%>
<%@ page import="Model.Entites.Profil"%>
<%@ page import="Model.Entites.Competence"%>
<%@ page import="java.util.List"%>
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
int nbRecommandations = request.getAttribute("nbRecommandations") != null ? (int) request.getAttribute("nbRecommandations") : 0;
%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Mon_Activite - Tableau de bord</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

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

/* 👑 ZONE COMPÉTENCES DANS LA MODAL */
.skills-grid {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	padding-top: 5px;
}
.skill-item {
	position: relative;
}
.skill-item input[type="checkbox"] {
	position: absolute;
	opacity: 0;
	width: 0;
	height: 0;
}
.skill-label {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	padding: 10px 20px;
	background-color: #F3F4F6;
	border: 1px solid #D1D5DB;
	color: #374151;
	border-radius: 30px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.25s ease;
	user-select: none;
}
.skill-label:hover {
	background-color: #E5E7EB;
	border-color: #9CA3AF;
}
.skill-label i {
	font-size: 14px;
	opacity: 0;
	transform: scale(0);
	transition: all 0.2s ease;
}
.skill-item input[type="checkbox"]:checked+.skill-label {
	background-color: #E8F5E9;
	border-color: #26997B;
	color: #1F7A62;
	box-shadow: 0 4px 10px rgba(38, 153, 123, 0.15);
}
.skill-item input[type="checkbox"]:checked+.skill-label i {
	opacity: 1;
	transform: scale(1);
	color: #26997B;
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
					<li><a href="client" class="nav-item-link active"><i class="bi bi-house-door"></i> Tableau de bord</a></li>
					
					<li><a href="#" class="nav-item-link" data-bs-toggle="modal" data-bs-target="#renseignerProfilModal"><i class="bi bi-people"></i> Renseigner Profil</a></li>
					
					<li><a href="SimulationRevenue" class="nav-item-link"><i class="bi bi-cash-coin"></i> Simuler Revenus</a></li>
					
					<li><a href="<%=request.getContextPath()%>/Recommandation" class="nav-item-link"> <i class="bi bi-check-square"></i> Recommandation</a></li>
					<li><a href="#" class="nav-item-link"><i class="bi bi-heart"></i> Favoris</a></li>
					<li><a href="VoirProfilServlet" class="nav-item-link"><i class="bi bi-person"></i> Voir Profil</a></li>
				</ul>
			</div>

			<div class="d-flex align-items-center">
				<i class="bi bi-box-arrow-left text-white me-3 fs-3"></i> 
				<a href="deconnexion" class="btn btn-logout text-decoration-none text-center">Déconnexion</a>
			</div>
		</div>

		<div class="main-panel">

			<div class="d-flex justify-content-between align-items-center mb-5">
				<h1 class="fw-bold mb-0" style="color: #000; font-size: 30px;">Tableau de bord client</h1>

				<div class="user-profile-badge" 
     onclick="window.location.href='VoirProfilServlet';" 
     style="cursor: pointer; transition: all 0.2s ease-in-out; border-radius: 20px;"
     onmouseover="this.style.backgroundColor='#e2e8f0';"
     onmouseout="this.style.backgroundColor='transparent';">
     
    <i class="bi bi-person-circle"></i> 
    <span class="fw-semibold text-dark" style="font-size: 15px;"><%=user.getPrenom()%></span>
</div>
			</div>

			<div class="welcome-banner">
				<h2>Bienvenue, <%=user.getPrenom()%> <%=user.getNom()%> !</h2>
				<p>Consultez vos activités, favoris et simulations en un seul endroit.</p>
			</div>

			<div class="stat-grid">
				<div class="stat-card">
					<div class="stat-title">Simulation effectuée</div>
					<div class="stat-number"><%=nbSimulations%></div>
				</div>

				<div class="recom-row">
				<div class="stat-card-large">
					<div class="stat-title">Nombre de recommandation</div>
					<div class="stat-number" style="color: #000;"><%=nbRecommandations%></div>
				</div>
			</div>

				<div class="stat-card">
					<div class="stat-title">Nombre Favoris</div>
					<div class="stat-number"><%=nbFavoris%></div>
				</div>
			</div>

			

		</div>
	</div>

	<div class="modal fade" id="renseignerProfilModal" tabindex="-1" aria-labelledby="renseignerProfilModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content" style="border-radius: 20px; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15); border: none;">
				
				<div class="modal-header border-0 pt-4 px-4">
					<h5 class="modal-title fw-bold fs-4 text-dark" id="renseignerProfilModalLabel">Complétez Votre Profil</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>

				<div class="modal-body px-4 pb-4">
					<form action="profil" method="POST">

						<div class="mb-4">
							<label class="form-label fw-bold text-dark mb-2" style="font-size: 15px;">Disponibilité</label>
							<input type="number" step="0.1" name="disponibilite" class="form-control py-2 px-3" style="border: 1px solid #6B7280; border-radius: 8px;" placeholder="Entrez le temps disponible par jour (en heures)" required>
						</div>

						<div class="mb-4">
							<label class="form-label fw-bold text-dark mb-2" style="font-size: 15px;">Compétences</label>
							<div class="skills-grid">
								<%
								List<Competence> catalogue = (List<Competence>) request.getAttribute("catalogueCompetences");
								if (catalogue != null && !catalogue.isEmpty()) {
									for (Competence comp : catalogue) {
								%>
								<div class="skill-item">
									<input type="checkbox" name="competences" value="<%=comp.getNom()%>" id="modal-comp-<%=comp.getId()%>">
									<label for="modal-comp-<%=comp.getId()%>" class="skill-label">
										<i class="bi bi-check-circle-fill"></i> <%=comp.getNom()%>
									</label>
								</div>
								<%
									}
								} else {
								%>
								<span style="font-size: 13px; color: #9CA3AF; font-style: italic; padding: 8px 0;">
									<i class="bi bi-exclamation-circle"></i> Aucune compétence disponible.
								</span>
								<%
								}
								%>
							</div>
						</div>

						<div class="mb-4">
							<label class="form-label fw-bold text-dark mb-2" style="font-size: 15px;">Zone</label>
							<select id="zone" name="zone" class="form-select py-2 px-3" style="border: 1px solid #6B7280; border-radius: 8px;" required>
								<option value="" disabled selected>Sélectionnez votre Zone</option>
								<%
								for (Model.Enumeration.TypeZone z : Model.Enumeration.TypeZone.values()) {
								%>
								<option value="<%=z.name()%>"><%=z.name()%></option>
								<%
								}
								%>
							</select>
						</div>

						<div class="mb-4">
							<label class="form-label fw-bold text-dark mb-2" style="font-size: 15px;">Accès Internet</label>
							<select name="accesInternet" class="form-select py-2 px-3" style="border: 1px solid #6B7280; border-radius: 8px;" required>
								<option value="" disabled selected hidden>Sélectionnez l'accès internet</option>
								<option value="true">Oui / Possédé</option>
								<option value="false">Non / Indisponible</option>
							</select>
						</div>

						<div class="d-flex justify-content-end mt-4">
							<button type="submit" class="btn py-2 px-4 fw-bold text-white rounded-pill" style="background-color: #26997B; box-shadow: 0 4px 12px rgba(38, 153, 123, 0.2);">
								Enregistrer
							</button>
						</div>

					</form>
				</div>

			</div>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>