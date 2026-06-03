<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modification d'une activite </title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/modifier.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>



<div class="container">

 <div class="card">

    <div class="header">

        <a href="listeActivites" class="back"><i class="fa-solid fa-arrow-left"></i></a>

        <h1>Modifier une activité</h1>

    </div>

    <form action="modifierActivite" method="post">

        <input type="hidden" name="id" value="${activite.id}">

        <div class="form-grid">

            <!-- COLONNE GAUCHE -->
            <div class="column">

                <div class="form-group">
                    <label>Nom</label>

                    <input type="text"
                           name="nom"
                           value="${activite.nom}"
                           placeholder="Entrez votre nom">
                </div>

                <div class="form-group">
                    <label>Description</label>

                    <input type="text"
                           name="description"
                           value="${activite.description}"
                           placeholder="Entrez la description de l'activité">
                </div>

                <div class="form-group">
                    <label>AccesInternet</label>

                    <input type="text"
                           name="accesInternet"
                           value="${activite.accesInternet}"
                           placeholder="Entrez votre accès internet">
                </div>

                <div class="form-group">
                    <label>RevenuMin</label>

                    <input type="number"
                           name="revenueMin"
                           value="${activite.revenueMin}"
                           placeholder="Entrez votre revenu minimal">
                </div>

                <div class="form-group">
                    <label>Competence</label>

                    <select name="competence">
                        <option>Selectionner une competence</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Materiel</label>

                    <input type="text"
                           name="materiaux"
                           value="${activite.materiaux}"
                           placeholder="Entrer le matériel nécessaire">
                </div>

            </div>

            <!-- COLONNE DROITE -->
            <div class="column">

                <div class="form-group">
                    <label>Etapes</label>

                    <input type="text"
                           name="etapes"
                           value="${activite.etapes}"
                           placeholder="Entrer les étapes">
                </div>

                <div class="form-group">
                    <label>Disponibilite</label>

                    <input type="number"
                           name="disponibilite"
                           value="${activite.disponibilite}"
                           placeholder="Entrer votre disponibilité">
                </div>

                <div class="form-group">
                    <label>Capital</label>

                    <input type="number"
                           name="capital"
                           value="${activite.capital}"
                           placeholder="Entrer votre capital">
                </div>

                <div class="form-group">
                    <label>RevenuMax</label>

                    <input type="number"
                           name="revenueMax"
                           value="${activite.revenueMax}"
                           placeholder="Entrez votre revenu maximal">
                </div>

                <div class="form-group">
                    <label>Risque</label>

                    <input type="text"
                           name="risques"
                           value="${activite.risques}"
                           placeholder="Entrer les risques">
                </div>

                <div class="form-group">
                    <label>Zone</label>

                    <input type="text"
                           name="zone"
                           value="${activite.zone}"
                           placeholder="Ville ou village">
                </div>

            </div>

        </div>

        <!-- BUTTON -->
        <div class="btn-container">

            <button type="submit">
                Modifier 
              <i class="fa-solid fa-rotate"></i>
            </button>

        </div>
        
        </div>
        

    </form>

</div>

</body>
</html>