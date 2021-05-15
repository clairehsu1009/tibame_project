package com.live_report.model;

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

public class Live_reportJNDIDAO implements Live_reportDAO_interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/admin");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO LIVE_REPORT (LIVE_REPORT_CONTENT,LIVE_NO,USER_ID,EMPNO,LIVE_REPORT_STATE,PHOTO) VALUES (?, ?, ? ,? ,? ,? )";
	private static final String GET_ALL_STMT = "SELECT * FROM LIVE_REPORT ORDER BY LIVE_REPORT_NO";
	private static final String GET_ONE_STMT = "SELECT * FROM LIVE_REPORT WHERE LIVE_REPORT_NO = ?";
	private static final String DELETE = "DELETE FROM LIVE_REPORT where LIVE_REPORT_NO = ?";
	private static final String UPDATE = "UPDATE LIVE_REPORT SET LIVE_REPORT_CONTENT=?,LIVE_NO=?,USER_ID=?,EMPNO=?,LIVE_REPORT_STATE=?,PHOTO=? WHERE LIVE_REPORT_NO = ?";

	@Override
	public void insert(Live_reportVO live_reportVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, live_reportVO.getLive_report_content());
			pstmt.setInt(2, live_reportVO.getLive_no());
			pstmt.setString(3, live_reportVO.getUser_id());
			pstmt.setInt(4, live_reportVO.getEmpno());
			pstmt.setInt(5, live_reportVO.getLive_report_state());
			pstmt.setBytes(6, live_reportVO.getPhoto());

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
	public void update(Live_reportVO live_reportVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, live_reportVO.getLive_report_content());
			pstmt.setInt(2, live_reportVO.getLive_no());
			pstmt.setString(3, live_reportVO.getUser_id());
			pstmt.setInt(4, live_reportVO.getEmpno());
			pstmt.setInt(5, live_reportVO.getLive_report_state());
			pstmt.setBytes(6, live_reportVO.getPhoto());
			pstmt.setInt(7, live_reportVO.getLive_report_no());

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
	public void delete(Integer live_report_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, live_report_no);

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
	public Live_reportVO findByPrimaryKey(Integer live_report_no) {

		Live_reportVO live_reportVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, live_report_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				live_reportVO = new Live_reportVO();
				live_reportVO.setLive_report_no(rs.getInt("live_report_no"));
				live_reportVO.setLive_report_content(rs.getString("live_report_content"));
				live_reportVO.setLive_no(rs.getInt("live_no"));
				live_reportVO.setUser_id(rs.getString("User_id"));
				live_reportVO.setEmpno(rs.getInt("empno"));
				live_reportVO.setLive_report_state(rs.getInt("live_report_state"));
				live_reportVO.setReport_date(rs.getTimestamp("report_date"));
				live_reportVO.setPhoto(rs.getBytes("photo"));
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

		return live_reportVO;
	}

	@Override
	public List<Live_reportVO> getAll() {

		List<Live_reportVO> list = new ArrayList<Live_reportVO>();
		Live_reportVO live_reportVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				live_reportVO = new Live_reportVO();
				live_reportVO.setLive_report_no(rs.getInt("live_report_no"));
				live_reportVO.setLive_report_content(rs.getString("live_report_content"));
				live_reportVO.setLive_no(rs.getInt("live_no"));
				live_reportVO.setUser_id(rs.getString("User_id"));
				live_reportVO.setEmpno(rs.getInt("empno"));
				live_reportVO.setLive_report_state(rs.getInt("live_report_state"));
				live_reportVO.setReport_date(rs.getTimestamp("report_date"));
				live_reportVO.setPhoto(rs.getBytes("photo"));
				list.add(live_reportVO);
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

}
