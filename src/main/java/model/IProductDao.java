package model;

import java.sql.SQLException;
import java.util.Collection;
import java.util.List;

public interface IProductDao {
	
	public void doSave(ProductBean product) throws SQLException;

	public boolean doDelete(int code) throws SQLException;
	
	public void doUpdate(ProductBean product) throws SQLException;

	public ProductBean doRetrieveByKey(int code) throws SQLException;
	
	public Collection<ProductBean> doRetrieveAll() throws SQLException;
	
	public Collection<ProductBean> doRetrieveLastProducts() throws SQLException;
	
	public Collection<ProductBean> doRetrieveConsigliati(ProductBean product) throws SQLException;


}



