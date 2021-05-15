package com.seller_follow.model;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.product.model.ProductVO;



public class Seller_FollowDAO implements Seller_FollowDAO_interface {


	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/admin");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
    //關注賣家,買家可以關注賣家(新增)、可以查詢自己關注的清單(查詢)、可以取消關注的賣家(刪除)
	private static final String INSERT_STMT = 
		"INSERT INTO SELLER_FOLLOW (user_id, seller_id) VALUES (?, ?)";
	//查詢關注賣家table的所有資料
	private static final String GET_ALL_STMT = 
		"SELECT tracer_no, user_id, seller_id FROM SELLER_FOLLOW order by tracer_no";
	//查詢某一個會員的所有追蹤賣家清單
	private static final String GET_ONE_STMT = 
		"SELECT tracer_no, user_id, seller_id FROM SELLER_FOLLOW where user_id = ?";
	//買家可以取消關注的賣家
	private static final String DELETE = 
		"DELETE FROM SELLER_FOLLOW where tracer_no = ?";
	
	//查詢關注者與被關注者兩人的關注編號(與是否重複關注)
	private static final String GET_TRACER_NO = "SELECT * FROM SELLER_FOLLOW WHERE user_id = ? and seller_id = ?";

	@Override
	public void insert(Seller_FollowVO seller_followVO){

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, seller_followVO.getUser_id());
			pstmt.setString(2, seller_followVO.getSeller_id());
			
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
	public void delete(Integer tracer_no){

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setInt(1, tracer_no);

			pstmt.executeUpdate();

			// Handle any driver errors
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
	public List<Seller_FollowVO> getOneUser(String user_id){
		
		List<Seller_FollowVO> list = new ArrayList<Seller_FollowVO>();
		Seller_FollowVO seller_followVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ONE_STMT);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					
					seller_followVO = new Seller_FollowVO();
					seller_followVO.setTracer_no(rs.getInt("tracer_no"));
					seller_followVO.setUser_id(rs.getString("user_id"));
					seller_followVO.setSeller_id(rs.getString("seller_id"));
					list.add(seller_followVO); // Store the row in the list
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
	public List<Seller_FollowVO> getAll(){
		List<Seller_FollowVO> list = new ArrayList<Seller_FollowVO>();
		Seller_FollowVO seller_followVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {		
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				seller_followVO = new Seller_FollowVO();
				seller_followVO.setTracer_no(rs.getInt("tracer_no"));
				seller_followVO.setUser_id(rs.getString("user_id"));
				seller_followVO.setSeller_id(rs.getString("seller_id"));
				list.add(seller_followVO); // Store the row in the list
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
	public Seller_FollowVO getTracerNo (String user_id, String seller_id) {
		
		Seller_FollowVO seller_followVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_TRACER_NO);
			pstmt.setString(1, user_id);
			pstmt.setString(2, seller_id);
			
			rs = pstmt.executeQuery();
		
			while (rs.next()) {
				
			seller_followVO = new Seller_FollowVO();
			seller_followVO.setTracer_no(rs.getInt("tracer_no"));
			seller_followVO.setUser_id(rs.getString("user_id"));
			seller_followVO.setSeller_id(rs.getString("seller_id"));

			}
	
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		return seller_followVO;
	}
}
