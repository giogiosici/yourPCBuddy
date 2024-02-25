package control;

import model.DriverManagerConnectionPool;
import model.User;
import model.UserDao;
import model.UserDaoDataSource;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection connection=null;  
	ResultSet usercheck=null;
    PreparedStatement statement = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
	public void init() throws ServletException {
        super.init();
        try {
        	DriverManagerConnectionPool connectionPool = DriverManagerConnectionPool.getInstance();
        	connection = connectionPool.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }

	}
	
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		UserDao userDao= new UserDaoDataSource(ds);
		
		String nome = request.getParameter("nome");
		String cognome = request.getParameter("cognome");
		String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
			try {
				if (userDao.isUsernameExists(username)) {
				    // Il nome utente esiste già nel database
					request.getRequestDispatcher("RegisterPage.jsp?error=username_exists").forward(request, response);
				    return; // Termina l'esecuzione della servlet
				}
				else if (userDao.isEmailExists(email)) {
				    // L'email esiste già nel database
				   request.getRequestDispatcher("RegisterPage.jsp?error=email_exists").forward(request, response);
					    return; // Termina l'esecuzione della servlet
				}
			} catch (SQLException | ServletException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				if(userDao.doSaveUser(new User(nome,cognome,username,password,email)))
			        response.sendRedirect("RegSucc.jsp");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
}