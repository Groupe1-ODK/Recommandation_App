package Model.DAO.DAOInter;

import Model.Entites.Profil;

public interface ProfilInter {
	int ajouter(Profil profil);

	Profil trouverParId(int id);

	Profil trouverParUtilisateur(int UtilisateurId);

	void modifier(Profil profil);

	void supprimer(int id);
}
