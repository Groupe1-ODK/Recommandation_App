package Model.Service.ServiceImpl;

import java.util.List;
import java.util.Optional;

import Model.Entites.Competence;
import Model.Service.ServiceInter.CompetenceServiceInter;

public class CompetenceService {

	// Dépendance vers l'interface DAO
	private final CompetenceServiceInter competenceDAO;

	// Injection de dépendance par le constructeur
	public CompetenceService(CompetenceServiceInter competenceDAO) {
		this.competenceDAO = competenceDAO;
	}

	// PARTIE AJOUTER UNE COMPETENCE

	public Competence creerCompetence(Competence comp) {

		// Vérification si objet est null
		if (comp == null) {

			System.out.println("Erreur : compétence invalide");
			return null;
		}

		// Vérification du nom
		if (comp.getNom() == null || comp.getNom().trim().isEmpty()) {

			System.out.println("Erreur : le nom est obligatoire");
			return null;
		}

		// Vérification description
		if (comp.getDescription() == null || comp.getDescription().trim().isEmpty()) {

			System.out.println("Erreur : la description est obligatoire");
			return null;
		}

		// Appel DAO
		competenceDAO.creerCompetence(comp);

		System.out.println("Compétence ajoutée avec succès");

		return comp;
	}

	// PARTIE MODIFIER UNE COMPETENCE

	public Optional<Competence> modifierCompetence(Competence comp) {

		// Vérification objet
		if (comp == null) {

			System.out.println(" Erreur : compétence invalide");
			return Optional.empty();
		}

		// Vérification ID
		if (comp.getId() <= 0) {

			System.out.println("Erreur : ID invalide");
			return Optional.empty();
		}

		// Vérifie si la compétence existe
		Optional<Competence> competenceExistante = competenceDAO.trouverCompetenceParId(comp.getId());

		if (competenceExistante.isEmpty()) {

			System.out.println("Erreur : compétence introuvable");
			return Optional.empty();
		}

		// Mise à jour
		competenceDAO.modifierCompetence(comp);

		System.out.println(" Compétence modifiée avec succès");

		return Optional.of(comp);
	}

	// SUPPRIMER UNE COMPETENCE

	public boolean supprimerCompetence(int id) {

		// Vérification ID
		if (id <= 0) {

			System.out.println("Erreur : ID invalide");
			return false;
		}

		// Vérifie si la compétence existe
		Optional<Competence> competence = competenceDAO.trouverCompetenceParId(id);

		if (competence.isEmpty()) {

			System.out.println(" Erreur : compétence inexistante");
			return false;
		}

		// Suppression
		competenceDAO.supprimerCompetence(id);

		System.out.println("Compétence supprimée avec succès");

		return true;
	}

	// PARTIE OBTENIR TOUTES LES COMPETENCES

	public List<Competence> obtenirToutesCompetences() {

		List<Competence> liste = competenceDAO.trouverTousCompetences();

		if (liste.isEmpty()) {

			System.out.println("Aucune compétence trouvée");
		}

		return liste;
	}

	// PARTIE RECHERCHER PAR ID

	public Optional<Competence> obtenirCompetenceParId(int id) {

		// Vérification ID
		if (id <= 0) {

			System.out.println("Erreur : ID invalide");
			return Optional.empty();
		}

		// Recherche la competence
		Optional<Competence> competence = competenceDAO.trouverCompetenceParId(id);

		if (competence.isEmpty()) {

			System.out.println(" Aucune compétence trouvée");
		}

		return competence;
	}
}
