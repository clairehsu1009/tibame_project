package com.ad.model;

import java.util.*;
import java.sql.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.ad.model.AdVO;

public class AdDAO implements AdDAO_interface {
	
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
			"INSERT INTO `AD` (`EMPNO`,`AD_CONTENT`,`AD_PHOTO`,`AD_STATE`,`AD_START_DATE`,`AD_END_DATE`,`AD_URL`) VALUES (?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM `AD` ORDER BY `AD_NO`";
	private static final String GET_ONE_STMT = 
			"SELECT `AD_NO`,`EMPNO`,`AD_CONTENT`,`AD_PHOTO`,`AD_STATE`,`AD_START_DATE`,`AD_END_DATE`,`AD_URL` FROM AD WHERE `AD_NO` = ?";
	private static final String DELETE = 
			"DELETE FROM AD where AD_NO = ?";
	private static final String UPDATE = 
			"UPDATE `AD` SET `EMPNO`=?, `AD_CONTENT`=?, `AD_PHOTO`=?, `AD_STATE`=?, `AD_START_DATE`=?, `AD_END_DATE`=?, `AD_URL`=? WHERE `AD_NO` = ?";


	@Override
	public void insert(AdVO adVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, adVO.getEmpno());
			pstmt.setString(2, adVO.getAd_content());
			pstmt.setBytes(3, adVO.getAd_photo());
			pstmt.setInt(4, adVO.getAd_state());
			pstmt.setDate(5, adVO.getAd_start_date());
			pstmt.setDate(6, adVO.getAd_end_date());
			pstmt.setString(7, adVO.getAd_url());
			

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
	public void update(AdVO adVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, adVO.getEmpno());
			pstmt.setString(2, adVO.getAd_content());
			pstmt.setBytes(3, adVO.getAd_photo());
			pstmt.setInt(4, adVO.getAd_state());
			pstmt.setDate(5, adVO.getAd_start_date());
			pstmt.setDate(6, adVO.getAd_end_date());
			pstmt.setString(7, adVO.getAd_url());
			pstmt.setInt(8, adVO.getAd_no());
			
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
	public void delete(Integer ad_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, ad_no);

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
	public AdVO findByPrimaryKey(Integer ad_no) {
		AdVO adVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, ad_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// adVo 也稱為 Domain objects
				adVO = new AdVO();
				
				adVO.setAd_no(rs.getInt("ad_no"));
				adVO.setEmpno(rs.getInt("empno"));
				adVO.setAd_content(rs.getString("ad_content"));
				adVO.setAd_photo(rs.getBytes("ad_photo"));
				adVO.setAd_state(rs.getInt("ad_state"));
				adVO.setAd_start_date(rs.getDate("ad_start_date"));
				adVO.setAd_end_date(rs.getDate("ad_end_date"));
				adVO.setAd_url(rs.getString("ad_url"));
				
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
		return adVO;
	}

	@Override
	public List<AdVO> getAll() {
		List<AdVO> list = new ArrayList<AdVO>();
		AdVO adVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// adVO 也稱為 Domain objects
				adVO = new AdVO();
				
				adVO.setAd_no(rs.getInt("ad_no"));
				adVO.setEmpno(rs.getInt("empno"));
				adVO.setAd_content(rs.getString("ad_content"));
				adVO.setAd_photo(rs.getBytes("ad_photo"));
				adVO.setAd_state(rs.getInt("ad_state"));
				adVO.setAd_start_date(rs.getDate("ad_start_date"));
				adVO.setAd_end_date(rs.getDate("ad_end_date"));
				adVO.setAd_url(rs.getString("ad_url"));
				
				list.add(adVO); // Store the row in the list
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
	public Optional<AdVO> findAdPic(Integer ad_no) {
		AdVO adVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setInt(1, ad_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				adVO = new AdVO();
				adVO.setAd_photo(rs.getBytes("ad_photo"));
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
		return Optional.ofNullable(adVO);
	}
}
