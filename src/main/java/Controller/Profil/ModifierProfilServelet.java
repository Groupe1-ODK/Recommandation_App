package Controller.Profil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

import Model.DAO.DAOImpl.ProfilDAOImpl;
import Model.DAO.DAOInter.ProfilInter;
import Model.Entites.Profil;
import Model.Entites.Utilisateur;
import Model.Enumeration.TypeZone;
import Model.Utils.ConnexionDB.MySQL;

@WebServlet("/ModifierProfilServelet")
public class ModifierProfilServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProfilInter profilDAO;

	@Override
	public void init() throws ServletException {
		// Même initialisation du DAO
		MySQL db = new MySQL();
		this.profilDAO = new ProfilDAOImpl(db);
	}

	/**
	 * Charge le profil existant et l'envoie au formulaire de modification
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Utilisateur userConnecte = (Utilisateur) session.getAttribute("userConnecte");

		if (userConnecte == null) {
			response.sendRedirect("connexion.jsp");
			return;
		}

		// On cherche le profil de l'utilisateur connecté via ton DAO
		Profil profilExistant = profilDAO.trouverParUtilisateur(userConnecte.getId());

		if (profilExistant != null) {
			// On stocke le profil existant dans la requête pour que la JSP puisse
			// pré-remplir les inputs
			request.setAttribute("profil", profilExistant);
		}

		request.getRequestDispatcher("/modifierProfilForm.jsp").forward(request, response);
	}

	/**
	 * Traite la mise à jour des données du profil
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Utilisateur userConnecte = (Utilisateur) session.getAttribute("userConnecte");

		if (userConnecte == null) {
			response.sendRedirect("connexion.jsp");
			return;
		}

		try {
			// 1. On va chercher l'ancien profil pour garder son ID technique
			Profil profil = profilDAO.trouverParUtilisateur(userConnecte.getId());

			// 2. On met à jour l'objet avec les nouvelles valeurs reçues du formulaire
			profil.setDisponibilite(Double.parseDouble(request.getParameter("disponibilite")));
			profil.setAccessInternet(request.getParameter("accesInternet") != null);
			profil.setCapital(Double.parseDouble(request.getParameter("capital")));
			profil.setZone(TypeZone.valueOf(request.getParameter("zone")));
			profil.setCompetences(new ArrayList<>()); // À adapter selon tes compétences récoltées

			// 3. Appel de la méthode modifier de ton ProfilDAOImpl
			profilDAO.modifier(profil);

			// 4. Succès, retour vers l'espace utilisateur ou le profil mis à jour
			response.sendRedirect("listeActivites.jsp");

		} catch (Exception e) {
			request.setAttribute("erreur", "Erreur lors de la modification : " + e.getMessage());
			doGet(request, response); // Réaffiche le formulaire avec l'erreur
		}
	}
}