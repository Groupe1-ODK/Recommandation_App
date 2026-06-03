package Model.DAO.DAOInter;

import java.util.List;

import Model.Entites.Recommandation;

public interface RecommandationInter {
	List<Recommandation> afficher(int profilId);

	void ajouter(Recommandation r);

	void supprimer(int id);
}
