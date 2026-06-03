package Model.Service.ServiceImpl;

import Model.DAO.DAOInter.TacheInter;
import Model.DAO.DAOInter.UtilisateurInter;
import Model.Entites.Tache;
import Model.Entites.Utilisateur;
import Model.Enumeration.TypeRole;

public class AdminServiceImpl extends UtilisateurServiceImpl {

	public AdminServiceImpl(UtilisateurInter utilisateurDAO, TacheInter roleDAO) {
		super(utilisateurDAO, roleDAO);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void inscription(Utilisateur utilisateur) {
		if (utilisateur == null)
			return;

		if (utilisateur.getNom() == null || utilisateur.getNom().isBlank()) {
			System.out.println("Nom obligatoire");
			return;
		}
		if (utilisateur.getTelephone() == null || utilisateur.getTelephone().isBlank()) {
			System.out.println("Téléphone obligatoire");
			return;
		}

		// Nettoyage du téléphone (supprime les espaces accidentels)
		utilisateur.setTelephone(utilisateur.getTelephone().trim());

		Utilisateur existant = utilisateurDAO.trouverParTelephone(utilisateur.getTelephone());
		if (existant != null) {
			System.out.println("Ce numéro existe déjà");
			return;
		}

		Tache tache = this.roleInter.findByNom(TypeRole.ADMIN).get();
		utilisateur.setRole(tache);

		utilisateurDAO.creer(utilisateur);

	}

}
