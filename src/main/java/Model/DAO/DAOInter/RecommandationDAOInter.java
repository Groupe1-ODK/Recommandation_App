package Model.DAO.DAOInter;

import Model.Entites.Utilisateur;

import java.util.List;
import Model.Entites.Activite;

public interface RecommandationDAOInter {
    public void creer (int profilId , List<Activite> activite);
    public List<Activite> liste (int ProfilId);
}
