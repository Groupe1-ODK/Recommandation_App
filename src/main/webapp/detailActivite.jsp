<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon_Activite - Détail de l'activité</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        body {
            background-color: white;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #000;
        }

        .container-detail {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* Style du bouton retour de ta maquette */
        .btn-back {
            color: #000;
            font-size: 32px;
            text-decoration: none;
            transition: transform 0.2s;
            display: inline-block;
        }

        .btn-back:hover {
            color: #333;
            transform: translateX(-5px);
        }

        .page-title {
            font-size: 36px;
            fw-bold: true;
            font-weight: 700;
        }

        /* Alignement et espacement des blocs d'information */
        .info-label {
            font-weight: 700;
            font-size: 18px;
            color: #000;
            margin-bottom: 0;
        }

        .info-value {
            font-size: 16px;
            color: #333;
            white-space: pre-line; /* Permet de respecter les retours à la ligne des étapes ou matériels */
        }

        /* Espacement vertical entre les lignes d'information */
        .info-row {
            margin-bottom: 45px;
        }
    </style>
</head>
<body>

    <div class="container-detail">
        
        <div class="row align-items-center mb-5 pt-3">
            <div class="col-2">
                <a href="listeActivites.jsp" class="btn-back">
                    <i class="bi bi-arrow-left"></i>
                </a>
            </div>
            <div class="col-8 text-center">
                <h1 class="page-title">Détail de l’activité</h1>
            </div>
            <div class="col-2"></div>
        </div>

        <div class="row px-4">
            
            <div class="col-md-6">
                
                <div class="row info-row">
                    <div class="col-4">
                        <p class="info-label">Nom :</p>
                    </div>
                    <div class="col-8">
                        <p class="info-value">Fabrication savon</p>
                    </div>
                </div>

                <div class="row info-row">
                    <div class="col-4">
                        <p class="info-label">Description :</p>
                    </div>
                    <div class="col-8">
                        <p class="info-value">Produire et distribuer du savon artisanal liquide et solide pour les ménages et les commerces locaux.</p>
                    </div>
                </div>

                <div class="row info-row">
                    <div class="col-4">
                        <p class="info-label">AccesInternet :</p>
                    </div>
                    <div class="col-8">
                        <p class="info-value">Non</p>
                    </div>
                </div>

                <div class="row info-row">
                    <div class="col-4">
                        <p class="info-label">RevenuMin :</p>
                    </div>
                    <div class="col-8">
                        <p class="info-value">25 000 FCFA / mois</p>
                    </div>
                </div>

                <div class="row info-row">
                    <div class="col-4">
                        <p class="info-label">Competence :</p>
                    </div>
                    <div class="col-8">
                        <p class="info-value">Fabrication / Chimie de base</p>
                    </div>
                </div>

                <div class="row info-row">
                    <div class="col-4">
                        <p class="info-label">Materiel :</p>
                    </div>
                    <div class="col-8">
                        <p class="info-value">Moules à savon<br>Mélangeur mécanique<br>Soude caustique & Huiles<br>Gants de protection</p>
                    </div>
                </div>

            </div>


            <div class="col-md-6">
                
                <div class="row info-row">
                    <div class="col-4">
                        <p class="info-label">Etapes :</p>
                    </div>
                    <div class="col-8">
                        <p class="info-value">1- Préparer les matières premières<br>2- Réaliser la saponification<br>3- Couler le mélange dans les moules<br>4- Laisser sécher et découper</p>
                    </div>
                </div>

                <div class="row info-row">
                    <div class="col-4">
                        <p class="info-label">Disponibilite :</p>
                    </div>
                    <div class="col-8">
                        <p class="info-value">15h / semaine</p>
                    </div>
                </div>

                <div class="row info-row">
                    <div class="col-4">
                        <p class="info-label">Capital :</p>
                    </div>
                    <div class="col-8">
                        <p class="info-value">150 000 FCFA</p>
                    </div>
                </div>

                <div class="row info-row">
                    <div class="col-4">
                        <p class="info-label">RevenuMax :</p>
                    </div>
                    <div class="col-8">
                        <p class="info-value">90 000 FCFA / mois</p>
                    </div>
                </div>

                <div class="row info-row">
                    <div class="col-4">
                        <p class="info-label">Risque :</p>
                    </div>
                    <div class="col-8">
                        <p class="info-value">- Hausse du prix des matières premières<br>- Concurrence des produits industriels</p>
                    </div>
                </div>

                <div class="row info-row">
                    <div class="col-4">
                        <p class="info-label">Zone :</p>
                    </div>
                    <div class="col-8">
                        <p class="info-value">URBAINE / RURALE</p>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>