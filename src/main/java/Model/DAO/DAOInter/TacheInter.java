package Model.DAO.DAOInter;

import java.util.Optional;

import Model.Entites.Tache;
import Model.Enumeration.TypeRole;

public interface TacheInter {
	public Optional<Tache> lire(int roleId);

	public Optional<Tache> findByNom(TypeRole typeRole);

	public void save(Tache role);
}
