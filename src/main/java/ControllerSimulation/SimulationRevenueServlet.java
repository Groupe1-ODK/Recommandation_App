package ControllerSimulation;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Importe ta classe logique ici si nécessaire (ex: import package_logique.TaClasseLogique;)

@WebServlet("/SimulationServlet")
public class SimulationRevenueServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SimulationRevenueServlet() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. Forcer l'encodage en UTF-8 pour éviter les problèmes de caractères avec
		// les accents français
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		// 2. Récupération des données du formulaire grâce à l'attribut 'name' de tes
		// inputs/selects
		String disponibilite = request.getParameter("disponibilite");
		String competence = request.getParameter("competence");
		String capitalStr = request.getParameter("capital");
		String zone = request.getParameter("zone");
		String internet = request.getParameter("internet");

		// 3. Conversion sécurisée du capital (le formulaire envoie toujours du texte)
		double capital = 0.0;
		try {
			if (capitalStr != null && !capitalStr.trim().isEmpty()) {
				capital = Double.parseDouble(capitalStr);
			}
		} catch (NumberFormatException e) {
			System.out.println("Erreur de saisie : Le capital n'est pas un nombre valide.");
		}

		// ======================================================================

		// 5. Stockage des données dans l'objet 'request' pour les envoyer à la page de
		// résultat
		request.setAttribute("disponibilite", disponibilite);
		request.setAttribute("competence", competence);
		request.setAttribute("capital", capital);
		request.setAttribute("zone", zone);
		request.setAttribute("internet", internet);

		// 6. Redirection automatique vers la page resultat.jsp
		request.getRequestDispatcher("/resultat.jsp").forward(request, response);
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Sécurité : si quelqu'un tape l'URL directement, on le renvoie au formulaire
		response.sendRedirect("simulation.jsp");
	}
}