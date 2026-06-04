package Controller.Client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import Model.DAO.DAOImpl.CompetenceDAOImpl;
import Model.DAO.DAOInter.CompetenceInter;
import Model.Entites.Competence;
import Model.InterfaceDB.Database;
import Model.Utils.ConnexionDB.MySQL;

/**
 * Servlet implementation class ClientServelet
 */
@WebServlet("/client")
public class ClientServelet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private final CompetenceInter competenceTable;

	public ClientServelet() {
		Database db = new MySQL();
		CompetenceInter competenceTable = new CompetenceDAOImpl(db);
		this.competenceTable = competenceTable;
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("utilisateurConnecte") == null) {

			response.sendRedirect(request.getContextPath() + "/connexion");

			return;
		}

		try {
			List<Competence> catalogueCompetences = competenceTable.trouverTousCompetences();
			request.setAttribute("catalogueCompetences", catalogueCompetences);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Erreur lors du chargement des compétences : " + e.getMessage());

		}
		request.getRequestDispatcher("/DashboardClient.jsp").forward(request, response);
	}
}