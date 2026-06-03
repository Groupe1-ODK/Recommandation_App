package Model.DAO.DAOInter;

import java.util.List;

import Model.Entites.Activite;

public interface ActiviteInter {

	void ajouter(Activite a);

	void modifier(Activite a);

	void supprimer(int id);

	List<Activite> tousList();

	Activite lire(int id);
}
