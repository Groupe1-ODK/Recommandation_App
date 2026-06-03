package Model.DAO.DAOInter;

import java.util.List;
import java.util.Optional;

import Model.Entites.Competence;

public interface CompetenceInter {
	void creerCompetence(Competence comp);

	void modifierCompetence(Competence comp);

	void supprimerCompetence(int id);

	List<Competence> trouverTousCompetences();

	Optional<Competence> trouverCompetenceParId(int id);
}
