package com.qa.model;

import java.util.*;
import java.sql.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class QaDAO implements QaDAO_interface {
	
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
			"INSERT INTO `QA` (`EMPNO`,`QA_DATE`,`QA_TYPE`,`QUESTION`,`ANSWER`) VALUES (?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM `QA` ORDER BY `QA_TYPE`";
	private static final String GET_ONE_STMT = 
			"SELECT `QA_NO`,`EMPNO`,`QA_DATE`,`QA_TYPE`,`QUESTION`,`ANSWER` FROM QA WHERE `QA_NO` = ?";
	private static final String DELETE = 
			"DELETE FROM QA where QA_NO = ?";
	private static final String UPDATE = 
			"UPDATE `QA` SET `EMPNO`=?, `QA_DATE`=?, `QA_TYPE`=?, `QUESTION`=?, `ANSWER`=? WHERE `QA_NO` = ?";


	@Override
	public void insert(QaVO qaVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, qaVO.getEmpno());
			pstmt.setDate(2, qaVO.getQa_date());
			pstmt.setInt(3, qaVO.getQa_type());
			pstmt.setString(4, qaVO.getQuestion());
			pstmt.setString(5, qaVO.getAnswer());
			

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
	public void update(QaVO qaVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, qaVO.getEmpno());
			pstmt.setDate(2, qaVO.getQa_date());
			pstmt.setInt(3, qaVO.getQa_type());
			pstmt.setString(4, qaVO.getQuestion());
			pstmt.setString(5, qaVO.getAnswer());
			pstmt.setInt(6, qaVO.getQa_no());

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
	public void delete(Integer qa_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, qa_no);

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
	public QaVO findByPrimaryKey(Integer qa_no) {
		QaVO qaVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, qa_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// qaVo 也稱為 Domain objects
				qaVO = new QaVO();
				
				qaVO.setQa_no(rs.getInt("qa_no"));
				qaVO.setEmpno(rs.getInt("empno"));
				qaVO.setQa_date(rs.getDate("qa_date"));
				qaVO.setQa_type(rs.getInt("qa_type"));
				qaVO.setQuestion(rs.getString("question"));
				qaVO.setAnswer(rs.getString("answer"));
				
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
		return qaVO;
	}

	@Override
	public List<QaVO> getAll() {
		List<QaVO> list = new ArrayList<QaVO>();
		QaVO qaVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// qaVO 也稱為 Domain objects
				qaVO = new QaVO();
				
				qaVO.setQa_no(rs.getInt("qa_no"));
				qaVO.setEmpno(rs.getInt("empno"));
				qaVO.setQa_date(rs.getDate("qa_date"));
				qaVO.setQa_type(rs.getInt("qa_type"));
				qaVO.setQuestion(rs.getString("question"));
				qaVO.setAnswer(rs.getString("answer"));
				
				list.add(qaVO); // Store the row in the list
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
