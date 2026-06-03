package Model.DAO.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Model.DAO.DAOInter.ProfilInter;
import Model.Entites.Competence;
import Model.Entites.Profil;
import Model.Enumeration.TypeZone;
import Model.InterfaceDB.Database;
import Model.Mapper.CompetenceMapper;

public class ProfilDAOImpl implements ProfilInter {
	private final Database db;

	public ProfilDAOImpl(Database db) {
		this.db = db;
	}

	@Override
	public int ajouter(Profil profil) {
		String sqlProfil = "INSERT INTO profil(utilisateurId, disponibilite, accesInternet, capital, zone) VALUES(?,?,?,?,?)";
		String sqlCompetence = "SELECT id FROM competence WHERE nom=?";
		String sqlProfilCompetence = "INSERT INTO profil_competence(profilId, competenceId) VALUES(?,?)";
		int profilId = 0;
		Connection conn = null;
		try {
			conn = db.connexion();
			conn.setAutoCommit(false); // 🛠 Début de la transaction

			

			// 1. Insertion du Profil principal
			try (PreparedStatement psProfil = conn.prepareStatement(sqlProfil,
					PreparedStatement.RETURN_GENERATED_KEYS)) {
				psProfil.setInt(1, profil.getUtilisateur().getId());
				psProfil.setDouble(2, profil.getDisponibilite());
				psProfil.setBoolean(3, profil.isAccessInternet());
				psProfil.setDouble(4, profil.getCapital());
				psProfil.setString(5, profil.getZone() != null ? profil.getZone().name() : null);
				psProfil.executeUpdate();

				try (ResultSet generatedKeys = psProfil.getGeneratedKeys()) {
					if (generatedKeys.next()) {
						profilId = generatedKeys.getInt(1);
					}
				}
			}

			// 2. Traitement et association des compétences
			try (PreparedStatement psCompetence = conn.prepareStatement(sqlCompetence);
					PreparedStatement psProfilCompetence = conn.prepareStatement(sqlProfilCompetence)) {

				for (Competence competence : profil.getCompetences()) {
					int competenceId = competence.getId();

					// Si l'objet vient du Servlet avec uniquement un nom, on récupère son ID en
					// base
					if (competenceId == 0 && competence.getNom() != null) {
						psCompetence.setString(1, competence.getNom().trim());
						try (ResultSet rs = psCompetence.executeQuery()) {
							if (rs.next()) {
								competenceId = rs.getInt("id");
							} else {
								System.out.println("⚠️ Attention : La compétence '" + competence.getNom()
										+ "' n'existe pas dans la table 'competence'.");
							}
						}
					}

					// 🛡️ Protection cruciale : on n'insère que si l'ID a bien été trouvé en base
					// (!= 0)
					if (competenceId > 0) {
						psProfilCompetence.setInt(1, profilId);
						psProfilCompetence.setInt(2, competenceId);
						psProfilCompetence.executeUpdate();
					}
				}
			}

			conn.commit(); // 🛠️ Tout s'est bien passé, on valide l'écriture globale
			System.out.println(" Profil et compétences ajoutés avec succès !");
		} catch (SQLException e) {
			if (conn != null) {
				try {
					conn.rollback();
				} catch (SQLException ex) {
					ex.printStackTrace();
				} // Annulation en cas de pépin
			}
			System.out.println("Erreur ajout profil : " + e.getMessage());
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return profilId;
	}

	@Override
	public Profil trouverParId(int id) {
		String sqlProfil = "SELECT * FROM profil WHERE id=?";
		String sqlCompetences = "SELECT c.id, c.nom, c.description " + "FROM competence c "
				+ "JOIN profil_competence pc ON c.id = pc.competenceId " + "WHERE pc.profilId=?";

		Profil profil = null;

		try (Connection conn = db.connexion();
				PreparedStatement psProfil = conn.prepareStatement(sqlProfil);
				PreparedStatement psCompetences = conn.prepareStatement(sqlCompetences)) {

			psProfil.setInt(1, id);

			try (ResultSet rsProfil = psProfil.executeQuery()) {
				if (rsProfil.next()) {
					profil = new Profil();
					profil.setId(rsProfil.getInt("id"));
					profil.setDisponibilite(rsProfil.getDouble("disponibilite"));
					profil.setAccessInternet(rsProfil.getBoolean("accesInternet"));
					profil.setCapital(rsProfil.getDouble("capital"));

					String zoneStr = rsProfil.getString("zone");
					if (zoneStr != null) {
						profil.setZone(TypeZone.valueOf(zoneStr));
					}

					// Récupération sécurisée de la liste des compétences associées
					psCompetences.setInt(1, id);
					try (ResultSet rsCompetences = psCompetences.executeQuery()) {
						List<Competence> competences = new ArrayList<>();
						while (rsCompetences.next()) {
							Competence c = CompetenceMapper.map(rsCompetences);
							competences.add(c);
						}
						profil.setCompetences(competences);
					}
				}
			}

		} catch (SQLException e) {
			System.out.println("Erreur recherche profil : " + e.getMessage());
		}

		return profil;
	}

	@Override
	public void modifier(Profil profil) {
		String sqlUpdateProfil = "UPDATE profil SET disponibilite=?, accesInternet=?, capital=?, zone=? WHERE id=?";
		String sqlDeleteCompetences = "DELETE FROM profil_competence WHERE profilId=?";
		String sqlCompetence = "SELECT id FROM competence WHERE nom=?";
		String sqlInsertCompetence = "INSERT INTO profil_competence(profilId, competenceId) VALUES(?,?)";

		Connection conn = null;
		try {
			conn = db.connexion();
			conn.setAutoCommit(false); // 🛠️ Mode transactionnel actif

			// 1. Mise à jour de la table profil
			try (PreparedStatement psUpdate = conn.prepareStatement(sqlUpdateProfil)) {
				psUpdate.setDouble(1, profil.getDisponibilite());
				psUpdate.setBoolean(2, profil.isAccessInternet());
				psUpdate.setDouble(3, profil.getCapital());
				psUpdate.setString(4, profil.getZone() != null ? profil.getZone().name() : null);
				psUpdate.setInt(5, profil.getId());
				psUpdate.executeUpdate();
			}

			// 2. Suppression des anciennes associations de compétences
			try (PreparedStatement psDelete = conn.prepareStatement(sqlDeleteCompetences)) {
				psDelete.setInt(1, profil.getId());
				psDelete.executeUpdate();
			}

			// 3. Ré-insertion des nouvelles compétences après vérification
			try (PreparedStatement psCompetence = conn.prepareStatement(sqlCompetence);
					PreparedStatement psInsert = conn.prepareStatement(sqlInsertCompetence)) {

				for (Competence competence : profil.getCompetences()) {
					int competenceId = competence.getId();

					if (competenceId == 0 && competence.getNom() != null) {
						psCompetence.setString(1, competence.getNom().trim());
						try (ResultSet rs = psCompetence.executeQuery()) {
							if (rs.next()) {
								competenceId = rs.getInt("id");
							}
						}
					}

					if (competenceId > 0) {
						psInsert.setInt(1, profil.getId());
						psInsert.setInt(2, competenceId);
						psInsert.executeUpdate();
					}
				}
			}

			conn.commit(); // 🛠️ Validation de la modification globale
			System.out.println("Profil modifié avec succès.");

		} catch (SQLException e) {
			if (conn != null) {
				try {
					conn.rollback();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			System.out.println("Erreur modification : " + e.getMessage());
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void supprimer(int id) {
		String sqlDeleteProfilCompetence = "DELETE FROM profil_competence WHERE profilId=?";
		String sqlDeleteProfil = "DELETE FROM profil WHERE id=?";

		Connection conn = null;
		try {
			conn = db.connexion();
			conn.setAutoCommit(false);

			try (PreparedStatement psDeletePC = conn.prepareStatement(sqlDeleteProfilCompetence)) {
				psDeletePC.setInt(1, id);
				psDeletePC.executeUpdate();
			}

			try (PreparedStatement psDeleteProfil = conn.prepareStatement(sqlDeleteProfil)) {
				psDeleteProfil.setInt(1, id);
				psDeleteProfil.executeUpdate();
			}

			conn.commit();
			System.out.println("Profil supprimé.");

		} catch (SQLException e) {
			if (conn != null) {
				try {
					conn.rollback();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			System.out.println("Erreur suppression : " + e.getMessage());
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public Profil trouverParUtilisateur(int utilisateurId) {
		String sql = "SELECT id FROM profil WHERE utilisateurId=?";
		Profil profil = null;

		try (Connection conn = db.connexion(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, utilisateurId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					int profilId = rs.getInt("id");
					profil = trouverParId(profilId); // Réutilisation propre
				}
			}

		} catch (SQLException e) {
			System.out.println("Erreur recherche utilisateur : " + e.getMessage());
		}

		return profil;
	}
}