package Model.Service.ServiceImpl;

import java.util.List;

import Model.DAO.DAOInter.ActiviteInter;
import Model.Entites.Activite;
import Model.Service.ServiceInter.ActiviteServiceInter;

public class ActiviteService implements ActiviteServiceInter {
	
	private final ActiviteInter activiteDAO;

	public ActiviteService(ActiviteInter activiteDAO) {
		this.activiteDAO = activiteDAO;
	}

	@Override
	public void ajouter(Activite a) {
		// 🛡️ Validation stricte et sécurisée des données métiers
		if (a == null) {
			System.out.println("L'activité ne peut pas être nulle !");
			return;
		}

		if (a.getNom() == null || a.getNom().trim().isEmpty() ||
		    a.getDescription() == null || a.getDescription().trim().isEmpty() ||
		    a.getEtapes() == null || a.getEtapes().trim().isEmpty() ||
		    a.getRisques() == null || a.getRisques().trim().isEmpty() ||
		    a.getMateriaux() == null || a.getMateriaux().trim().isEmpty() ||
		    a.getZone() == null) {
			
			System.out.println("❌ Erreur : Veuillez remplir tous les champs textuels et la zone !");
			return;
		}

		// Validation des valeurs numériques cohérentes
		if (a.getRevenueMin() < 0 || a.getRevenueMax() < 0 || a.getDisponibilite() < 0 || a.getCapital() < 0) {
			System.out.println("❌ Erreur : Les valeurs financières et la disponibilité ne peuvent pas être négatives !");
			return;
		}

		if (a.getRevenueMin() > a.getRevenueMax()) {
			System.out.println("❌ Erreur : Le revenu minimum ne peut pas être supérieur au revenu maximum !");
			return;
		}

		// Si toutes les validations passent :
		activiteDAO.ajouter(a);
	}

	@Override
	public void modifier(Activite a) {
		if (a == null || a.getId() <= 0) {
			System.out.println("❌ Erreur : ID d'activité invalide pour la modification !");
			return;
		}

		activiteDAO.modifier(a);
	}

	@Override
	public void supprimer(int id) {
		if (id <= 0) {
			System.out.println("❌ Erreur : ID invalide pour la suppression !");
			return;
		}

		activiteDAO.supprimer(id);
	}

	@Override
	public List<Activite> tousList() {
		return activiteDAO.tousList();
	}

	@Override
	public Activite lire(int id) {
		if (id <= 0) {
			System.out.println("❌ Erreur : ID invalide pour la lecture !");
			return null;
		}

		return activiteDAO.lire(id);
	}
}