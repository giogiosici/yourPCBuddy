package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;
import javax.servlet.annotation.MultipartConfig;
import javax.sql.DataSource;

@MultipartConfig
public class ProductDaoDataSource implements IProductDao {
	
	private static final String TABLE_NAME = "product";
	private DataSource ds = null;

	public ProductDaoDataSource(DataSource ds) {
		this.ds = ds;
		
		System.out.println("DataSource Product Model creation....");
	}
	
	@Override
	public synchronized void doSave(ProductBean product) throws SQLException {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + ProductDaoDataSource.TABLE_NAME
				+ " (Nome, Descrizione, Prezzo, QuantitaDisponibile, Categoria, Immagine, Marca) VALUES (?, ?, ?, ?, ?, ?, ?)";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, product.getName());
			preparedStatement.setString(2, product.getDescription());
			preparedStatement.setFloat(3, product.getPrice());
			preparedStatement.setInt(4, product.getQuantity());
			preparedStatement.setString(5, product.getCategoria());
			preparedStatement.setString(6, product.getImage());
			preparedStatement.setString(7, product.getBrand());
			
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
	public synchronized ProductBean doRetrieveByKey(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		ProductBean bean = new ProductBean();

		String selectSQL = "SELECT * FROM " + ProductDaoDataSource.TABLE_NAME + " WHERE ID = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, code);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setCode(rs.getInt("ID"));
				bean.setName(rs.getString("Nome"));
				bean.setDescription(rs.getString("Descrizione"));
				bean.setPrice(rs.getFloat("Prezzo"));
				bean.setQuantity(rs.getInt("QuantitaDisponibile"));
				bean.setCategoria(rs.getString("Categoria"));
				bean.setImage(rs.getString("Immagine"));
				bean.setBrand(rs.getString("Marca"));
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
		return bean;
	} 

	@Override
	public synchronized boolean doDelete(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + ProductDaoDataSource.TABLE_NAME + " WHERE ID = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, code);

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
	public synchronized void doUpdate(ProductBean product) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    String updateSQL = "UPDATE " + TABLE_NAME + " SET Nome = ?, Descrizione = ?, Prezzo = ?, QuantitaDisponibile = ?, Categoria = ?, Immagine = ?, Marca = ? WHERE ID = ?";

	    try {
	        connection = ds.getConnection();
	        preparedStatement = connection.prepareStatement(updateSQL);
	        preparedStatement.setString(1, product.getName());
	        preparedStatement.setString(2, product.getDescription());
	        preparedStatement.setFloat(3, product.getPrice());
	        preparedStatement.setInt(4, product.getQuantity());
	        preparedStatement.setString(5, product.getCategoria());
	        preparedStatement.setString(6, product.getImage());
	        preparedStatement.setString(7, product.getBrand());
	        preparedStatement.setInt(8, product.getCode());
	       

	        preparedStatement.executeUpdate();
	        
	        
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
	public synchronized Collection<ProductBean> doRetrieveAll() throws SQLException { //li ordina in un determinato modo
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<ProductBean> products = new LinkedList<ProductBean>();

		String selectSQL = "SELECT * FROM " + ProductDaoDataSource.TABLE_NAME;

		

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ProductBean bean = new ProductBean();

				bean.setCode(rs.getInt("ID"));
				bean.setName(rs.getString("Nome"));
				bean.setDescription(rs.getString("Descrizione"));
				bean.setPrice(rs.getFloat("Prezzo"));
				bean.setQuantity(rs.getInt("QuantitaDisponibile"));
				bean.setCategoria(rs.getString("Categoria"));
				bean.setImage(rs.getString("Immagine"));
				bean.setBrand(rs.getString("Marca"));
				products.add(bean);
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
		return products;
	}
	public synchronized Collection<ProductBean> doRetrieveLastProducts() throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<ProductBean> products = new LinkedList<ProductBean>();

		String selectSQL = "SELECT * FROM " + ProductDaoDataSource.TABLE_NAME + " ORDER BY ID DESC LIMIT 5";


		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ProductBean bean = new ProductBean();

				bean.setCode(rs.getInt("ID"));
				bean.setName(rs.getString("Nome"));
				bean.setDescription(rs.getString("Descrizione"));
				bean.setPrice(rs.getFloat("Prezzo"));
				bean.setQuantity(rs.getInt("QuantitaDisponibile"));
				bean.setCategoria(rs.getString("Categoria"));
				bean.setImage(rs.getString("Immagine"));
				bean.setBrand(rs.getString("Marca"));
				products.add(bean);
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
		return products;
	}
}