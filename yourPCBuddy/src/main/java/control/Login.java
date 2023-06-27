package control;

import model.DriverManagerConnectionPool;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/loginServlet")
public class Login extends HttpServlet {
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
 
        String login = request.getParameter("username");
        String pwd = request.getParameter("password");
        ResultSet logincheck=null;
        PreparedStatement statement = null;
        Connection connection = null;
        
        if(login.equalsIgnoreCase("root") && pwd.equals("admin")) {
            request.getSession().setAttribute("uname", login);
            response.sendRedirect("welcomeServlet");
            return;
        } 
        else {
        	
            try {
            	DriverManagerConnectionPool connectionPool = DriverManagerConnectionPool.getInstance();
            	connection = connectionPool.getConnection();
            	String query = "SELECT * FROM Utenti WHERE Nome = ?";
            	statement = connection.prepareStatement(query);
            	statement.setString(1, login);
            	logincheck=statement.executeQuery();
        			if(logincheck.next()) {
        				response.setContentType("text/html");
        				PrintWriter out = response.getWriter();
        			       out.println("<!doctype html>");
        			       out.println("<html><body>");
        			       out.println("<h2>DB check</h2>");
        			       out.println("<p style='color: green;'>");
        			       out.println("Database</p>");
        			       out.println("</body></html>");
            		}
        			else {
        				response.setContentType("text/html");
        				PrintWriter out = response.getWriter();
     			       out.println("<!doctype html>");
     			       out.println("<html><body>");
     			       out.println("<h2>DB check</h2>");
     			       out.println("<p style='color: green;'>");
     			       out.println("Database no</p>");
     			       out.println("</body></html>");
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

	/*protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}*/

}
