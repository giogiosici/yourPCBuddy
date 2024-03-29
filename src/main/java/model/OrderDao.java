package model;

import java.sql.SQLException;
import java.util.*;

public interface OrderDao {
	
	public void OrderSave(int UserId,String Time, String cartJSON) throws SQLException;

	public void CartDelete(int UserId) throws SQLException;
	
	public List<Order> DoRetrieveOrders(int UID) throws SQLException;
	
	public List<Order> DoRetrieveAllOrder() throws SQLException;
	
}
