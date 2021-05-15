package com.order_detail.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class Order_detailDAO implements Order_detailDAO_interface{

	//
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/admin");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = 
			"INSERT INTO `ORDER_DETAIL` (`ORDER_NO`,`ORDER_PRICE`,`PRODUCT_NO`,`PRODUCT_NUM`) VALUES (?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT `ORDER_NO`,`PRODUCT_NO`,`PRODUCT_NUM`,`ORDER_PRICE` FROM `ORDER_DETAIL` ORDER BY `ORDER_NO`";
	private static final String GET_ONE_STMT = 
			"SELECT `ORDER_NO`,`PRODUCT_NO`,`PRODUCT_NUM`,`ORDER_PRICE` FROM `ORDER_DETAIL` WHERE `ORDER_NO` = ?";
	private static final String DELETE = 
			"DELETE FROM `ORDER_DETAIL` WHERE `ORDER_NO` = ?";
	private static final String UPDATE = 
			"UPDATE `ORDER_DETAIL` SET `PRODUCT_NO`=?, `PRODUCT_NUM`=?, `ORDER_PRICE`=? WHERE `ORDER_NO` = ?";
	
	@Override
	public void insert(Order_detailVO order_detailVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setInt(1, order_detailVO.getOrder_no());
			pstmt.setInt(2, order_detailVO.getOrder_price());
			pstmt.setInt(3, order_detailVO.getProduct_no());
			pstmt.setInt(4, order_detailVO.getProduct_num());

			pstmt.executeUpdate();
			con.commit();
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources		
			} finally {
				try {
					con.setAutoCommit(true);
				} catch (SQLException e1) {
					e1.printStackTrace();
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
	}
		@Override
		public void update(Order_detailVO order_detailVO) {
			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE);

				pstmt.setInt(1, order_detailVO.getOrder_no());
				pstmt.setInt(2, order_detailVO.getOrder_price());
				pstmt.setInt(3, order_detailVO.getProduct_no());
				pstmt.setInt(4, order_detailVO.getProduct_num());

				pstmt.executeUpdate();

				// Handle any SQL errors
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
				// Clean up JDBC resources
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

		@Override
		public void delete(Integer notice_no) {
			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(DELETE);

				pstmt.setInt(1, notice_no);

				pstmt.executeUpdate();

				// Handle any SQL errors
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. " 
						+ se.getMessage());
				// Clean up JDBC resources
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

		@Override
		public Order_detailVO findByPrimaryKey(Integer notice_no) {

			Order_detailVO order_detailVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ONE_STMT);

				pstmt.setInt(1, notice_no);

				rs = pstmt.executeQuery();

				while (rs.next()) {
					//
					order_detailVO = new Order_detailVO();
					order_detailVO.setOrder_no(rs.getInt("order_no"));
					order_detailVO.setOrder_price(rs.getInt("order_price"));
					order_detailVO.setProduct_no(rs.getInt("product_no"));
					order_detailVO.setProduct_num(rs.getInt("product_num"));
				}
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. " + se.getMessage());
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
			return order_detailVO;
		}

		@Override
		public List<Order_detailVO> getAll() {
			List<Order_detailVO> list = new ArrayList<Order_detailVO>();
			Order_detailVO order_detailVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					//
					order_detailVO = new Order_detailVO();
					order_detailVO.setOrder_no(rs.getInt("order_no"));
					order_detailVO.setOrder_price(rs.getInt("order_price"));
					order_detailVO.setProduct_no(rs.getInt("product_no"));
					order_detailVO.setProduct_num(rs.getInt("product_num"));
					list.add(order_detailVO); // Store the row in the list
				}

				// Handle any driver errors
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

