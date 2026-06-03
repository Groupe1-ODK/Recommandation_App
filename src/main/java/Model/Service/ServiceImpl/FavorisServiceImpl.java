package Model.Service.ServiceImpl;

import java.util.List;

import Model.DAO.DAOInter.ActiviteInter;
import Model.DAO.DAOInter.FavorisInter;
import Model.DAO.DAOInter.UtilisateurInter;
import Model.Entites.Activite;
import Model.Entites.Favoris;
import Model.Entites.Utilisateur;
import Model.Service.ServiceInter.FavorisServiceInter;

public class FavorisServiceImpl implements FavorisServiceInter {

	private final FavorisInter favorisInter;
	private final UtilisateurInter utilisateurInter;
	private final ActiviteInter activiteInter;

	public FavorisServiceImpl(FavorisInter favorisInter, UtilisateurInter utilisateurInter,
			ActiviteInter activiteInter) {
		this.favorisInter = favorisInter;
		this.utilisateurInter = utilisateurInter;
		this.activiteInter = activiteInter;
	}

	@Override
	public void ajouterFavori(int utilisateurId, int activiteId) {
		// TODO Auto-generated method stub
		if (favorisInter.existe(utilisateurId, activiteId)) {
			System.out.println("Cette activite est deja dans vos favoris");
			return;
		}

		Utilisateur utilisateur = utilisateurInter.trouverParId(utilisateurId);
		if (utilisateur == null) {
			System.out.println("Utilisateur introuvable.");
			return;
		}

		Activite activite = activiteInter.lire(activiteId);
		if (activite == null) {
			System.out.println("Activité introuvable.");
			return;
		}

		Favoris favoris = new Favoris();
		favoris.setUtilisateur(utilisateur);
		favoris.setActivite(activite);
		favorisInter.ajouter(favoris);
		System.out.println("Activité ajoutée aux favoris.");
	}

	@Override
	public void supprimerFavori(int utilisateurId, int activiteId) {
		// TODO Auto-generated method stub
		favorisInter.retirer(utilisateurId, activiteId);
		System.out.println("Favoris supprimé.");

	}

	@Override
	public List<Favoris> obtenirFavorisUtilisateur(int utilisateurId) {
		// TODO Auto-generated method stub
		return favorisInter.trouverParUtilisateur(utilisateurId);
	}

}
