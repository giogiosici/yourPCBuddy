package control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import model.IProductDao;
import model.ProductBean;
import model.ProductDaoDataSource;

/**
 * Servlet implementation class CatalogServlet
 */
@WebServlet("/CatalogServlet")
public class CatalogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CatalogServlet() {
        super();
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String isDriverManager = request.getParameter("driver");
		if(isDriverManager == null || isDriverManager.equals("")) {
			isDriverManager = "datasource";
		}
		
		IProductDao productDao = null;

			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			productDao = new ProductDaoDataSource(ds);
			
			try {
				Collection<ProductBean> AllProducts = productDao.doRetrieveAll();
				HttpSession session = request.getSession();
				session.setAttribute("AllProducts", AllProducts);
				
			} catch (SQLException e) {
				
	            logger.log(Level.ALL, ERROR ,e);
			}
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Catalogo.jsp");
			dispatcher.forward(request,response);
	}
	private static final Logger logger = Logger.getLogger(CatalogServlet.class.getName());
    private static final String ERROR = "Errore";
}
