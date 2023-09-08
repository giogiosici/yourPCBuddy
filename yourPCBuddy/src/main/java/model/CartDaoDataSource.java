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
	public void cartSave(int userId, int productId) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + CartDaoDataSource.TABLE_NAME
				+ " (ProdottoID, UtenteID) VALUES (?, ?)"; //ci vuole prezzo totale

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
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
	public ProductBean doRetrieveByKey(int code) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Collection<ProductBean> doRetrieveAll(String order) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Collection<ProductBean> doRetrieveProducts() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
}
