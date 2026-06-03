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
		ActiviteCompetenceDAOImpl activiteCompetence= new ActiviteCompetenceDAOImpl(db, competenceTable);
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
			List<Competence> catalogueCompetences = competenceTable.trouverTousCompetences();
			request.setAttribute("catalogueCompetences", catalogueCompetences);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Erreur lors du chargement des compétences : " + e.getMessage());
		}
		
		request.getRequestDispatcher("/RenseignerProfil.jsp").forward(request, response);
		}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("Bienvenue dshbdw completer son profil");
		try {
			HttpSession session = request.getSession();
			Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateurConnecte"); 
			System.out.println("utilisateur recuperer dans la session id = "+utilisateur.getId()+" nom= "+utilisateur.getNom());

		//	int utilisateurId = Integer.parseInt(request.getParameter("utilisateurId"));
			double disponibilite = Double.parseDouble(request.getParameter("disponibilite"));
			double capital = Double.parseDouble(request.getParameter("capital"));
			String zoneStr = request.getParameter("zone");
			boolean accessInternet = Boolean.parseBoolean(request.getParameter("accessInternet"));

			String[] competencesSaisies = request.getParameterValues("competences");
			List<Competence> listeCompetences = new ArrayList<>();

			if (competencesSaisies != null) {
				for (String nomComp : competencesSaisies) {
					Competence comp = new Competence();
					comp.setNom(nomComp); //
					listeCompetences.add(comp);
				}
			}


			Profil profil = new Profil();
			profil.setUtilisateur(utilisateur);
			profil.setDisponibilite(disponibilite);
			profil.setCapital(capital);
			profil.setAccessInternet(accessInternet);
			if (zoneStr != null) {
				profil.setZone(TypeZone.valueOf(zoneStr));
			}
			profil.setCompetences(listeCompetences);
			
			this.recommandationService.creer(profilService.creerProfil(profil));

			response.sendRedirect(request.getContextPath() + "/succes.jsp");

		} catch (IllegalArgumentException e) {

			request.setAttribute("error", e.getMessage());

			request.getRequestDispatcher("/RenseignerProfil.jsp").forward(request, response);

		} catch (Exception e) {

			request.setAttribute("error", "Une erreur inattendue est survenue : " + e.getMessage());
			request.getRequestDispatcher("/RenseignerProfil.jsp").forward(request, response);
		}
	}
}