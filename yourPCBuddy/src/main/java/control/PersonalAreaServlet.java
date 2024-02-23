package control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import model.UserDao;
import model.UserDaoDataSource;
import model.UserDao;
import model.User;
/**
 * Servlet implementation class PersonalAreaServlet
 */
@WebServlet("/PersonalAreaServlet")
public class PersonalAreaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PersonalAreaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String isDriverManager = request.getParameter("driver");
		if(isDriverManager == null || isDriverManager.equals("")) {
			isDriverManager = "datasource";
		}
		
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		Integer userId = (Integer)request.getSession().getAttribute("userId");
		UserDao userDao = new UserDaoDataSource(ds);
		
		if(userId==1) {
			request.getRequestDispatcher("AdminPage.jsp").forward(request, response);
		return;
		}
		
		try {
			String action = request.getParameter("action");
			  User user = (User) request.getSession().getAttribute("user");
			request.setAttribute("user", user);
				
			
				if (action != null) {
					if (action.equalsIgnoreCase("ChangeAddress")) {
						
						String oldAddress = user.getIndirizzo();
						
							String[] campi = oldAddress.split("<br>");
				    	
							String stato,citta, provincia,via,numero,cap;

							String statoParameter = request.getParameter("state");
							String cittaParameter = request.getParameter("city");
							String provinciaParameter = request.getParameter("provincia");
							String viaParameter = request.getParameter("street");
							String numberParameter = request.getParameter("number");
							String capParameter = request.getParameter("zip");
						
							if(!statoParameter.isEmpty())
								stato=statoParameter;
							else
								stato = campi[0];
						
							if(!cittaParameter.isEmpty())
								citta=cittaParameter;
							else
								citta = campi[1];
							if(!provinciaParameter.isEmpty())
								provincia=provinciaParameter;
							else
								provincia = campi[2];
						
							if(!viaParameter.isEmpty())
								via=viaParameter;
							else
								via = campi[3];
						
							if(!numberParameter.isEmpty())
								numero=numberParameter;
							else
								numero = campi[4];
						
							if(!capParameter.isEmpty())
								cap=capParameter;
							else
								cap = campi[5];
						
							String Address = stato + "<br>" + via + "<br>" + numero +"<br>"+ citta + "<br>" + "(" +provincia +")" + "<br>" + cap;
				
							userDao.ChangeAddress(userId,Address);
							user.setIndirizzo(Address);
						
					}
					else if(action.equalsIgnoreCase("changeEmail")) {
						String email = request.getParameter("email");
						userDao.ChangeEmail(userId, email);
						user.setEmail(email);
						
					}
				}
		    // Ora puoi inoltrare la richiesta alla tua pagina JSP per visualizzare i dati dell'utente
		    request.getRequestDispatcher("PAView.jsp").forward(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		
		
	}

}
