package model;

import java.sql.SQLException;

public interface UserDao {
	public User RetrieveUserData(int UID) throws SQLException;
	
	public void ChangeAddress(int UID, String stato, String citta,
			String provincia, String via, String numeroCivico, String cap) throws SQLException;
	
	public void ChangeEmail(int UID, String Email) throws SQLException;
	
	public boolean isEmailExists(String email) throws SQLException;
	
	public boolean isUsernameExists(String username) throws SQLException;
	
	public boolean doSaveUser(User user)throws SQLException;
}
