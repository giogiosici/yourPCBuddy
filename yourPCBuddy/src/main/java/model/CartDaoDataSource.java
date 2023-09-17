package model;

import java.sql.*;
import java.util.*;
import javax.sql.DataSource;


public class CartDaoDataSource  implements CartDao{
	private static final String TABLE_NAME = "Carrello";
	private DataSource ds = null;

	public CartDaoDataSource(DataSource ds) {
		this.ds = ds;
	}

	@Override
	public void cartSave(int userId, int productId, int quantity) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    // Query per verificare se il prodotto è già nel carrello
	    String selectSQL = "SELECT * FROM " + CartDaoDataSource.TABLE_NAME
	            + " WHERE ProdottoID = ? AND UtenteID = ?";

	    // Query per l'inserimento di un nuovo record nel carrello
	    String insertSQL = "INSERT INTO " + CartDaoDataSource.TABLE_NAME
	            + " (ProdottoID, UtenteID, QuantitaProdotto) VALUES (?, ?, ?)";

	    // Query per l'aggiornamento della quantità del prodotto esistente nel carrello
	    String updateSQL = "UPDATE " + CartDaoDataSource.TABLE_NAME
	            + " SET QuantitaProdotto = QuantitaProdotto + ? WHERE ProdottoID = ? AND UtenteID = ?";

	    try {
	        connection = ds.getConnection();
	        connection.setAutoCommit(false); // Disabilita l'autocommit

	        // Verifica se il prodotto è già nel carrello
	        preparedStatement = connection.prepareStatement(selectSQL);
	        preparedStatement.setInt(1, productId);
	        preparedStatement.setInt(2, userId);
	        ResultSet resultSet = preparedStatement.executeQuery();

	        if (resultSet.next()) {
	            // Il prodotto è già nel carrello, quindi aggiorna la quantità
	            preparedStatement.close(); // Chiudi la query precedente

	            preparedStatement = connection.prepareStatement(updateSQL);
	            preparedStatement.setInt(1, quantity);
	            System.out.println("quantita update cartDataSource " + quantity);
	            preparedStatement.setInt(2, productId);
	            preparedStatement.setInt(3, userId);
	            preparedStatement.executeUpdate();
	        } else {
	        	System.out.println("else cartDaoDataSource");
	            // Il prodotto non è nel carrello, quindi inseriscilo
	            preparedStatement.close(); // Chiudi la query precedente

	            preparedStatement = connection.prepareStatement(insertSQL);
	            preparedStatement.setInt(1, productId);
	            preparedStatement.setInt(2, userId);
	            preparedStatement.setInt(3, quantity);
	            preparedStatement.executeUpdate();
	            System.out.println("fine else " + quantity);
	        }
	        System.out.println("fine try cartDaoDataSource " + quantity);
	        connection.commit(); // Esegui il commit delle operazioni nel database
	    } catch (SQLException e) {
	        if (connection != null) {
	            try {
	                connection.rollback(); // Esegui il rollback in caso di errore
	                
	            } catch (SQLException ex) {
	                ex.printStackTrace();
	            }
	        }
	        e.printStackTrace();
	    } finally {
	        try {
	            if (preparedStatement != null)
	                preparedStatement.close();
	            if (connection != null)
	                connection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}



	public void cartDelete(int UID, int PID, int quantity) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    

	    String deleteSQL = "DELETE FROM " + CartDaoDataSource.TABLE_NAME + " WHERE UtenteID = ? AND ProdottoID = ?";

	    String updateSQL = "UPDATE " + CartDaoDataSource.TABLE_NAME
	            + " SET QuantitaProdotto = ? WHERE ProdottoID = ? AND UtenteID = ?";

	    try {
	        connection = ds.getConnection();
	        if (quantity > 1) {
	            // Se la quantità è maggiore di 1, decrementa la quantità nel database di 1 unità
	            preparedStatement = connection.prepareStatement(updateSQL);
	            preparedStatement.setInt(1, quantity - 1); // Decrementa la quantità di 1
	            preparedStatement.setInt(2, PID);
	            preparedStatement.setInt(3, UID);
	            preparedStatement.executeUpdate();
	        } else {
	            // Se la quantità è 1 o inferiore, elimina il prodotto dal carrello
	            preparedStatement = connection.prepareStatement(deleteSQL);
	            preparedStatement.setInt(1, UID);
	            preparedStatement.setInt(2, PID);

	            preparedStatement.executeUpdate();
	            // connection.commit();
	        }
	    } finally {
	        try {
	            if (preparedStatement != null)
	                preparedStatement.close();
	        } finally {
	            if (connection != null)
	                connection.close();
	        }
	    }
	}

	public void cartDelAll(int UID, int PID) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    

	    String deleteSQL = "DELETE FROM " + CartDaoDataSource.TABLE_NAME + " WHERE UtenteID = ? AND ProdottoID = ?";

	    try {
	        connection = ds.getConnection();
	            preparedStatement = connection.prepareStatement(deleteSQL);
	            preparedStatement.setInt(1, UID);
	            preparedStatement.setInt(2, PID);

	            preparedStatement.executeUpdate();
	            // connection.commit();
	        
	    } finally {
	        try {
	            if (preparedStatement != null)
	                preparedStatement.close();
	        } finally {
	            if (connection != null)
	                connection.close();
	        }
	    }
	}

	@Override
	public synchronized Collection<ProductBean> doRetrieveProducts(int UID) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		PreparedStatement productStatement=null;
		List<Integer> PID = new ArrayList<>();
		
		
		Collection<ProductBean> products = new LinkedList<ProductBean>();

		String selectPID = "SELECT ProdottoID FROM " + CartDaoDataSource.TABLE_NAME +" WHERE UtenteID = ?";


		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectPID);
			preparedStatement.setInt(1,UID);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				int ProductID = rs.getInt("ProdottoID");
				PID.add(ProductID);
			}
		
			String PIDinfo = "SELECT p.*, c.QuantitaProdotto FROM product p JOIN Carrello c ON p.ID = c.ProdottoID WHERE c.UtenteID = ?";

			productStatement = connection.prepareStatement(PIDinfo);
			productStatement.setInt(1, UID);

			ResultSet rsProducts = productStatement.executeQuery();

			while (rsProducts.next()) {
			    ProductBean bean = new ProductBean();

			    bean.setCode(rsProducts.getInt("ID"));
			    bean.setName(rsProducts.getString("Nome"));
			    bean.setPrice(rsProducts.getFloat("Prezzo"));
			    bean.setImage(rsProducts.getString("Immagine"));
			    
			    // Popola il campo quantity
			    bean.setQuantity(rsProducts.getInt("QuantitaProdotto"));

			    products.add(bean);
			}

			
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
				if (productStatement != null)
					productStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		
		return products;
	}

	@Override
	public Collection<ProductBean> doRetrieveAll(String order) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
}

