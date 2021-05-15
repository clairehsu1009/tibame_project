package com.notice.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class NoticeJNDIDAO implements NoticeDAO_interface{

	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
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
			"INSERT INTO `NOTICE` (`USER_ID`,`NOC_CONTENT`,`NOC_STATE`) VALUES (?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT `NOTICE_NO`,`USER_ID`,`NOC_CONTENT`,`NOC_DATE`,`NOC_STATE` FROM `NOTICE` ORDER BY `NOTICE_NO`";
	private static final String GET_ONE_STMT = 
			"SELECT `NOTICE_NO`,`USER_ID`,`NOC_CONTENT`,`NOC_DATE`,`NOC_STATE` FROM `NOTICE` WHERE `NOTICE_NO` = ?";
	private static final String DELETE = 
			"DELETE FROM `NOTICE` WHERE `NOTICE_NO` = ?";
	private static final String UPDATE = 
			"UPDATE `NOTICE` SET `USER_ID`=?, `NOC_CONTENT`=?, `NOC_DATE`=?, `NOC_STATE`=? WHERE `NOTICE_NO` = ?";
	
	
	
	@Override
	public void insert(NoticeVO noticeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, noticeVO.getUser_id());
			pstmt.setString(2, noticeVO.getNoc_content());
			pstmt.setInt(3, noticeVO.getNoc_state());

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
	public void update(NoticeVO noticeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, noticeVO.getUser_id());
			pstmt.setString(2, noticeVO.getNoc_content());
			pstmt.setTimestamp(3, noticeVO.getNoc_date());
			pstmt.setInt(4, noticeVO.getNoc_state());

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
	public NoticeVO findByPrimaryKey(Integer notice_no) {

		NoticeVO noticeVO = null;
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
				noticeVO = new NoticeVO();
				noticeVO.setNotice_no(rs.getInt("notice_no"));
				noticeVO.setUser_id(rs.getString("user_id"));
				noticeVO.setNoc_content(rs.getString("noc_content"));
				noticeVO.setNoc_date(rs.getTimestamp("noc_date"));
				noticeVO.setNoc_state(rs.getInt("noc_state"));
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
		return noticeVO;
	}

	@Override
	public List<NoticeVO> getAll() {
		List<NoticeVO> list = new ArrayList<NoticeVO>();
		NoticeVO noticeVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				//
				noticeVO = new NoticeVO();
				noticeVO.setNotice_no(rs.getInt("notice_no"));
				noticeVO.setUser_id(rs.getString("user_id"));
				noticeVO.setNoc_content(rs.getString("noc_content"));
				noticeVO.setNoc_date(rs.getTimestamp("noc_date"));
				noticeVO.setNoc_state(rs.getInt("noc_state"));
				list.add(noticeVO); // Store the row in the list
			}

			// Handle any driver errors
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
}
