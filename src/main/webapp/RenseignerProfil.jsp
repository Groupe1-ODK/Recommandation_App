<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Entites.Competence" %>
<%@ page import="Model.Enumeration.TypeZone"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Complétez Votre Profil</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<style>
* {
	box-sizing: border-box;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	margin: 0;
	padding: 0;
}

body {
	background-color: #D1D5DB;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	padding: 20px;
}

/* Conteneur Principal calqué sur ton image */
.form-container {
	background: #FFF;
	width: 100%;
	max-width: 900px;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	padding: 40px;
	position: relative;
}

/* Flèche Retour */
.back-arrow {
	position: absolute;
	top: 35px;
	left: 40px;
	font-size: 28px;
	color: #000;
	text-decoration: none;
	font-weight: bold;
	transition: transform 0.2s;
}

.back-arrow:hover {
	transform: translateX(-5px);
}

/* Titre Centré */
.form-title {
	text-align: center;
	font-size: 24px;
	font-weight: 700;
	color: #000;
	margin-bottom: 40px;
}

/* Alignement des lignes du formulaire */
.form-group {
	display: flex;
	align-items: flex-start;
	margin-bottom: 25px;
}

.form-label {
	width: 180px;
	font-size: 15px;
	font-weight: 700;
	color: #000;
	padding-top: 12px;
}

.form-input-wrapper {
	flex: 1;
}

/* Inputs textuels, numériques et select standardisés */
.form-control {
	width: 100%;
	padding: 12px 16px;
	border: 1px solid #6B7280;
	border-radius: 8px;
	font-size: 14px;
	color: #333;
	outline: none;
	background-color: #FFF;
	transition: border-color 0.2s;
}

.form-control:focus {
	border-color: #26997B;
	box-shadow: 0 0 0 3px rgba(38, 153, 123, 0.1);
}

.form-control::placeholder {
	color: #9CA3AF;
	font-size: 13px;
}

/* 👑 ZONE COMPÉTENCES IMMACULÉE (Checkbox-Badges) */
.skills-grid {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	padding-top: 5px;
}

.skill-item {
	position: relative;
}

/* On cache la checkbox HTML moche */
.skill-item input[type="checkbox"] {
	position: absolute;
	opacity: 0;
	width: 0;
	height: 0;
}

/* Le badge au repos (Design épuré et aligné) */
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

/* ⚡ L'effet magique quand on coche (Couleur #26997B préservée) */
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

/* Bouton Enregistrer en bas à droite */
.btn-submit-container {
	display: flex;
	justify-content: flex-end;
	margin-top: 40px;
}

.btn-submit {
	background-color: #26997B;
	color: #FFF;
	border: none;
	padding: 12px 35px;
	font-size: 16px;
	font-weight: 700;
	border-radius: 20px;
	cursor: pointer;
	transition: background-color 0.2s, transform 0.1s;
	box-shadow: 0 4px 12px rgba(38, 153, 123, 0.2);
}

.btn-submit:hover {
	background-color: #1F7A62;
}

.btn-submit:active {
	transform: scale(0.98);
}

/* Style spécifique pour les Select fléchés */
select.form-control {
	appearance: none;
	background-image:
		url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%23333' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><polyline points='6 9 12 15 18 9'></polyline></svg>");
	background-repeat: no-repeat;
	background-position: right 16px center;
	background-size: 16px;
	padding-right: 40px;
}
</style>
</head>
<body>

	<div class="form-container">
		<a href="VoirProfilServlet" class="back-arrow"><i
			class="bi bi-arrow-left"></i></a>

		<div class="form-title">Complétez Votre Profil</div>

		<form action="profil" method="POST">

			<div class="form-group">
				<label class="form-label">Identifiant</label>
				<div class="form-input-wrapper">
					<input type="text" name="identifiant" class="form-control"
						placeholder="Entrez votre identifiant">
				</div>
			</div>

			<div class="form-group">
				<label class="form-label">Disponibilité</label>
				<div class="form-input-wrapper">
					<input type="number" step="0.1" name="disponibilite"
						class="form-control"
						placeholder="Entrez le temps disponible par jour (en heures)"
						required>
				</div>
			</div>

			<div class="form-group">
				<label class="form-label">Compétences</label>
				<div class="form-input-wrapper">
					<div class="skills-grid">



						<%
						// Récupération de la liste dynamique envoyée par le doGet du CreerProfilServelet
						List<Competence> catalogue = (List<Competence>) request.getAttribute("catalogueCompetences");

						if (catalogue != null && !catalogue.isEmpty()) {
							for (Competence comp : catalogue) {
						%>
						<div class="skill-item">
							<input type="checkbox" name="competences"
								value="<%=comp.getNom()%>" id="comp-<%=comp.getId()%>">
							<label for="comp-<%=comp.getId()%>" class="skill-label">
								<i class="bi bi-check-circle-fill"></i> <%=comp.getNom()%>
							</label>
						</div>
						<%
						}
						} else {
						%>
						<span
							style="font-size: 13px; color: #9CA3AF; font-style: italic; padding: 8px 0;">
							<i class="bi bi-exclamation-circle"></i> Aucune compétence
							disponible. Vérifiez la table en base de données.
						</span>
						<%
						}
						%>

					</div>
				</div>
			</div>

			<div class="form-group">
				<label class="form-label">Capital</label>
				<div class="form-input-wrapper">
					<input type="number" name="capital" class="form-control"
						placeholder="Entrez le capital disponible (FCFA)" required>
				</div>
			</div>

			<div class="form-group">
				<label class="form-label">Zone</label>
				<div class="form-input-wrapper">
					<select id="zone" name="zone" class="form-control" required>
						<option value="" disabled selected>Sélectionnez votre
							Zone</option>
						<%
						for (TypeZone z : TypeZone.values()) {
						%>
						<option value="<%=z.name()%>"><%=z.name()%></option>
						<%
						}
						%>
					</select>
				</div>
			</div>

			<div class="form-group">
				<label class="form-label">Accès Internet</label>
				<div class="form-input-wrapper">
					<select name="accesInternet" class="form-control" required>
						<option value="" disabled selected hidden>Sélectionnez
							l'accès internet</option>
						<option value="true">Oui / Possédé</option>
						<option value="false">Non / Indisponible</option>
					</select>
				</div>
			</div>

			<div class="btn-submit-container">
				<button type="submit" class="btn-submit">Enregistrer</button>
			</div>

		</form>
	</div>

</body>
</html>