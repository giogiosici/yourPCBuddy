package model;
import java.sql.SQLException;
import java.util.Collection;
import java.util.List;

public interface CartDao {
	
	public void cartSave(int userId, int productId) throws SQLException;

	public boolean cartDelete(int UID, int PID) throws SQLException;

	public ProductBean doRetrieveByKey(int code) throws SQLException;
	
	public Collection<ProductBean> doRetrieveAll(String order) throws SQLException;
	
	public Collection<ProductBean> doRetrieveProducts() throws SQLException;

}
