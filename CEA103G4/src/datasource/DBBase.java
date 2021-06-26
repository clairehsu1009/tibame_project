package datasource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.product.model.ProductVO;


public class DBBase {
	
	public static void execute(String sql, PreparedStatementSetter preparedStatementSetter){

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = dataSourceManager.get().getConnection();
			pstmt = con.prepareStatement(sql);

			preparedStatementSetter.configure(pstmt);
			
			pstmt.executeUpdate();
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}
	


		public static Object getList(String sql, PreparedStatementSetter preparedStatementSetter){
		
		List<ProductVO> list = new ArrayList<ProductVO>();	
		ProductVO productVO = null;	
			
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = dataSourceManager.get().getConnection();
			pstmt = con.prepareStatement(sql);
			preparedStatementSetter.configure(pstmt);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				productVO = new ProductVO();
				productVO.setProduct_no(rs.getInt("product_no"));
				productVO.setProduct_name(rs.getString("product_name"));
				productVO.setProduct_info(rs.getString("product_info"));
				productVO.setProduct_price(rs.getInt("product_price"));
				productVO.setProduct_quantity(rs.getInt("product_quantity"));
				productVO.setProduct_remaining(rs.getInt("product_remaining"));
				productVO.setProduct_sold(rs.getInt("product_sold"));
				productVO.setProduct_state(rs.getInt("product_state"));
				productVO.setUser_id(rs.getString("user_id"));
				productVO.setPdtype_no(rs.getInt("pdtype_no"));
				productVO.setStart_price(rs.getInt("start_price"));
				productVO.setLive_no(rs.getInt("live_no"));
				list.add(productVO); // Store the row in the list
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
}
