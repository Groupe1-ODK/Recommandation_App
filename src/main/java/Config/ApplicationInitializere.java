package Config;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.Connection;

import Model.DAO.DAOImpl.TacheDAOImpl;
import Model.DAO.DAOImpl.UtilisateurDAOImpl;
import Model.DAO.DAOInter.TacheInter;
import Model.DAO.DAOInter.UtilisateurInter;
import Model.InterfaceDB.Database;

import Model.Service.ServiceImpl.UtilisateurServiceImpl; // ← Important
import Model.Service.ServiceInter.UtilisateurServiceInter;
import Model.Utils.ConnexionDB.MySQL;

@WebListener
public class ApplicationInitializere implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext context = sce.getServletContext();

		try {
			// 1. Base de données
			Database database = new MySQL();
			context.setAttribute("nom", "Fatou");

			Connection test = database.connexion();

			if (test != null) {
				System.out.println("Connexion BD OK");
			} else {
				System.out.println("Connexion BD ECHEC");
			} 

			// 2. Initialisation des DAOs
			UtilisateurInter utilisateurDAO = new UtilisateurDAOImpl(database);
			TacheInter tacheInter = new TacheDAOImpl(database);

			// 3. Initialisation du Service
			UtilisateurServiceInter utilisateurService = new UtilisateurServiceImpl(utilisateurDAO, tacheInter);

			// 4. Mise dans le contexte
			context.setAttribute("utilisateurDAO", utilisateurDAO);
			context.setAttribute("tacheInter", tacheInter);
			context.setAttribute("utilisateurServiceInter", utilisateurService);

			System.out.println("✅ INITIALISATION RÉUSSIE AVEC SUCCÈS !");
			System.out.println("   • Database (MySQL)");
			System.out.println("   • UtilisateurDAO");
			System.out.println("   • TacheDAO");
			System.out.println("   • UtilisateurServiceImpl");

		} catch (Exception e) {
			System.err.println("❌ ERREUR lors de l'initialisation : " + e.getMessage());
			e.printStackTrace();
		}
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("Application arrêtée.");
	}
}