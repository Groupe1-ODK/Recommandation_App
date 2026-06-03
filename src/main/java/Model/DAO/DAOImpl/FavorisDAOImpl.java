package Model.DAO.DAOImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;



import Model.DAO.DAOInter.FavorisInter;
import Model.Entites.Activite;
import Model.Entites.Favoris;
import Model.Entites.Utilisateur;
import Model.InterfaceDB.Database;

public class FavorisDAOImpl implements FavorisInter{
	
	private final Database db;
	
	public FavorisDAOImpl (Database db) {
		this.db = db;
	}

	@Override
	public void ajouter(Favoris favoris) {
		// TODO Auto-generated method stub
		
		String sql = "INSERT INTO favoris (utilisateurId, activiteId, dateAjout) VALUES (?, ?, ?)";
		try (Connection conn = this.db.connexion();
				PreparedStatement pr = conn.prepareStatement(sql);
				
				)
		{
			pr.setInt(1, favoris.getUtilisateur().getId());
			pr.setInt(2, favoris.getActivite().getId());
			
			pr.executeUpdate();
		} catch (SQLException e) {
			// TODO: handle exception
			System.out.println("Erreur ajout favori : "+e.getMessage());
		}
		
	}

	@Override
	public void retirer(int utilisateurId, int activiteId) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM favoris WHERE utilisateurId=? AND activiteId=?";
		try (Connection conn = this.db.connexion();
				PreparedStatement pr = conn.prepareStatement(sql);
				
				)
		
		{
			pr.setInt(1, utilisateurId);
			pr.setInt(2, activiteId);
			
			pr.executeUpdate();
		} catch (SQLException e) {
			// TODO: handle exception
			 System.out.println("Erreur suppression favori : "+ e.getMessage());
		}
	}

	@Override
	public List<Favoris> trouverParUtilisateur(int utilisateurId) {
		// TODO Auto-generated method stub
		
		List<Favoris> list = new ArrayList<>();
		
		String sql = "SELECT * FROM favoris WHERE utilisateurId = ? ORDER BY dateAjout DESC";
		
		try (Connection conn = this.db.connexion();
				PreparedStatement pr = conn.prepareStatement(sql);
				)
		{
			 pr.setInt(1, utilisateurId);
			 ResultSet rs = pr.executeQuery();
			
			 while(rs.next()){
				 
				 Favoris favori = new Favoris();

	                favori.setId(
	                        rs.getInt("id")
	                );

	                Utilisateur utilisateur =
	                        new Utilisateur();

	                utilisateur.setId(
	                        rs.getInt("utilisateurId")
	                );

	                Activite activite =
	                        new Activite();

	                activite.setId(
	                        rs.getInt("activiteId")
	                );

	                favori.setUtilisateur(
	                        utilisateur
	                );

	                favori.setActivite(
	                        activite
	                );

	                favori.setDateAjout(
	                        rs.getTimestamp("dateAjout")
	                );
	                
	                list.add(favori);
				 
				 
			 }
			
		} catch (SQLException e) {
			// TODO: handle exception
			System.out.println("Erreur lors de la lecture favori : "+e.getMessage());
		}
		return list;
	}

	@Override
	public boolean existe(int utilisateurId, int activiteId) {
		// TODO Auto-generated method stub
		
		String sql = "SELECT id FROM favoris WHERE utilisateurId = ? AND activiteId = ?";
		try (Connection conn = this.db.connexion();
				PreparedStatement pr = conn.prepareStatement(sql);
				
				)
		{
			pr.setInt(1, utilisateurId);
			pr.setInt(2, activiteId);
			
			ResultSet rs = pr.executeQuery();
			return rs.next();
			
		} catch (SQLException e) {
			// TODO: handle exception
			System.out.println("Erreur de la verifivation favori : "+e.getMessage());
		}
		return false;
	}

}
