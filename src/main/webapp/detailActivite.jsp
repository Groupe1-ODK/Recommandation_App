<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.Entites.Activite" %>
<%
    // Récupération de l'activité transférée par la Servlet
    Activite activite = (Activite) request.getAttribute("activite");
    
    // Si la servlet ne nous a rien envoyé, on évite le plantage
    if (activite == null) {
        response.sendRedirect("ListeActivitesServelet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    </head>
<body>

    <div class="container-detail">
        
        <div class="row align-items-center mb-5 pt-3">
            <div class="col-2">
                <a href="ListeActivitesServelet" class="btn-back"><i class="bi bi-arrow-left"></i></a>
            </div>
            <div class="col-8 text-center">
                <h1 class="page-title">Détail de l’activité</h1>
            </div>
            <div class="col-2"></div>
        </div>

        <div class="row px-4">
            <div class="col-md-6">
                <div class="row info-row">
                    <div class="col-4"><p class="info-label">Nom :</p></div>
                    <div class="col-8"><p class="info-value"><%= activite.getNom() %></p></div>
                </div>

                <div class="row info-row">
                    <div class="col-4"><p class="info-label">Description :</p></div>
                    <div class="col-8"><p class="info-value"><%= activite.getDescription() %></p></div>
                </div>

                <div class="row info-row">
                    <div class="col-4"><p class="info-label">AccesInternet :</p></div>
                    <div class="col-8"><p class="info-value"><%= activite.isAccessInternet() ? "Oui" : "Non" %></p></div>
                </div>

                <div class="row info-row">
                    <div class="col-4"><p class="info-label">RevenuMin :</p></div>
                    <div class="col-8"><p class="info-value"><%= activite.getRevenuMin() %> FCFA</p></div>
                </div>
                
                </div>

            <div class="col-md-6">
                <div class="row info-row">
                    <div class="col-4"><p class="info-label">Capital :</p></div>
                    <div class="col-8"><p class="info-value"><%= activite.getCapital() %> FCFA</p></div>
                </div>

                <div class="row info-row">
                    <div class="col-4"><p class="info-label">Zone :</p></div>
                    <div class="col-8"><p class="info-value"><%= activite.getZone() %></p></div>
                </div>

                </div>
        </div>
    </div>
</body>
</html>