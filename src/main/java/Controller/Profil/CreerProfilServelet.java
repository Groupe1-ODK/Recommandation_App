package Controller.Profil;

import Model.DAO.DAOImpl.ActiviteCompetenceDAOImpl;
import Model.DAO.DAOImpl.ActiviteDAOImpl;
import Model.DAO.DAOImpl.CompetenceDAOImpl;
import Model.DAO.DAOImpl.ProfilDAOImpl;
import Model.DAO.DAOImpl.RecommandationDAOImpl;
import Model.DAO.DAOInter.ActiviteInter;
import Model.DAO.DAOInter.RecommandationDAOInter;
import Model.Entites.Competence;
import Model.Entites.Profil;
import Model.Entites.Utilisateur;
import Model.Enumeration.TypeZone;
import Model.InterfaceDB.Database;

import Model.Service.ServiceImpl.ProfilServiceImpl;
import Model.Service.ServiceImpl.RecommandationService;
import Model.Service.ServiceInter.IServiceRecommandation;
import Model.Service.ServiceInter.ProfilServiceInter;
import Model.Utils.ConnexionDB.MySQL;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/profil")
public class CreerProfilServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private ProfilServiceInter profilService;
	private IServiceRecommandation recommandationService;
	private CompetenceDAOImpl competenceTable;

	@Override
	public void init() throws ServletException {
		Database db = new MySQL();
		CompetenceDAOImpl competenceTable = new CompetenceDAOImpl(db);
		this.competenceTable = competenceTable;
		ActiviteCompetenceDAOImpl activiteCompetence = new ActiviteCompetenceDAOImpl(db, competenceTable);
		ActiviteInter activiteService = new ActiviteDAOImpl(db, activiteCompetence);
		ProfilDAOImpl profilDAO = new ProfilDAOImpl(db);
		RecommandationDAOInter recommandationRepository = new RecommandationDAOImpl(db, activiteService);
		ProfilServiceInter profilServicee = new ProfilServiceImpl(profilDAO);
		IServiceRecommandation recommandationServicee = new RecommandationService(recommandationRepository, activiteService, profilServicee);
		this.recommandationService = recommandationServicee;
		this.profilService = profilServicee;
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		try {
			System.out.println("Nous allons chercher les competences dans la base");
			List<Competence> catalogueCompetences = competenceTable.trouverTousCompetences();
			System.out.println("Liste des competences :"+catalogueCompetences);
			request.setAttribute("catalogueCompetences", catalogueCompetences);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Erreur lors du chargement des compétences : " + e.getMessage());
		}
		
		// Note : Laisse ce forward au cas où une route pointe directement vers /profil en GET
		request.getRequestDispatcher("/RenseignerProfil.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("Traitement de la soumission du profil en cours...");
		try {
			HttpSession session = request.getSession();
			Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateurConnecte"); 
			System.out.println("Utilisateur récupéré dans la session ID = " + utilisateur.getId() + " Nom = " + utilisateur.getNom());

			double disponibilite = Double.parseDouble(request.getParameter("disponibilite"));
			
			// Récupération sécurisée du capital (Ajout d'une valeur par défaut si non fourni pour éviter un crash)
			
			String zoneStr = request.getParameter("zone");
			
			// 🛠️ CORRECTION DU NOM DU PARAMÈTRE (Ici on utilise 'accesInternet' avec un c minuscule comme ton HTML/JSP)
			boolean accessInternet = Boolean.parseBoolean(request.getParameter("accesInternet"));

			String[] competencesSaisies = request.getParameterValues("competences");
			List<Competence> listeCompetences = new ArrayList<>();

			if (competencesSaisies != null) {
				for (String nomComp : competencesSaisies) {
					Competence comp = new Competence();
					comp.setNom(nomComp);
					listeCompetences.add(comp);
				}
			}

			Profil profil = new Profil();
			profil.setUtilisateur(utilisateur);
			profil.setDisponibilite(disponibilite);
			
			profil.setAccessInternet(accessInternet);
			
			if (zoneStr != null) {
				profil.setZone(TypeZone.valueOf(zoneStr));
			}
			profil.setCompetences(listeCompetences);
			
			// Persistance et génération des recommandations automatiques
			this.recommandationService.creer(profilService.creerProfil(profil));

			// 🛠️ MODIFICATION DE LA REDIRECTION : Retour immédiat au dashboard au lieu de succes.jsp
			response.sendRedirect(request.getContextPath() + "/client");

		} catch (IllegalArgumentException e) {
			request.setAttribute("error", e.getMessage());
			request.getRequestDispatcher("/RenseignerProfil.jsp").forward(request, response);
		} catch (Exception e) {
			request.setAttribute("error", "Une erreur inattendue est survenue : " + e.getMessage());
			request.getRequestDispatcher("/RenseignerProfil.jsp").forward(request, response);
		}
	}
}