package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

public class UserDaoDataSource implements UserDao{
	private static final String TABLE_NAME = "Utenti";
	private DataSource ds = null;

	public UserDaoDataSource(DataSource ds) {
		this.ds = ds;
	}

	@Override
	public User RetrieveUserData(int UID) throws SQLException {
		Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    User user = new User();
	    
	    String selectSQL = "SELECT * FROM " + UserDaoDataSource.TABLE_NAME + " WHERE ID = ?";
	    
	    try {
	        connection = ds.getConnection();
	        connection.setAutoCommit(false); // Disabilita l'autocommit
	        
	        
	        preparedStatement = connection.prepareStatement(selectSQL);
	        preparedStatement.setInt(1, UID);
	        
	        ResultSet rs=preparedStatement.executeQuery();
	        while (rs.next()) {
				user.setNome(rs.getString("Nome"));
				user.setCognome(rs.getString("Cognome"));
				user.setUsername(rs.getString("Username"));
				user.setEmail(rs.getString("Email"));
				user.setIndirizzo(rs.getString("Indirizzo"));
				
			}
	    }
	    catch (SQLException e) {
	    	e.printStackTrace();
	    }
	    finally {
	        try {
	            if (preparedStatement != null)
	                preparedStatement.close();
	            if (connection != null)
	                connection.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return user;
	}

	@Override
	public void ChangeAddress(int UID, String Address) throws SQLException {
		Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    
	    
	    String selectSQL = "SELECT Indirizzo FROM " + UserDaoDataSource.TABLE_NAME + " WHERE ID = ?";
	    
	    String insertSQL = "INSERT INTO " + UserDaoDataSource.TABLE_NAME + " (Indirizzo) VALUES (?)";

	    // Query per l'aggiornamento dell'indirizzo
	    String updateSQL = "UPDATE " + UserDaoDataSource.TABLE_NAME  + " SET Indirizzo = ? WHERE ID = ?";
	    
	    try {
	        connection = ds.getConnection();
	        connection.setAutoCommit(false); // Disabilita l'autocommit

	        // Verifica se l'indirizzo è già inserito
	        preparedStatement = connection.prepareStatement(selectSQL);
	        preparedStatement.setInt(1, UID);
	        ResultSet resultSet = preparedStatement.executeQuery();

	        if (resultSet.next()) {
	        	
	            // L'indirizzo è gia presente, quindi viene cambiato
	            preparedStatement.close(); // Chiudi la query precedente

	            preparedStatement = connection.prepareStatement(updateSQL);
	            preparedStatement.setString(1, Address);
	            preparedStatement.setInt(2, UID);
	            preparedStatement.executeUpdate();
	        } else {
	        	
	            // L'indirizzo non è impostato, quindi inseriscilo
	            preparedStatement.close(); // Chiudi la query precedente

	            preparedStatement = connection.prepareStatement(insertSQL);
	            preparedStatement.setString(1, Address);
	            preparedStatement.executeUpdate();
	            
	        }
	        
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

	@Override
	public void ChangeEmail(int UID, String email) throws SQLException {
		Connection connection = null;
	    PreparedStatement preparedStatement = null;
	    
	    String updateSQL = "UPDATE " + UserDaoDataSource.TABLE_NAME  + " SET Email = ? WHERE ID = ?";
	    try {
	        connection = ds.getConnection();
	        connection.setAutoCommit(false); // Disabilita l'autocommit

	            preparedStatement = connection.prepareStatement(updateSQL);
	            preparedStatement.setString(1, email);
	            preparedStatement.setInt(2, UID);
	            preparedStatement.executeUpdate();
	        
	    }catch (SQLException e) {
	    	e.printStackTrace();
	    }
	    
	}
	
	public boolean isUsernameExists(String username) throws SQLException {
		Connection connection = null;
		
		connection = ds.getConnection();
        connection.setAutoCommit(false); // Disabilita l'autocommit

        // Verifica se l'username è già inserito
        String query = "SELECT * FROM Utenti WHERE Username = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setString(1, username);
        ResultSet resultSet = statement.executeQuery();
        return resultSet.next(); // Restituisce true se il nome utente esiste già nel database, altrimenti false 
	}
    
	public boolean isEmailExists(String email) throws SQLException {
    	Connection connection = null;
    	connection = ds.getConnection();
        connection.setAutoCommit(false); // Disabilita l'autocommit
        String query = "SELECT * FROM Utenti WHERE Email = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setString(1, email);
        ResultSet resultSet = statement.executeQuery();
        return resultSet.next(); // Restituisce true se l'email esiste già nel database, altrimenti false 
	}
	
	public boolean doSaveUser(User user) throws SQLException{
		Connection connection = null;
		
		connection = ds.getConnection();
		
		String insertQuery = "INSERT INTO Utenti (Nome, Cognome, Username, Email, Password) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement statement = connection.prepareStatement(insertQuery);
        statement.setString(1, user.getNome());
        statement.setString(2, user.getCognome());
        statement.setString(3, user.getUsername());
        statement.setString(4, user.getEmail());
        statement.setString(5, user.getPassword());
        statement.executeUpdate();
        connection.commit();
		return true;
		
	}
}
