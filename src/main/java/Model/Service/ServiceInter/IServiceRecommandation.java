package Model.Service.ServiceInter;

import java.util.List;

import Model.Entites.Activite;
import Model.Entites.Profil;

public interface IServiceRecommandation {
    public void creer (Profil profil);
    public List<Activite> liste(int utilisateurId);
}
