package Controller.Dashboard;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

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

		String nomUtilisateur = "Kadidiatou";

		int nbActivites = 50;
		int nbClients = 100;
		int nbMissions = 20;

		// ENVOYER AU JSP

		request.setAttribute("nomUtilisateur", nomUtilisateur);
		request.setAttribute("nbActivites", nbActivites);
		request.setAttribute("nbClients", nbClients);
		request.setAttribute("nbMissions", nbMissions);

		// OUVRIR LE JSP

		request.getRequestDispatcher("/dashboard.jsp").forward(request, response);

	}

}
