package Controller.Auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import Model.Entites.Tache;
import Model.Entites.Utilisateur;
import Model.Enumeration.TypeRole;
import Model.Service.ServiceInter.UtilisateurServiceInter;

@WebServlet("/inscription")
public class InscriptionServelet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private UtilisateurServiceInter utilisateurServiceInter;

	@Override
	public void init() throws ServletException {

		utilisateurServiceInter = (UtilisateurServiceInter) getServletContext().getAttribute("utilisateurServiceInter");
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/inscription.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("=== DÉBUT doPost InscriptionServlet ===");

		String nom = request.getParameter("nom");
		String prenom = request.getParameter("prenom");
		String telephone = request.getParameter("telephone");
		String mdp = request.getParameter("mdp");

		if (nom == null || prenom == null || telephone == null || mdp == null || nom.isBlank() || prenom.isBlank()
				|| telephone.isBlank() || mdp.isBlank()) {

			request.setAttribute("erreur", "Tous les champs sont obligatoires");

			request.getRequestDispatcher("/inscription.jsp").forward(request, response);
 
			return;
		}

		try {

			Utilisateur utilisateur = new Utilisateur();

			utilisateur.setNom(nom.trim());
			utilisateur.setPrenom(prenom.trim());
			utilisateur.setTelephone(telephone.trim());
			utilisateur.setMdp(mdp);

			Tache roleClient = new Tache();

			roleClient.setId(1); // Adapter selon ta table role

			roleClient.setNom(TypeRole.CLIENT);

			utilisateur.setRole(roleClient);

			System.out.println("Role affecté : CLIENT");

			utilisateurServiceInter.inscription(utilisateur);

			System.out.println("Inscription réussie");

			response.sendRedirect(request.getContextPath() + "/connexion");

		} catch (Exception e) {

			e.printStackTrace();

			request.setAttribute("erreur", e.getMessage());

			request.getRequestDispatcher("/inscription.jsp").forward(request, response);
		}

		System.out.println("=== FIN doPost InscriptionServlet ===");
	}
}