package Model.DAO.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Model.DAO.DAOInter.ActiviteInter;
import Model.DAO.DAOInter.RecommandationDAOInter;
import Model.Entites.Activite;
import Model.Entites.Utilisateur;
import Model.InterfaceDB.Database;


public class RecommandationDAOImpl implements RecommandationDAOInter{

	private final Database db;
	private final ActiviteInter activiteInter;

	public RecommandationDAOImpl(Database db,ActiviteInter activiteInter) {
		this.db = db;
		this.activiteInter = activiteInter;
	}

	@Override 
	public void creer(int profilId, List<Activite> activites) {
		String query = "INSERT INTO recommandation(profilId,activiteId) VALUES (?,?)";
		try (Connection conn = this.db.connexion(); PreparedStatement ptmt = conn.prepareStatement(query)) {
			for (Activite activite : activites) {
				ptmt.setInt(1, profilId);
				ptmt.setInt(2, activite.getId());
				ptmt.executeUpdate();
			}
		} catch (SQLException e) {
			System.out.println("Erreur: " + e.getMessage());
		}
	}

	
	@Override
	public List<Activite> liste(int profilId) {

	    String query = """
	        SELECT *
	        FROM recommandation
	        WHERE profilId = ?
	        AND dateAjout = (
	            SELECT MAX(dateAjout)
	            FROM recommandation
	            WHERE profilId = ?
	        )
	        """;

	    List<Activite> activites = new ArrayList<>();

	    try (Connection conn = this.db.connexion();
	         PreparedStatement ptmt = conn.prepareStatement(query)) {

	        ptmt.setInt(1, profilId);
	        ptmt.setInt(2, profilId);

	        ResultSet rs = ptmt.executeQuery();

	        while (rs.next()) {
	            Activite activite = this.activiteInter.lire(rs.getInt("activiteId"));

	            if (activite != null) {
	                activites.add(activite);
	            }
	        }

	    } catch (SQLException e) {
	        System.out.println("Erreur : " + e.getMessage());
	    }

	    return activites;
	}

}
