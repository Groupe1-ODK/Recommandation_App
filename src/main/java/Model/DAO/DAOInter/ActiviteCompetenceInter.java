package Model.DAO.DAOInter;

import java.util.List;

import Model.Entites.Activite;
import Model.Entites.Competence;

public interface ActiviteCompetenceInter {
	public void creer(Activite activite);

	public List<Competence> lire(Activite activite);
}
