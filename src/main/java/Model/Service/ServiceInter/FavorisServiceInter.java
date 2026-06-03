package Model.Service.ServiceInter;

import java.util.List;

import Model.Entites.Favoris;

public interface FavorisServiceInter {

	void ajouterFavori(int utilisateurId, int activiteId);

	void supprimerFavori(int utilisateurId, int activiteId);

	List<Favoris> obtenirFavorisUtilisateur(int utilisateurId);

}
