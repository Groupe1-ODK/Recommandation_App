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
import Model.DAO.DAOInter.ActiviteCompetenceInter;
import Model.DAO.DAOInter.ActiviteInter;
import Model.Entites.Activite;
import Model.Enumeration.TypeZone;
import Model.InterfaceDB.Database;
import Model.Service.ServiceImpl.ActiviteService;
import Model.Service.ServiceInter.ActiviteServiceInter;
import Model.Utils.ConnexionDB.MySQL;

/**
 * Servlet implementation class ModifierActiviteServlet
 */
@WebServlet("/ModifierActiviteServlet")
public class ModifierActiviteServlet extends HttpServlet {
	// private static final long serialVersionUID = 1L;

	private ActiviteServiceInter activiteService;

	@Override
	public void init() {

		Database db = new MySQL();

		CompetenceDAOImpl competenceDAO = new CompetenceDAOImpl(db);

		ActiviteCompetenceDAOImpl activiteCompetenceDAO = new ActiviteCompetenceDAOImpl(db, competenceDAO);

		ActiviteDAOImpl dao = new ActiviteDAOImpl(db, activiteCompetenceDAO);

		activiteService = new ActiviteService(dao);

	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// récupérer id activité
		int id = Integer.parseInt(request.getParameter("id"));

		Activite activite = activiteService.lire(id);

		request.setAttribute("activite", activite);

		request.getRequestDispatcher("/webapp/modifierActivite.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Activite a = new Activite();

		a.setId(Integer.parseInt(request.getParameter("id")));
		a.setNom(request.getParameter("nom"));
		a.setDescription(request.getParameter("description"));
		a.setEtapes(request.getParameter("etapes"));
		a.setRisques(request.getParameter("risques"));

		a.setDisponibilite(Double.parseDouble(request.getParameter("disponibilite")));
		a.setAccesInternet(Boolean.parseBoolean(request.getParameter("accesInternet")));
		a.setMateriaux(request.getParameter("materiaux"));

		a.setCapital(Double.parseDouble(request.getParameter("capital")));
		a.setRevenueMin(Double.parseDouble(request.getParameter("revenueMin")));
		a.setRevenueMax(Double.parseDouble(request.getParameter("revenueMax")));

		a.setZone(TypeZone.valueOf(request.getParameter("zone").toUpperCase()));

		activiteService.modifier(a);

		response.sendRedirect("listeActivites");
	}
}
