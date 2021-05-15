package com.customer_service.model;

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



public class CustomerDAO implements CustomerDAO_interface{
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CEA103_G4");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = 
			"INSERT INTO CUSTOMER_SERVICE (USER_ID,CONTENT,CASE_STATE,EMPNO,EMP_RESPONSE,CASE_TIME ) VALUES ( ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT CASE_NO,USER_ID,CONTENT,CASE_STATE,EMPNO,EMP_RESPONSE,CASE_TIME FROM CUSTOMER_SERVICE ORDER BY CASE_NO";
	private static final String GET_ONE_STMT = 
			"SELECT CASE_NO,USER_ID,CONTENT,CASE_STATE,EMPNO,EMP_RESPONSE,CASE_TIME FROM CUSTOMER_SERVICE WHERE CASE_NO = ?";
	private static final String DELETE = 
			"DELETE FROM CUSTOMER_SERVICE WHERE CASE_NO = ?";
	private static final String UPDATE = 
			"UPDATE CUSTOMER_SERVICE SET USER_ID=?, CONTENT=?, CASE_STATE=?, EMPNO=?, EMP_RESPONSE=?, CASE_TIME=? WHERE CASE_NO = ?";
	
	@Override
	public void insert(CustomerSerVO customerSerVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
		
			pstmt.setString(1, customerSerVO.getUserid());
			pstmt.setString(2, customerSerVO.getContent());
			pstmt.setInt(3, customerSerVO.getCaseState());
			pstmt.setInt(4, customerSerVO.getEmpno());
			pstmt.setString(5, customerSerVO.getEmpResponse());
			pstmt.setDate(6, customerSerVO.getCaseTime());
		
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("database發生錯誤." + se.getMessage());
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
	public void update(CustomerSerVO customerSerVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
				
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, customerSerVO.getUserid());
			pstmt.setString(2, customerSerVO.getContent());
			pstmt.setInt(3, customerSerVO.getCaseState());
			pstmt.setInt(4, customerSerVO.getEmpno());
			pstmt.setString(5, customerSerVO.getEmpResponse());
			pstmt.setDate(6, customerSerVO.getCaseTime());
		} catch (SQLException se) {
			throw new RuntimeException("database發生錯誤." + se.getMessage());
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
	public void delete(Integer caseno) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, caseno);

			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("database發生錯誤." + se.getMessage());
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
	public CustomerSerVO findByPrimaryKey(Integer caseno) {
		CustomerSerVO customerSerVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, caseno);

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				customerSerVO = new CustomerSerVO();
				customerSerVO.setCaseno(rs.getInt("caseno"));
				customerSerVO.setUserid(rs.getString("userid"));
				customerSerVO.setContent(rs.getString("content"));
				customerSerVO.setCaseState(rs.getInt("caseState"));
				customerSerVO.setEmpno(rs.getInt("empno"));
				customerSerVO.setEmpResponse(rs.getString("empResponse"));
				customerSerVO.setCaseTime(rs.getDate("caseTime"));
				
			}
			
		} catch (SQLException se) {
			throw new RuntimeException("database發生錯誤."
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
		return customerSerVO;
		
	}

	@Override
	public List<CustomerSerVO> getAll() {
		List <CustomerSerVO> list = new ArrayList<CustomerSerVO>();
		CustomerSerVO customerSerVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				customerSerVO = new CustomerSerVO();
				customerSerVO.setCaseno(rs.getInt("case_no"));
				customerSerVO.setUserid(rs.getString("user_id"));
				customerSerVO.setContent(rs.getString("content"));
				customerSerVO.setCaseState(rs.getInt("case_State"));
				customerSerVO.setEmpno(rs.getInt("empno"));
				customerSerVO.setEmpResponse(rs.getString("emp_Response"));
				customerSerVO.setCaseTime(rs.getDate("case_Time"));
				list.add(customerSerVO);
			}
		} catch (SQLException se) {
			throw new RuntimeException("database發生錯誤."
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
