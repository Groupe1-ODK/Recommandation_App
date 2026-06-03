package Controller.Activite;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import Model.DAO.DAOImpl.ActiviteCompetenceDAOImpl;
import Model.DAO.DAOImpl.ActiviteDAOImpl;
import Model.DAO.DAOImpl.CompetenceDAOImpl;
import Model.DAO.DAOInter.ActiviteInter;
import Model.InterfaceDB.Database;
import Model.Service.ServiceImpl.ActiviteService;
import Model.Utils.ConnexionDB.MySQL;

@WebServlet("/SupprimerActivite")
public class SupprimerActivite extends HttpServlet {
	// private static final long serialVersionUID = 1L;

	private ActiviteService activiteService;

	@Override
	public void init() {

		Database db = new MySQL();

		CompetenceDAOImpl competenceDAO = new CompetenceDAOImpl(db);

		ActiviteCompetenceDAOImpl activiteCompetenceDAO = new ActiviteCompetenceDAOImpl(db, competenceDAO);

		ActiviteDAOImpl dao = new ActiviteDAOImpl(db, activiteCompetenceDAO);

		activiteService = new ActiviteService(dao);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// récupérer id
		int id = Integer.parseInt(request.getParameter("id"));

		// suppression
		activiteService.supprimer(id);

		// redirection
		response.sendRedirect("listeDesActivites");
	}

}
