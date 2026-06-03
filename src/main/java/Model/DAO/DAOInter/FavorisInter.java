package Model.DAO.DAOInter;

import java.util.List;

import Model.Entites.Favoris;

public interface FavorisInter {

	void ajouter(Favoris favoris);

	void retirer(int utilisateurId, int activiteId);

	List<Favoris> trouverParUtilisateur(int utilisateurId);

	boolean existe(int utilisateurId, int activiteId);
}
