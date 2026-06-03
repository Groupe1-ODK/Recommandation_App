package Model.Entites;

import java.util.Date;

public class Favoris {

	private int id;

	private Utilisateur utilisateur;

	private Activite activite;

	private Date dateAjout;

	public Favoris() {
	}

	public Favoris(int id, Utilisateur utilisateur, Activite activite, Date dateAjout) {

		this.id = id;
		this.utilisateur = utilisateur;
		this.activite = activite;
		this.dateAjout = dateAjout;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Utilisateur getUtilisateur() {
		return utilisateur;
	}

	public void setUtilisateur(Utilisateur utilisateur) {
		this.utilisateur = utilisateur;
	}

	public Activite getActivite() {
		return activite;
	}

	public void setActivite(Activite activite) {
		this.activite = activite;
	}

	public Date getDateAjout() {
		return dateAjout;
	}

	public void setDateAjout(Date dateAjout) {
		this.dateAjout = dateAjout;
	}
}