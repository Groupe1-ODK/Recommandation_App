package Model.DAO.DAOInter;

import java.util.List;

import Model.Entites.Utilisateur;

public interface UtilisateurInter {
	void creer(Utilisateur utilisateur);

	Utilisateur trouverParId(int id);

	Utilisateur trouverParTelephone(String telephone);

	void modifier(Utilisateur utilisateur);

	void supprimer(int id);

	List<Utilisateur> trouveTous();
}
