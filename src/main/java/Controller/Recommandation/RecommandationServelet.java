package Controller.Recommandation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import Model.InterfaceDB.*;
import Model.DAO.DAOImpl.ActiviteCompetenceDAOImpl;
import Model.DAO.DAOImpl.ActiviteDAOImpl;
import Model.DAO.DAOImpl.CompetenceDAOImpl;
import Model.DAO.DAOImpl.ProfilDAOImpl;
import Model.DAO.DAOImpl.RecommandationDAOImpl;
import Model.DAO.DAOInter.ActiviteInter;
import Model.DAO.DAOInter.RecommandationDAOInter;
import Model.Entites.Activite;
import Model.Entites.Utilisateur;
import Model.Service.ServiceImpl.ProfilServiceImpl;
import Model.Service.ServiceImpl.RecommandationService;
import Model.Service.ServiceInter.IServiceRecommandation;
import Model.Service.ServiceInter.ProfilServiceInter;
import Model.Utils.ConnexionDB.MySQL;

/**
 * Servlet implementation class RecommandationServelet
 */
@WebServlet("/Recommandation")
public class RecommandationServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final IServiceRecommandation recommandationService;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecommandationServelet() {
        super(); 
     	Database db = new MySQL();
        CompetenceDAOImpl competenceTable = new CompetenceDAOImpl(db);
        ActiviteCompetenceDAOImpl activiteCompetence = new ActiviteCompetenceDAOImpl(db, competenceTable);
        ActiviteInter activiteInter = new ActiviteDAOImpl(db, activiteCompetence);
        RecommandationDAOInter recommandationRepository = new RecommandationDAOImpl(db, activiteInter);
        ProfilDAOImpl profilDAO = new ProfilDAOImpl(db);
        ProfilServiceInter profilService = new ProfilServiceImpl(profilDAO);
        IServiceRecommandation recommandationServicee = new RecommandationService(recommandationRepository, activiteInter,profilService); 
        this.recommandationService = recommandationServicee;
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Utilisateur utilisateur =
                (Utilisateur) session.getAttribute("utilisateurConnecte");

        if (utilisateur == null) {
            response.sendRedirect("connexion.jsp");
            return;
        }

        List<Activite> activites =
                this.recommandationService.liste(utilisateur.getId());

        request.setAttribute("activites", activites);

        request.getRequestDispatcher("/Recommandation.jsp")
               .forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
