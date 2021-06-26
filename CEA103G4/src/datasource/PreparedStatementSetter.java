package datasource;

import java.sql.PreparedStatement;
import java.sql.SQLException;



	public interface PreparedStatementSetter {
		public void configure(PreparedStatement preparedStatement) throws SQLException;
	}
	

