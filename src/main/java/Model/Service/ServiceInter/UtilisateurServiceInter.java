package Model.Service.ServiceInter;

import java.util.List;

import Model.Entites.Utilisateur;

public interface UtilisateurServiceInter {
	void inscription(Utilisateur utilisateur);

	// connexion utilisateur
	Utilisateur connexion(String telephone, String mdp);

	// modifier les informations d’un utilisateur
	void modifierUtilisateur(Utilisateur utilisateur);

	// supprimer un utilisateur
	void supprimerUtilisateur(int id);

	// rechercher utilisateur par id
	Utilisateur rechercherParId(int id);

	// afficher tous les utilisateurs
	List<Utilisateur> afficherTousUtilisateurs();

	Utilisateur trouverParTelephone(String telephone);
}
