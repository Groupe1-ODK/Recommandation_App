package Model.Service.ServiceInter;

import java.util.List;

import Model.Entites.Activite;

public interface ActiviteServiceInter {

	void ajouter(Activite a);

	void modifier(Activite a);

	void supprimer(int id);

	List<Activite> tousList();

	Activite lire(int id);

}
