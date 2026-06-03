package Controller.Profil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import Model.DAO.DAOImpl.ActiviteCompetenceDAOImpl;
import Model.DAO.DAOImpl.ActiviteDAOImpl;
import Model.DAO.DAOImpl.CompetenceDAOImpl;
import Model.DAO.DAOImpl.ProfilDAOImpl;
import Model.DAO.DAOInter.ActiviteInter;
import Model.Entites.Profil;
import Model.Entites.Utilisateur;
import Model.InterfaceDB.Database;
import Model.Service.ServiceImpl.ActiviteService;
import Model.Utils.ConnexionDB.MySQL;

@WebServlet("/VoirProfilServlet")
public class VoirProfilServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProfilDAOImpl profilDAO; // 💡 Déclaration globale pour l'utiliser dans doGet

	@Override
	public void init() throws ServletException {
		Database db = new MySQL();
		this.profilDAO = new ProfilDAOImpl(db); // 💡 Initialisation propre de ton DAO
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateurConnecte");

		// Sécurité : si l'utilisateur n'est pas connecté, redirection
		if (utilisateur == null) {
			response.sendRedirect("connexion.jsp");
			return;
		}

		// 🛠️ RÉCUPÉRATION REELLE DANS LA BASE DE DONNÉES
		// On récupère le profil complet lié à l'ID de l'utilisateur connecté
		// Note : Adapte le nom de la méthode si elle s'appelle "lire" ou
		// "trouverParUtilisateurId" dans ton ProfilDAOImpl
		Profil profil = profilDAO.trouverParUtilisateur(utilisateur.getId());

		// On envoie les données réelles et fraîches à la page JSP
		request.setAttribute("utilisateur", utilisateur);
		request.setAttribute("profil", profil);

		// Envoi vers ta page JSP
		request.getRequestDispatcher("/voirProfil.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}