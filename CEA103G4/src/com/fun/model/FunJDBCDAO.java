package com.fun.model;

import java.util.*;
import java.sql.*;

public class FunJDBCDAO implements FunDAO_interface {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/CEA103_G4?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "771414";

	private static final String INSERT_STMT = "INSERT INTO FUN (FUN_NAME,state) VALUES (?)";
	private static final String GET_ALL_STMT = "SELECT * FROM FUN ORDER BY FUNNO";
	private static final String GET_ONE_STMT = "SELECT * FROM FUN WHERE FUNNO = ?";
	private static final String DELETE = "DELETE FROM FUN WHERE FUNNO = ?";
	private static final String UPDATE = "UPDATE FUN SET FUN_NAME=? state =? WHERE FUNNO = ?";


	@Override
	public List<FunVO> getAll() {
		List<FunVO> list = new ArrayList<FunVO>();
		FunVO funVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				funVO = new FunVO();
				funVO.setFunno(rs.getInt("funno"));
			
				list.add(funVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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

	public static void main(String[] args) {

		FunJDBCDAO dao = new FunJDBCDAO();

		// �s�W
		FunVO funVO1 = new FunVO();
		funVO1.setFunName("PETER1");
		
		dao.insert(funVO1);

		// �ק�
		FunVO funVO2 = new FunVO();

		funVO2.setFunName("PETER1");

		dao.update(funVO2);

		// �R��
		dao.delete(15012);

		// �d��
		FunVO funVO3 = dao.findByPrimaryKey(15001);
		System.out.print(funVO3.getFunName() + ",");
		
		System.out.println("---------------------");

		// �d��
		List<FunVO> list = dao.getAll();
		for (FunVO aEmp : list) {
			System.out.print(aEmp.getFunno() + ",");
			System.out.print(aEmp.getFunName() + ",");
			
			System.out.println();
		}
	}

	@Override
	public void insert(FunVO funVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, funVO.getFunName());
			
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
	public void update(FunVO funVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, funVO.getFunName());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
	public FunVO findByPrimaryKey(Integer funno) {
		FunVO funVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, funno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVo �]�٬� Domain objects
				FunVO funVO11 = new FunVO();
				funVO11.setFunno(rs.getInt("funno"));
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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
		return funVO;
	}

	@Override
	public void delete(Integer funno) {
		// TODO Auto-generated method stub
		
	}
}