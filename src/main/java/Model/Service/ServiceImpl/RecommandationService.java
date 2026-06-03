package Model.Service.ServiceImpl;

import java.util.ArrayList;
import java.util.List;

import Model.DAO.DAOInter.ActiviteInter;
import Model.DAO.DAOInter.RecommandationDAOInter;
import Model.Entites.Activite;
import Model.Entites.Profil;
import Model.Service.ServiceInter.IServiceRecommandation;
import Model.Service.ServiceInter.ProfilServiceInter;

public class RecommandationService implements IServiceRecommandation{

    private final RecommandationDAOInter recommandationRepository;
    private final ActiviteInter activiteService;
    private final ProfilServiceInter profilService;

    public RecommandationService(RecommandationDAOInter recommandationRepository, ActiviteInter activiteRepository,ProfilServiceInter profilService) {
        this.recommandationRepository = recommandationRepository;
        this.activiteService = activiteRepository;
        this.profilService  = profilService;
    } 

    @Override
    public void creer(Profil profil) {
        List<Activite> activites = this.activiteService.tousList();
        List<Activite> recommandation = new ArrayList<>();
        if (!activites.isEmpty()) {
            for (Activite activite : activites) {
                if (profil.isAccessInternet() == activite.isAccesInternet()
                        && profil.getDisponibilite() >= activite.getDisponibilite()
                        && profil.getZone().name() == activite.getZone().name()
                        && profil.getCompetences().containsAll(activite.getCompetences())) {
                    recommandation.add(activite);
                }
            }
        }
        this.recommandationRepository.creer(profil.getId(), recommandation);
    }

	@Override
	public List<Activite> liste(int utilisateurId) {
		return this.recommandationRepository.liste(this.profilService.obtenirProfilParUtilisateur(utilisateurId).getId());
	}
}

