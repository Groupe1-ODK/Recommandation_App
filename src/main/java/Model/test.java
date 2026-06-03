package Model;

import java.sql.DriverManager;

public class test {
	public static void main(String[] args) {
		String url = "jdbc:mysql://localhost:3306/application_recommandation";

		String username = "root";
		String passwd = "root";

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			 DriverManager.getConnection(url, username, passwd);

			System.out.println("Connexion MySQL réussie");

		} catch (Exception e) {

			System.out.println("Erreur connexion : " + e.getMessage());

			e.printStackTrace();
		}
		
	}
}
