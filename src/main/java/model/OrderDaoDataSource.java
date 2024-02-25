package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import com.google.gson.Gson;
import org.json.JSONObject;


import javax.sql.DataSource;

public class OrderDaoDataSource implements OrderDao{
	private static final String TABLE_NAME = "Ordini";
	private DataSource ds = null;

	public OrderDaoDataSource(DataSource ds) {
		this.ds = ds;
	}
	
	public void OrderSave(int UserId, String Time, String cartJSON) throws SQLException {
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet resultSet = null;

	    String insertOrder = "INSERT INTO " + OrderDaoDataSource.TABLE_NAME + " (UtenteID, DataOra, CarrelloJSON) VALUES (?, ?, ?)";

	    try {
	        connection = ds.getConnection();
	        connection.setAutoCommit(false);

	        // Inserisci l'ordine con il carrello JSON
	        preparedStatement = connection.prepareStatement(insertOrder);
	        preparedStatement.setInt(1, UserId);
	        preparedStatement.setString(2, Time);
	        preparedStatement.setString(3, cartJSON);
	        preparedStatement.executeUpdate();

	        connection.commit();
	    } catch (SQLException e) {
	        if (connection != null) {
	            try {
	                connection.rollback();
	            } catch (SQLException ex) {
	                ex.printStackTrace();
	            }
	        }
	        e.printStackTrace();
	    } finally {
	        try {
	            if (resultSet != null)
	                resultSet.close();
	            if (preparedStatement != null)
	                preparedStatement.close();
	            if (connection != null)
	                connection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}


	

	@Override
	public List<Order> DoRetrieveOrders(int userId) throws SQLException {
	    List<Order> orders = new ArrayList<>();
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet resultSet = null;
	    

	    try {
	        connection = ds.getConnection();

	        // Query per recuperare gli ordini dell'utente specificato
	        String selectSQL = "SELECT * FROM Ordini WHERE UtenteID = ? ORDER BY DataOra DESC;"
	        		+ "";
	        preparedStatement = connection.prepareStatement(selectSQL);
	        preparedStatement.setInt(1, userId);

	        resultSet = preparedStatement.executeQuery();

	        while (resultSet.next()) {
	        	String jsonStr = resultSet.getString("CarrelloJSON");
	            // Leggi i dati dell'ordine dal result set e crea un oggetto Order
	        	// Crea un oggetto JSON dalla stringa
	            JSONObject jsonOrder = new JSONObject(jsonStr);

	            // Estrai il valore di totalPrice dall'oggetto JSON
	            double totalPrice = jsonOrder.getDouble("totalPrice");
	            
	            Order order = new Order();
	            order.setCode(resultSet.getInt("ID"));
	            order.setUserId(resultSet.getInt("UtenteID"));
	            order.setDateTime(resultSet.getString("DataOra"));
	            order.setTotalPrice(totalPrice);
	            
	            // Ottieni il JSON del carrello dal result set
	            String cartJSON = resultSet.getString("CarrelloJSON");

	            // Analizza il JSON del carrello e aggiungi i prodotti all'ordine
	            Gson gson = new Gson();
	            Cart cart = gson.fromJson(cartJSON, Cart.class);
	            
	            order.addProductsFromCart(cart.getProducts());

	            // Aggiungi l'ordine alla lista degli ordini
	            orders.add(order);
	        }
	    } finally {
	    	try {
	            if (resultSet != null)
	                resultSet.close();
	            if (preparedStatement != null)
	                preparedStatement.close();
	            if (connection != null)
	                connection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    return orders;
	}



	@Override
	public List<Order> DoRetrieveAllOrder() throws SQLException {
		List<Order> orders = new ArrayList<>();
	    Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    ResultSet resultSet = null;
		
	    
	    try {
	        connection = ds.getConnection();

	        // Query per recuperare gli ordini dell'utente specificato
	        String selectSQL = "SELECT * FROM " + OrderDaoDataSource.TABLE_NAME;
	    
	        preparedStatement = connection.prepareStatement(selectSQL);
	       

	        resultSet = preparedStatement.executeQuery();

	        while (resultSet.next()) {
	        	String jsonStr = resultSet.getString("CarrelloJSON");
	            // Leggi i dati dell'ordine dal result set e crea un oggetto Order
	        	// Crea un oggetto JSON dalla stringa
	            JSONObject jsonOrder = new JSONObject(jsonStr);

	            // Estrai il valore di totalPrice dall'oggetto JSON
	            double totalPrice = jsonOrder.getDouble("totalPrice");
	            
	            Order order = new Order();
	            order.setCode(resultSet.getInt("ID"));
	            order.setUserId(resultSet.getInt("UtenteID"));
	            order.setDateTime(resultSet.getString("DataOra"));
	            order.setTotalPrice(totalPrice);
	            
	            // Ottieni il JSON del carrello dal result set
	            String cartJSON = resultSet.getString("CarrelloJSON");

	            // Analizza il JSON del carrello e aggiungi i prodotti all'ordine
	            Gson gson = new Gson();
	            Cart cart = gson.fromJson(cartJSON, Cart.class);
	            
	            order.addProductsFromCart(cart.getProducts());

	            // Aggiungi l'ordine alla lista degli ordini
	            orders.add(order);
	        }
	    } finally {
	    	try {
	            if (resultSet != null)
	                resultSet.close();
	            if (preparedStatement != null)
	                preparedStatement.close();
	            if (connection != null)
	                connection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    return orders;
	}

	@Override
	public void CartDelete(int UserId) throws SQLException {//svuota il carrello dopo l'ordine
		Connection connection = null;
	    PreparedStatement preparedStatement = null;

	    

	    String deleteSQL = "DELETE FROM Carrello WHERE UtenteID = ?";

	    try {
	        connection = ds.getConnection();
	            preparedStatement = connection.prepareStatement(deleteSQL);
	            preparedStatement.setInt(1, UserId);
	            

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
}
