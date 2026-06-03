package Model.DAO.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

import Model.DAO.DAOInter.TacheInter;
import Model.Entites.Tache;
import Model.Enumeration.TypeRole;
import Model.InterfaceDB.Database;

public class TacheDAOImpl implements TacheInter {
	private final Database db;

	public TacheDAOImpl(Database db) {
		this.db = db;
	}

	@Override
	public Optional<Tache> lire(int roleId) {
		// TODO Auto-generated method stub
		String query = "SELECT * FROM role WHERE id = ?";

		try (Connection conn = this.db.connexion(); PreparedStatement ptmt = conn.prepareStatement(query)) {

			ptmt.setInt(1, roleId);

			try (ResultSet rs = ptmt.executeQuery()) {

				if (rs.next()) {
					Tache tache = new Tache();
					tache.setId(rs.getInt("id"));
					tache.setNom(TypeRole.valueOf(rs.getString("nom")));
					return Optional.of(tache);
				}
			}

		} catch (SQLException e) {
			System.out.println("Erreur SQL : " + e.getMessage());
		}
		return Optional.empty();
	}

	@Override
	public Optional<Tache> findByNom(TypeRole typeRole) {
		// TODO Auto-generated method stub
		String query = "SELECT * FROM role WHERE nom = ?";

		try (Connection conn = this.db.connexion(); PreparedStatement ptmt = conn.prepareStatement(query)) {

			ptmt.setString(1, typeRole.name());

			try (ResultSet rs = ptmt.executeQuery()) {

				if (rs.next()) {
					Tache tache = new Tache();
					tache.setId(rs.getInt("id"));
					tache.setNom(TypeRole.valueOf(rs.getString("nom")));
					return Optional.of(tache);
				}
			}

		} catch (SQLException e) {
			System.out.println("Erreur SQL : " + e.getMessage());
		}
		return Optional.empty();
	}

	@Override
	public void save(Tache role) {
		// TODO Auto-generated method stub
		String query = "INSERT INTO role(nom) VALUES(?)";

		try (Connection conn = this.db.connexion(); PreparedStatement ptmt = conn.prepareStatement(query)) {

			ptmt.setString(1, role.getNom().name());
			ptmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("SQL error " + e.getMessage());
		}

	}

}