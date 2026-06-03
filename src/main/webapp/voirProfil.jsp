<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Entites.Utilisateur" %>
<%@ page import="Model.Entites.Profil" %>
<%@ page import="Model.Entites.Competence" %>
<%@ page import="java.util.List" %>
<%
    // Récupération des deux objets passés par ton Servlet
    Utilisateur user = (Utilisateur) request.getAttribute("utilisateur");
    Profil profil = (Profil) request.getAttribute("profil");
    
    // Sécurité : si pas de user, retour à la connexion
    if (user == null) {
        response.sendRedirect("connexion.jsp");
        return;
    }

    // Extraction de la première lettre du prénom pour l'avatar visuel
    String premiereLettre = (user.getPrenom() != null && !user.getPrenom().isEmpty()) ? user.getPrenom().substring(0, 1).toUpperCase() : "U";
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mon Profil Entrepreneur</title>
    <style>
        * { box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; }
        body { background-color: #F4F6F9; color: #333; padding: 40px 20px; }
        .profile-container { max-width: 900px; margin: 0 auto; background: #FFF; border-radius: 16px; box-shadow: 0 4px 25px rgba(0,0,0,0.06); overflow: hidden; }
        
        /* En-tête mis à jour avec ta nouvelle couleur #1a233d */
        .profile-header { background: linear-gradient(135deg, #1a233d, #111729); color: white; padding: 40px; text-align: center; }
        .avatar-circle { width: 100px; height: 100px; background-color: #FFF; color: #1a233d; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 36px; font-weight: bold; margin: 0 auto 15px; box-shadow: 0 4px 10px rgba(0,0,0,0.15); }
        .profile-header h1 { font-size: 26px; font-weight: 700; margin-bottom: 5px; text-transform: capitalize; }
        .profile-header p { opacity: 0.9; font-size: 15px; }
        
        /* Corps de la page */
        .profile-body { padding: 40px; }
        .section-title { font-size: 18px; color: #1a233d; border-bottom: 2px solid #EAECEF; padding-bottom: 8px; margin-bottom: 20px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; }
        
        /* Grille des critères */
        .info-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 25px; margin-bottom: 35px; }
        .info-card { background: #F8F9FA; border-left: 4px solid #1a233d; padding: 15px 20px; border-radius: 4px; }
        .info-card label { display: block; font-size: 12px; text-transform: uppercase; color: #777; font-weight: 600; margin-bottom: 5px; }
        .info-card span { font-size: 16px; font-weight: 600; color: #2C3E50; }
        
        /* Badges pour les compétences adaptés au ton bleu nuit */
        .skills-container { display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 40px; }
        .skill-badge { background-color: #F0F2F5; color: #1a233d; padding: 8px 16px; border-radius: 30px; font-size: 14px; font-weight: 600; border: 1px solid #D1D5DB; }
        
        /* Boutons d'action */
        .actions-box { display: flex; gap: 15px; justify-content: flex-end; border-top: 1px solid #EAECEF; padding-top: 25px; }
        .btn { padding: 12px 24px; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; text-decoration: none; transition: all 0.2s; text-align: center; }
        .btn-primary { background-color: #1a233d; color: white; border: none; }
        .btn-primary:hover { background-color: #111729; }
        .btn-secondary { background-color: #FFF; color: #555; border: 1px solid #CCD1D9; }
        .btn-secondary:hover { background-color: #F5F7FA; }
    </style>
</head>
<body>

<div class="profile-container">
    <div class="profile-header">
        <div class="avatar-circle">
            <%= premiereLettre %>
        </div>
        <h1><%= user.getPrenom() %> <%= user.getNom() %></h1>
        <p>Téléphone : <%= user.getTelephone() %></p>
    </div>

    <div class="profile-body">
        <div class="section-title">Mes Critères Économiques</div>
        <div class="info-grid">
            <div class="info-card">
                <label>Capital Disponible</label>
                <span>
                    <%= (profil != null) ? String.format("%,.0f", profil.getCapital()) + " FCFA" : "Non renseigné" %>
                </span>
            </div>
            <div class="info-card">
                <label>Temps disponible par jour</label>
                <span>
                    <%= (profil != null) ? (int) profil.getDisponibilite() + " heures" : "Non renseigné" %>
                </span>
            </div>
            <div class="info-card">
                <label>Zone Géographique</label>
                <span>
                    <%= (profil != null && profil.getZone() != null) ? profil.getZone().name() : "Non spécifiée" %>
                </span>
            </div>
            <div class="info-card">
                <label>Accès à Internet</label>
                <span>
                    <%= (profil != null) ? (profil.isAccessInternet() ? "Oui / Possédé" : "Non / Indisponible") : "Non renseigné" %>
                </span>
            </div>
        </div>

        <div class="section-title">Mes Compétences & Savoir-faire</div>
        <div class="skills-container">
            <% 
                if (profil != null && profil.getCompetences() != null && !profil.getCompetences().isEmpty()) {
                    for (Competence comp : profil.getCompetences()) {
            %>
                        <div class="skill-badge"><%= comp.getNom() %></div>
            <% 
                    }
                } else {
            %>
                    <span style="color: #888; font-style: italic; font-size: 14px;">Aucune compétence enregistrée pour le moment.</span>
            <% 
                }
            %>
        </div>

        <div class="actions-box">
            <a href="renseignerProfil.jsp" class="btn btn-secondary">Modifier mon profil</a>
            <a href="<%=request.getContextPath()%>/RecommandationServelet" class="btn btn-primary">Voir les Activités Recommandées</a>
        </div>
    </div>
</div>

</body>
</html>