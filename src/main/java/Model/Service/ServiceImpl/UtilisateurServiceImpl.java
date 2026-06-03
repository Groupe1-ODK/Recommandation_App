package Model.Service.ServiceImpl;

import java.util.List;

import Model.DAO.DAOInter.TacheInter;
import Model.DAO.DAOInter.UtilisateurInter;
import Model.Entites.Tache;
import Model.Entites.Utilisateur;
import Model.Enumeration.TypeRole;
import Model.Service.ServiceInter.UtilisateurServiceInter;

public class UtilisateurServiceImpl implements UtilisateurServiceInter { // ← Enlevé "abstract"

	protected final UtilisateurInter utilisateurDAO;
	protected final TacheInter roleInter;

	public UtilisateurServiceImpl(UtilisateurInter utilisateurDAO, TacheInter roleInter) {
		this.utilisateurDAO = utilisateurDAO;
		this.roleInter = roleInter;
	}

	@Override
	public void inscription(Utilisateur utilisateur) {

		if (utilisateur == null) {

			throw new RuntimeException("Utilisateur invalide");
		}

		if (utilisateur.getTelephone() == null || utilisateur.getTelephone().trim().isEmpty()) {

			throw new RuntimeException("Téléphone obligatoire");
		}

		Utilisateur existant = utilisateurDAO.trouverParTelephone(utilisateur.getTelephone());

		if (existant != null) {

			throw new RuntimeException("Ce numéro existe déjà");
		}

		if (utilisateur.getRole() == null) {

			throw new RuntimeException("Aucun rôle associé à l'utilisateur");
		}

		utilisateurDAO.creer(utilisateur);

		System.out.println("✅ Utilisateur enregistré : " + utilisateur.getTelephone());
	}

	@Override
	public Utilisateur connexion(String telephone, String mdp) {
		if (telephone == null || mdp == null)
			return null;

		// Nettoyage de l'entrée utilisateur
		String telNettoye = telephone.trim();

		Utilisateur u = utilisateurDAO.trouverParTelephone(telNettoye);

		if (u == null) {
			// Si on arrive ici avec l'erreur "role_id not found",
			// c'est le DAO qui a crashé avant de renvoyer l'utilisateur.
			return null;
		}

		if (!u.getMdp().equals(mdp)) {
			System.out.println("Mot de passe incorrect");
			return null;
		}

		Tache role = u.getRole();
		if (role == null || role.getNom() == null) {
			System.out.println("⚠️ Utilisateur connecté mais rôle non chargé (vérifiez le JOIN dans le DAO)");
			return u;
		}

		// Accueil personnalisé
		System.out.println("\n----------------------------");
		switch (role.getNom()) {
		case ADMIN -> System.out.println("Espace Administrateur : Bienvenue " + u.getPrenom());
		case AGENT_TERRAIN -> System.out.println("Espace Agent : Session ouverte pour " + u.getPrenom());
		case CLIENT -> System.out.println("Bienvenue " + u.getPrenom() + " " + u.getNom());
		default -> System.out.println("Bienvenue " + u.getNom());
		}
		System.out.println("----------------------------\n");

		return u;
	}

	// Les autres méthodes restent inchangées
	@Override
	public void modifierUtilisateur(Utilisateur utilisateur) {
		Utilisateur existant = utilisateurDAO.trouverParId(utilisateur.getId());
		if (existant == null) {
			System.out.println("Utilisateur introuvable");
			return;
		}
		utilisateurDAO.modifier(utilisateur);
		System.out.println("Utilisateur modifié avec succès");
	}

	@Override
	public void supprimerUtilisateur(int id) {
		Utilisateur existant = utilisateurDAO.trouverParId(id);
		if (existant == null) {
			System.out.println("Utilisateur introuvable");
			return;
		}
		utilisateurDAO.supprimer(id);
		System.out.println("Utilisateur supprimé avec succès");
	}

	@Override
	public Utilisateur rechercherParId(int id) {
		return utilisateurDAO.trouverParId(id);
	}

	@Override
	public List<Utilisateur> afficherTousUtilisateurs() {
		return utilisateurDAO.trouveTous();
	}

	@Override
	public Utilisateur trouverParTelephone(String telephone) {
		return this.utilisateurDAO.trouverParTelephone(telephone);
	}
}
