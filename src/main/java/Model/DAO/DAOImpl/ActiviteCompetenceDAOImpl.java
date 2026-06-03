package Model.DAO.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import Model.DAO.DAOInter.ActiviteCompetenceInter;
import Model.Entites.Activite;
import Model.Entites.Competence;
import Model.InterfaceDB.Database;

public class ActiviteCompetenceDAOImpl implements ActiviteCompetenceInter {

	private final Database db;
	private final CompetenceDAOImpl competenceTable;

	public ActiviteCompetenceDAOImpl(Database db, CompetenceDAOImpl competenceTable) {
		this.db = db;
		this.competenceTable = competenceTable;
	}

	@Override
	public void creer(Activite activite) {
		String query = "INSERT INTO activite_competence(activiteId,competenceId) VALUES (?,?)";
		try (Connection conn = this.db.connexion(); PreparedStatement ptmt = conn.prepareStatement(query)) {
			List<Competence> competences = activite.getCompetences();
			for (Competence competence : competences) {
				ptmt.setInt(1, activite.getId());
				ptmt.setInt(2, competence.getId());
				ptmt.executeUpdate();
			}
		} catch (SQLException e) {
			System.out.println("Erreur :" + e.getMessage());
		}
	}

	@Override
	public List<Competence> lire(Activite activite) {
		String query = "SELECT * FROM activite_competence where activiteId = ?";
		List<Competence> competences = new ArrayList<>();

		try (Connection conn = this.db.connexion(); PreparedStatement ptmt = conn.prepareStatement(query)) {
			ptmt.setInt(1, activite.getId());
			try (ResultSet rs = ptmt.executeQuery()) {
				while (rs.next()) {
					int competenceId = rs.getInt("competenceId");

					// 🛠️ ÉTAPE SÉCURISÉE : Récupération de l'Optional sans forcer le .get()
					Optional<Competence> competenceOpt = this.competenceTable.trouverCompetenceParId(competenceId);

					// On vérifie si la compétence existe bel et bien en BDD avant de l'ajouter
					if (competenceOpt.isPresent()) {
						competences.add(competenceOpt.get());
					} else {
						// Petit message console pour t'avertir sans faire cracher Tomcat
						System.out.println("⚠️ Warning : La compétence ID " + competenceId + " liée à l'activité '"
								+ activite.getNom() + "' n'existe pas dans la table competence !");
					}
				}
			} catch (SQLException e) {
				System.out.println("Erreur ResultSet :" + e.getMessage());
			}
		} catch (SQLException e) {
			System.out.println("Erreur Connexion/Statement :" + e.getMessage());
		}
		return competences;
	}

}