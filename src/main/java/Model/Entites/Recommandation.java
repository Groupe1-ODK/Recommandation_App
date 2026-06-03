package Model.Entites;

import java.util.ArrayList;

import java.util.Date;

import java.util.List;

public class Recommandation {

	private int id;

	private Activite activite;

	private Profil profil;

	private int score;

	private Date dateAjout;

	public Recommandation() {

		// TODO Auto-generated constructor stub

	}

	public int getId() {

		return id;

	}

	public void setId(int id) {

		this.id = id;

	}

	public Activite getActivite() {

		return activite;

	}

	public void setActivite(Activite activite) {

		this.activite = activite;

	}

	public Profil getProfil() {

		return profil;

	}

	public void setProfil(Profil profil) {

		this.profil = profil;

	}

	public int getScore() {

		return score;

	}

	public void setScore(int score) {

		this.score = score;

	}

	public Date getDateAjout() {

		return dateAjout;

	}

	public void setDateAjout(Date dateAjout) {

		this.dateAjout = dateAjout;

	}

}