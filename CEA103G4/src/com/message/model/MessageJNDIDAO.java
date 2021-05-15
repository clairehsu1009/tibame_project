package com.message.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MessageJNDIDAO implements MessageDAO_interface{

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
			"INSERT INTO `MESSAGE` (`USER_ID`,`CONTENT`,`SELLER_ID`,`MESSAGE_TIME`) VALUES (?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT `MESSAGE_NO`,`USER_ID`,`CONTENT`,`SELLER_ID`,`MESSAGE_TIME` FROM `MESSAGE` ORDER BY `MESSAGE_NO`";
	private static final String GET_ONE_STMT = 
			"SELECT `MESSAGE_NO`,`USER_ID`,`CONTENT`,`SELLER_ID`,`MESSAGE_TIME` FROM `MESSAGE` WHERE `MESSAGE_NO` = ?";
	private static final String DELETE = 
			"DELETE FROM `MESSAGE` WHERE `MESSAGE_NO` = ?";
	private static final String UPDATE = 
			"UPDATE `MESSAGE` SET `USER_ID`=?, `CONTENT`=?, `SELLER_ID`=?, `MESSAGE_TIME`=? WHERE `MESSAGE_NO` = ?";
	
	
	
	@Override
	public void insert(MessageVO messageVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, messageVO.getUser_id());
			pstmt.setString(2, messageVO.getContent());
			pstmt.setString(3, messageVO.getSeller_id());
			pstmt.setDate(4, messageVO.getMessage_time());

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
	public void update(MessageVO messageVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, messageVO.getUser_id());
			pstmt.setString(2, messageVO.getContent());
			pstmt.setString(3, messageVO.getSeller_id());
			pstmt.setDate(4, messageVO.getMessage_time());
			pstmt.setInt(5, messageVO.getMessage_no());

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
	public void delete(Integer message_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, message_no);

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
	public MessageVO findByPrimaryKey(Integer message_no) {

		MessageVO messageVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, message_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				//
				messageVO = new MessageVO();
				messageVO.setMessage_no(rs.getInt("message_no"));
				messageVO.setUser_id(rs.getString("user_id"));
				messageVO.setContent(rs.getString("content"));
				messageVO.setSeller_id(rs.getString("seller_id"));
				messageVO.setMessage_time(rs.getDate("message_time"));
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
		return messageVO;
	}

	@Override
	public List<MessageVO> getAll() {
		List<MessageVO> list = new ArrayList<MessageVO>();
		MessageVO messageVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				//
				messageVO = new MessageVO();
				messageVO.setMessage_no(rs.getInt("message_no"));
				messageVO.setUser_id(rs.getString("user_id"));
				messageVO.setContent(rs.getString("content"));
				messageVO.setSeller_id(rs.getString("seller_id"));
				messageVO.setMessage_time(rs.getDate("message_time"));
				list.add(messageVO); // Store the row in the list
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
