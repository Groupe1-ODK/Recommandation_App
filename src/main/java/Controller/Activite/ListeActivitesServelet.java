package Controller.Activite;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import Model.DAO.DAOImpl.ActiviteCompetenceDAOImpl;
import Model.DAO.DAOImpl.ActiviteDAOImpl;
import Model.DAO.DAOImpl.CompetenceDAOImpl;
import Model.DAO.DAOInter.ActiviteInter;
import Model.Entites.Activite;
import Model.InterfaceDB.Database;
import Model.Service.ServiceImpl.ActiviteService;
import Model.Service.ServiceInter.ActiviteServiceInter;
import Model.Utils.ConnexionDB.MySQL;

/**
 * Servlet implementation class ListeActivitesServelet
 */
@WebServlet("/ListeActivitesServelet")
public class ListeActivitesServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ActiviteServiceInter activiteService;

	@Override
	public void init() throws ServletException {
		Database db = new MySQL();
		CompetenceDAOImpl competenceDAO = new CompetenceDAOImpl(db);
		ActiviteCompetenceDAOImpl activiteCompetence = new ActiviteCompetenceDAOImpl(db, competenceDAO);
		ActiviteInter activiteDAO = new ActiviteDAOImpl(db, activiteCompetence);
		this.activiteService = new ActiviteService(activiteDAO);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<Activite> listActivites = activiteService.tousList();

		request.setAttribute("activites", listActivites);

		request.getRequestDispatcher("/listeActivites.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
