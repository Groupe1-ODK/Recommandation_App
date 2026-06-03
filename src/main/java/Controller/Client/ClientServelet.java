package Controller.Client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet implementation class ClientServelet
 */
@WebServlet("/client")
public class ClientServelet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if(session == null ||
           session.getAttribute("utilisateurConnecte")
           == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/connexion"
            );

            return;
        }

        request.getRequestDispatcher(
                "/DashboardClient.jsp"
        ).forward(request, response);
    }
}