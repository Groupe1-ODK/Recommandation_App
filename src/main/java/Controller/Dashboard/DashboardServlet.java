package Controller.Dashboard;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import Model.DAO.DAOImpl.CompetenceDAOImpl;
import Model.Entites.Competence;
import Model.InterfaceDB.Database;
import Model.Utils.ConnexionDB.MySQL;

/**
 * Servlet implementation class DashboardServlet
 */
@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DashboardServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Database db  = new MySQL();
CompetenceDAOImpl competenceDAO = new CompetenceDAOImpl(db);
List<Competence> catalogueCompetences = competenceDAO.trouverTousCompetences();

request.setAttribute("catalogueCompetences", catalogueCompetences);


	
		// OUVRIR LE JSP

		request.getRequestDispatcher("/dashboard.jsp").forward(request, response);

	}

}
