package Controller.Auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import Model.Entites.Utilisateur;
import Model.Service.ServiceInter.UtilisateurServiceInter;

/**
 * Servlet implementation class ConnexionServelet
 */
@WebServlet("/connexion")
public class ConnexionServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   private UtilisateurServiceInter utilisateurServiceInter;
   
   @Override
   public void init() throws ServletException {
	   utilisateurServiceInter =
			   ( UtilisateurServiceInter)
			   getServletContext().getAttribute("utilisateurServiceInter");
   }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 request.getRequestDispatcher(
	                "/connexion.jsp")
	                .forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String telephone = request.getParameter("telephone");
		String mdp = request.getParameter("mdp");
		 
		Utilisateur utilisateur = utilisateurServiceInter.connexion(telephone, mdp);
		if(utilisateur != null) {
			HttpSession session = request.getSession();
			session.setAttribute("utilisateurConnecte", utilisateur);
			
			switch (utilisateur.getRole().getNom()) {
			case CLIENT: {
				System.out.println("context path==========="+request.getContextPath());
//				System.out.println("context path==========="+con.getContextPath());
			    response.sendRedirect(
			            request.getContextPath()
			            + "/client"
			    );
			    break;
			}
			case AGENT_TERRAIN: {
				response.sendRedirect(request.getContextPath() + "/dashboardAgent.jsp");
				break;
			}
			case ADMIN: {
				response.sendRedirect(request.getContextPath() + "/dashboardAdmin.jsp");
			}
			
			}
		}
	}

}
