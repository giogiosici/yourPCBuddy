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
	public void cartSave(/*double totalPrice, */int userId, int productId) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + CartDaoDataSource.TABLE_NAME
				+ " (ProdottoID, UtenteID) VALUES (?, ?)"; //ci vuole prezzo totale

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			//preparedStatement.setDouble(1,totalPrice);
			preparedStatement.setInt(1, productId);
            preparedStatement.setInt(2, userId);
            preparedStatement.executeUpdate();

			//connection.commit();
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
	public boolean cartDelete(int UID, int PID) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + CartDaoDataSource.TABLE_NAME + " WHERE UtenteID = ? AND ProdottoID = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, UID);
			preparedStatement.setInt(2,PID);

			result = preparedStatement.executeUpdate();
			//connection.commit();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return (result != 0);
	}

	@Override
	public Collection<ProductBean> doRetrieveAll(String order) throws SQLException {
		// TODO Auto-generated method stub
		return null;
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
		
			String PIDinfo = "SELECT * FROM product WHERE ID = ?";
			productStatement = connection.prepareStatement(PIDinfo);

			for (int ProductID : PID) {
			    productStatement.setInt(1, ProductID);
			    ResultSet rsProducts = productStatement.executeQuery();
			    
			    while (rsProducts.next()) {
			        ProductBean bean = new ProductBean();

			        bean.setCode(rsProducts.getInt("ID"));
			        bean.setName(rsProducts.getString("Nome"));
			        bean.setPrice(rsProducts.getFloat("Prezzo"));
			        bean.setImage(rsProducts.getString("Immagine"));
			        products.add(bean);
			    }
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
		for (ProductBean product : products) {
		    System.out.println("ID: " + product.getCode());
		    System.out.println("Nome: " + product.getName());
		    System.out.println("Prezzo: " + product.getPrice());
		    System.out.println("Immagine: " + product.getImage());
		    // Aggiungi ulteriori attributi se necessario
		    System.out.println("-----------------------------");
		}
		return products;
	}
}

