package control;

import model.ProductBean;
import model.IProductDao;

import model.ProductDaoDataSource;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UncheckedIOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.sql.DataSource;

@MultipartConfig
/**
 * Servlet implementation class ProductControl
 */
 @WebServlet("/ProductControl")
public class ProductControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ProductControl() {
		super();
	}
	private String getFileName(Part part) {
	    String contentDisposition = part.getHeader("content-disposition"); 
	    String[] tokens = contentDisposition.split(";");

	    for (String token : tokens) {
	        if (token.trim().startsWith("filename")) {
	            return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
	        }
	    }

	    return null;
	}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		String isDriverManager = request.getParameter("driver");
		if(isDriverManager == null || isDriverManager.equals("")) {
			isDriverManager = "datasource";
		}
		
		IProductDao productDao = null;

			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			productDao = new ProductDaoDataSource(ds);
			
		String action = request.getParameter("action");

		try {
			if (action != null) {
				if (action.equalsIgnoreCase("details")) {
					int id = Integer.parseInt(request.getParameter("id"));
					request.removeAttribute("product");
					request.setAttribute("product", productDao.doRetrieveByKey(id));
				} else if (action.equalsIgnoreCase("delete")) {
					int id = Integer.parseInt(request.getParameter("id"));
					productDao.doDelete(id);
				
				}	else if(action.equalsIgnoreCase("pdate")) { //aggiorna vicino al prodotto
					int id = Integer.parseInt(request.getParameter("id"));
				    ProductBean existingProduct = productDao.doRetrieveByKey(id);
				    
				    request.setAttribute("existingProduct", existingProduct);
				    
				} else if(action.equalsIgnoreCase("Annulla")) { //annulla vicino al prodotto
					   	    
					    request.setAttribute("existingProduct", null);
				    
				} else if (action.equalsIgnoreCase("update")) {
					int id = Integer.parseInt(request.getParameter("id"));
					ProductBean existingProduct = productDao.doRetrieveByKey(id);
					double price;
					int quantity;
					int oldQuantity = existingProduct.getQuantity();

					String name = request.getParameter("name");
					String description = request.getParameter("description");
					String priceParameter = request.getParameter("price");
					if (priceParameter != null && !priceParameter.isEmpty()) {
					    price = Double.parseDouble(priceParameter);
					} else 
						price = 0.0;
					String quantityParameter = request.getParameter("quantity");
					if (quantityParameter != null && !quantityParameter.isEmpty()) {
					    quantity = Integer.parseInt(request.getParameter("quantity"));
					} else 
						quantity = 0;
					String Categoria = request.getParameter("Categoria");
					String brand = request.getParameter("Marca");
					
					int newQuantity = oldQuantity+quantity;
					
					//upload immagine
					Part imagePart = request.getPart("image");
			        String image = getFileName(imagePart); // Ottieni il nome dell'immagine
			        String saveDirectory = "C:/Users/giogi/git/yourPCBuddy/yourPCBuddy/src/main/WebContent/Images";
			        String imagePath = saveDirectory + File.separator + image; // Percorso per salvare l'immagine
			        String targetPath = getServletContext().getRealPath("/" +"Images"+ File.separator + image);
			        File fileToSave = new File(imagePath);
			        File targetFile = new File(targetPath);

			        InputStream fileContent = imagePart.getInputStream();
			             
					ProductBean bean = productDao.doRetrieveByKey(id);
					bean.setNotEmpty(name,description,price,newQuantity,Categoria,brand);
						if (imagePart != null && imagePart.getSize() > 0) { //se c'è una nuova immagine la aggiorni
					        if (!fileToSave.exists()) {
							Files.copy(fileContent, targetFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
							Files.copy(fileContent, fileToSave.toPath(), StandardCopyOption.REPLACE_EXISTING);
							bean.setImage(image);
					        }
					        else {
					        	// I file sono identici, non fare nulla
			                    System.out.println("Il file esistente è identico. Non si effettua l'upload.");
					        	bean.setImage(image);
					        }
						}
						else {
							bean.setImage(existingProduct.getImage());
						}

					productDao.doUpdate(bean);
					
				} else if (action.equalsIgnoreCase("insert")) {
					String name = request.getParameter("name");
					String description = request.getParameter("description");
					double price = Double.parseDouble(request.getParameter("price"));
					int quantity = Integer.parseInt(request.getParameter("quantity"));
					String Categoria = request.getParameter("Categoria");
					String brand = request.getParameter("Marca"); 
					
					//upload immagine
					Part imagePart = request.getPart("image");
			        String image = getFileName(imagePart); // Ottieni il nome dell'immagine
			        String saveDirectory = "C:/Users/giogi/git/yourPCBuddy/yourPCBuddy/src/main/WebContent/Images";
			        String imagePath = saveDirectory + File.separator + image; // Percorso per salvare l'immagine
			        String targetPath = getServletContext().getRealPath("/" +"Images"+ File.separator + image);
			        File fileToSave = new File(imagePath);
			        File targetFile = new File(targetPath);
			        InputStream fileContent = imagePart.getInputStream();
			        InputStream targetStream = imagePart.getInputStream();
			        
					ProductBean bean = new ProductBean();
					
					bean.setName(name);
					bean.setDescription(description);
					bean.setPrice(price);
					bean.setQuantity(quantity);
					bean.setCategoria(Categoria);
					bean.setImage(image);
					bean.setBrand(brand);
						if (!fileToSave.exists()) {
							Files.copy(fileContent, fileToSave.toPath(), StandardCopyOption.REPLACE_EXISTING);
							Files.copy(targetStream, targetFile.toPath(), StandardCopyOption.REPLACE_EXISTING);	
							bean.setImage(image);
						
				    }
				    else {
				    	// I file sono identici, non fare nulla
		                System.out.println("Il file esistente è identico. Non si effettua l'upload.");
				        bean.setImage(image);
				    }
					
					productDao.doSave(bean);
				}
			}			
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}

		
		
		try {
			request.removeAttribute("products");
			request.setAttribute("products", productDao.doRetrieveAll());
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/AdminProductView.jsp");
		dispatcher.forward(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

}