package Controller;

import java.io.IOException;

import Model.Utils.ConnexionDB.MySQL;

@WebServlet("/DetailActiviteServlet")
public class DetailActiviteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ActiviteDAOImpl activiteDAO;

    @Override
    public void init() throws ServletException {
        // Initialise ton DAO avec ta classe Database
    	Database db = new MySQL(); 
        this.activiteDAO = new ActiviteDAOImpl(db);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Récupérer l'ID de l'activité envoyé depuis la liste jsp
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int activiteId = Integer.parseInt(idParam);
                
                // 2. Chercher l'activité en BDD (assure-toi d'avoir cette méthode dans ton DAO)
                Activite activite = activiteDAO.trouverParId(activiteId);
                
                if (activite != null) {
                    // 3. Stocker l'activité dans la requête pour la page JSP
                    request.setAttribute("activite", activite);
                } else {
                    request.setAttribute("erreur", "Activité introuvable.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("erreur", "Identifiant d'activité invalide.");
            }
        } else {
            request.setAttribute("erreur", "Aucune activité sélectionnée.");
        }

        // 4. Rediriger vers la page de détails jsp
        request.getRequestDispatcher("/detailActivite.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}