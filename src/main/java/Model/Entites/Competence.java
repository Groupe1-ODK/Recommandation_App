package Model.Entites;

import java.util.Objects;

public class Competence {

	private int id;

	private String nom;

	private String description;

	public Competence() {

		// TODO Auto-generated constructor stub

	}
	
	@Override
	public boolean equals(Object o) {

		if (this == o) { 
			return true;
		}

		if (!(o instanceof Competence)) {
			return false;
		}

		Competence competence = (Competence) o;

		return Objects.equals(id, competence.id);
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	public Competence(int id, String nom, String description) {

		this.id = id;

		this.nom = nom;

		this.description = description;

	}

	public int getId() {

		return id;

	}

	public void setId(int id) {

		this.id = id;

	}

	public String getNom() {

		return nom;

	}

	public void setNom(String nom) {

		this.nom = nom;

	}

	public String getDescription() {

		return description;

	}

	public void setDescription(String description) {

		this.description = description;

	}

}