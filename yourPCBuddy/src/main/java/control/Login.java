package control;

import model.ProductBean;
import model.IProductDao;
import model.Cart;
import model.CartDao;
import model.CartDaoDataSource;
import model.DriverManagerConnectionPool;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Login")
public class Login extends HttpServlet {


	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
 
        String login = request.getParameter("username");
        String pwd = request.getParameter("password");
        
        ResultSet logincheck=null;
        PreparedStatement statement = null;
        Connection connection = null;
        
        
        if(login.equalsIgnoreCase("root") && pwd.equals("admin")) {
            request.getSession().setAttribute("uname", login);
            request.getRequestDispatcher("./product").forward(request, response);
            return;
        } 
        else {
        	
            try {
            	DriverManagerConnectionPool connectionPool = DriverManagerConnectionPool.getInstance();
            	connection = connectionPool.getConnection();
            	String query = "SELECT * FROM Utenti WHERE (Nome,Password) = (?, ?)";
            	statement = connection.prepareStatement(query);
            	statement.setString(1, login);
            	statement.setString(2, pwd);
            	logincheck=statement.executeQuery();
    			if(logincheck.next()) {
    				HttpSession session = request.getSession();
                    int userId = logincheck.getInt("ID");
                    String name = logincheck.getString("Nome");
                    boolean isLogged = true; // Imposta isLogged a true
                    getServletContext().setAttribute("isLogged", isLogged); // Aggiorna il contesto dell'applicazione

                    session.setAttribute("userId", userId);
                    session.setAttribute("username", name);
                 // Dopo che l'utente ha effettuato il login con successo
                    
                    //vorrei mettere il carrello al login
                    response.sendRedirect("index.jsp");
                    return;
                    
                } else {
                    // Autenticazione fallita, mostra un messaggio di errore
                    request.setAttribute("errorMessage", "Credenziali di accesso non valide");
                    request.getRequestDispatcher("LoginScreen.jsp").forward(request, response);
                    return;
                }	
            }
            catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (logincheck != null) {
                        logincheck.close();
                    }
                    if (statement != null) {
                        statement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        /*request.setAttribute("error", Boolean.TRUE);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
        dispatcher.forward(request, response);*/
	}

}
