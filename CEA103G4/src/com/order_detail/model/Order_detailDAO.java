package com.order_detail.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import datasource.dataSourceManager;

public class Order_detailDAO implements Order_detailDAO_interface{

	//
	private static DataSource ds = dataSourceManager.get();
	
	private static final String INSERT_STMT = 
			"INSERT INTO `ORDER_DETAIL` (`ORDER_NO`,`ORDER_PRICE`,`PRODUCT_NO`,`PRODUCT_NUM`) VALUES (?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT `ORDER_NO`,`PRODUCT_NO`,`PRODUCT_NUM`,`ORDER_PRICE` FROM `ORDER_DETAIL` ORDER BY `ORDER_NO`";
	private static final String GET_ALL_BYORDER_NO = 
			"SELECT *  FROM  ORDER_DETAIL  WHERE  ORDER_NO  = ?";
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
		public void delete(Integer order_no) {
			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(DELETE);

				pstmt.setInt(1, order_no);

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
		public List<Order_detailVO> findByPrimaryKey(Integer order_no) {
			List<Order_detailVO> list = new ArrayList<Order_detailVO>();
			Order_detailVO order_detailVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ONE_STMT);
				pstmt.setInt(1, order_no);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					order_detailVO = new Order_detailVO();
					order_detailVO.setOrder_no(rs.getInt("order_no"));
					order_detailVO.setOrder_price(rs.getInt("order_price"));
					order_detailVO.setProduct_no(rs.getInt("product_no"));
					order_detailVO.setProduct_num(rs.getInt("product_num"));
					list.add(order_detailVO);
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
			return list;
		}

		@Override
		public List<Order_detailVO> getAllByNo(Integer order_no) {
			List<Order_detailVO> list = new ArrayList<Order_detailVO>();
			Order_detailVO order_detailVO = null;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_BYORDER_NO);
				pstmt.setInt(1, order_no);
				rs = pstmt.executeQuery();
				System.out.println("RS:"+rs.next());
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
		public void insert2(Order_detailVO order_detailVO, Connection con) {
			PreparedStatement pstmt = null;
			
			try {
				pstmt = con.prepareStatement(INSERT_STMT);
				
				pstmt.setInt(1, order_detailVO.getOrder_no());
				pstmt.setInt(2, order_detailVO.getOrder_price());
				pstmt.setInt(3, order_detailVO.getProduct_no());
				pstmt.setInt(4, order_detailVO.getProduct_num());
				
				pstmt.executeUpdate();
			} catch (SQLException se) {
				se.printStackTrace();
				if (con != null) {
					try {
						// 3●設定於當有exception發生時之catch區塊內
						System.err.print("Transaction is being ");
						System.err.println("rolled back-由-order_detail");
						con.rollback();
					} catch (SQLException excep) {
						throw new RuntimeException("rollback error occured. "
								+ excep.getMessage());
					}
				}
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
			}
			
		}
	}

