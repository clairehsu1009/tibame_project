package com.auth.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;




public class AuthDAO implements AuthDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/admin");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private static final String INSERT_STMT = "insert into AUTH (FUNNO,EMPNO,AUTH_NO) values (?, ?, ?)";
	private static final String UPDATE_STMT = "update AUTH set AUTH_NO=? where EMPNO=? and FUNNO=?";
	private static final String DELETE_STMT = "delete from AUTH where EMPNO=? and FUNNO=?";
	private static final String GET_ONE_BY_EMPNO_STMT = "select FUNNO,EMPNO,AUTH_NO from AUTH where EMPNO = ? ";
	private static final String GET_ONE_BY_FUNNO_STMT = "select FUNNO,EMPNO,AUTH_NO from AUTH where FUNNO = ? ";
	private static final String GET_ALL_BY_EMPNO_STMT = "select FUNNO,EMPNO,AUTH_NO from AUTH order by EMPNO";
	private static final String GET_AUTH_ON = "SELECT AUTH_NO,EMPNO,FUNNO FROM AUTH WHERE EMPNO=? ";

	
	@Override
	public void insert(AuthVO authVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, authVO.getFunno());
			pstmt.setInt(2, authVO.getEmpno());
			pstmt.setInt(3, authVO.getAuth_no());

			

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
	public void update(AuthVO authVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);
			pstmt.setInt(1, authVO.getAuth_no());
//System.out.println("DAO auth_no= "+ authVO.getAuth_no());
			pstmt.setInt(2, authVO.getEmpno());	
//System.out.println("DAO empno= "+ authVO.getEmpno());
			pstmt.setInt(3, authVO.getFunno());
//System.out.println("DAO funno= "+ authVO.getFunno());	

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
	public void delete(Integer empno, Integer funno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_STMT);

			pstmt.setInt(1, empno);
			pstmt.setInt(2, funno);
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
	public AuthVO findAuthAllValues(AuthVO authVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_BY_EMPNO_STMT);

			pstmt.setInt(1, authVO.getEmpno());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// authorityVo 也稱為 Domain objects
				authVO = new AuthVO();
				authVO.setFunno(rs.getInt("FUNNO"));
				authVO.setEmpno(rs.getInt("EMPNO"));
				authVO.setAuth_no(rs.getInt("AUTH_NO"));
				
			}
		}  catch (SQLException se) {
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
		return authVO;
	}
	@Override
	public Set<AuthVO> findAuthByFunno(Integer funno) {
		Set<AuthVO> set = new LinkedHashSet<AuthVO>();
		AuthVO authVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_BY_FUNNO_STMT);
			pstmt.setInt(1, funno);	

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				// authorityVo 也稱為 Domain objects
				authVO = new AuthVO();
				authVO.setFunno(rs.getInt("FUNNO"));
				authVO.setEmpno(rs.getInt("EMPNO"));
				authVO.setAuth_no(rs.getInt("AUTH_NO"));
				set.add(authVO);
			}
		}  catch (SQLException se) {
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
		return set;
	}
	@Override
	public List<AuthVO> getAuth(Integer empno){
		List<AuthVO> list = new ArrayList<AuthVO>();
		AuthVO authVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_AUTH_ON);

			pstmt.setInt(1, empno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// authorityVo 也稱為 Domain objects
				authVO = new AuthVO();
				authVO.setAuth_no(rs.getInt("AUTH_NO"));
				authVO.setEmpno(rs.getInt("EMPNO"));
				authVO.setFunno(rs.getInt("FUNNO"));
				list.add(authVO);
				
			}
		}  catch (SQLException se) {
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
	public List<AuthVO> getAll() {
		List<AuthVO> list = new ArrayList<AuthVO>();
		AuthVO authVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_BY_EMPNO_STMT);
			rs = pstmt.executeQuery();
			

			while (rs.next()) {
				// authorityVO 也稱為 Domain objects
				authVO = new AuthVO();
				authVO.setFunno(rs.getInt("FUNNO"));
				authVO.setEmpno(rs.getInt("EMPNO"));
				authVO.setAuth_no(rs.getInt("AUTH_NO"));
				
				list.add(authVO); // Store the row in the list
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
