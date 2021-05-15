package com.live_order_detail.model;

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

public class Live_order_detailJNDIDAO implements Live_order_detailDAO_interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/admin");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO LIVE_ORDER_DETAIL (LIVE_ORDER_NO,PRODUCT_NO,PRICE,PRODUCT_NUM) VALUES (?,?,?,?)";
	private static final String GET_ALL_STMT = "SELECT * FROM LIVE_ORDER_DETAIL ORDER BY LIVE_ORDER_NO AND PRODUCT_NO";
	private static final String GET_ONE_STMT = "SELECT * FROM LIVE_ORDER_DETAIL WHERE LIVE_ORDER_NO = ? AND PRODUCT_NO = ?";
	private static final String DELETE = "DELETE FROM LIVE_ORDER_DETAIL WHERE LIVE_ORDER_NO = ? AND PRODUCT_NO=?";
	private static final String UPDATE = "UPDATE LIVE_ORDER_DETAIL SET PRICE=?,PRODUCT_NUM=? WHERE LIVE_ORDER_NO=? AND PRODUCT_NO=?";

	@Override
	public void insert(Live_order_detailVO live_order_detailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, live_order_detailVO.getLive_order_no());
			pstmt.setInt(2, live_order_detailVO.getProduct_no());
			pstmt.setInt(3, live_order_detailVO.getPrice());
			pstmt.setInt(4, live_order_detailVO.getProduct_num());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public void update(Live_order_detailVO live_order_detailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, live_order_detailVO.getPrice());
			pstmt.setInt(2, live_order_detailVO.getProduct_num());
			pstmt.setInt(3, live_order_detailVO.getLive_order_no());
			pstmt.setInt(4, live_order_detailVO.getProduct_no());

			pstmt.executeUpdate();

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
	public void delete(Integer live_order_no, Integer product_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, live_order_no);
			pstmt.setInt(2, product_no);

			pstmt.executeUpdate();

			// Handle any driver errors

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
	public Live_order_detailVO findByPrimaryKey(Integer live_order_no, Integer product_no) {
		Live_order_detailVO live_order_detailVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, live_order_no);
			pstmt.setInt(2, product_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				live_order_detailVO = new Live_order_detailVO();
				live_order_detailVO.setLive_order_no(rs.getInt("live_order_no"));
				live_order_detailVO.setProduct_no(rs.getInt("product_no"));
				live_order_detailVO.setPrice(rs.getInt("price"));
				live_order_detailVO.setProduct_num(rs.getInt("product_num"));

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

		return live_order_detailVO;
	}

	@Override
	public List<Live_order_detailVO> getAll() {
		List<Live_order_detailVO> list = new ArrayList<Live_order_detailVO>();
		Live_order_detailVO live_order_detailVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				live_order_detailVO = new Live_order_detailVO();
				live_order_detailVO.setLive_order_no(rs.getInt("live_order_no"));
				live_order_detailVO.setProduct_no(rs.getInt("product_no"));
				live_order_detailVO.setPrice(rs.getInt("price"));
				live_order_detailVO.setProduct_num(rs.getInt("product_num"));
				list.add(live_order_detailVO); // Store the row in the list
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
	public void insert2(Live_order_detailVO live_order_detailVO, Connection con) {
		PreparedStatement pstmt = null;

		try {

     		pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, live_order_detailVO.getLive_order_no());
			pstmt.setInt(2, live_order_detailVO.getProduct_no());
			pstmt.setInt(3, live_order_detailVO.getPrice());
			pstmt.setInt(4, live_order_detailVO.getProduct_num());

			Statement stmt=	con.createStatement();
			//stmt.executeUpdate("set auto_increment_offset=7001;"); //自增主鍵-初始值
			stmt.executeUpdate("set auto_increment_increment=1;");   //自增主鍵-遞增
			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-emp");
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
