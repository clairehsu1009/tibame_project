package com.product_report.model;
import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.product_type.model.Product_TypeVO;

public class Product_ReportDAO implements Product_ReportDAO_interface {

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
	//前台會員新增商品檢舉(時間sql已預設當下時間,檢舉狀態已預設未處理,故新增資料時不需再填寫)
	private static final String INSERT_STMT = 
		"INSERT INTO PRODUCT_REPORT (pro_report_content,product_no,user_id) VALUES (?, ?, ?)";
	//會員商品資料內 顯示遭檢舉下架的資訊
	private static final String GET_ONE_REPORT_INFO = 
	  "SELECT pro_report_content,report_date FROM PRODUCT_REPORT where product_no = ?";
	//後台查詢所有商品檢舉資料
	private static final String GET_ALL_STMT = 
		"SELECT * FROM PRODUCT_REPORT order by pro_report_no";
	//後台查詢一個商品檢舉資料
	private static final String GET_ONE_STMT = 
		"SELECT * FROM PRODUCT_REPORT where pro_report_no = ?";
	//後台依照不同的檢舉處理狀態做查詢(沒用到)
	private static final String GET_REPORT_STATE = 
		"SELECT * FROM PRODUCT_REPORT where proreport_state = ?";
	//後台刪除檢舉紀錄
	private static final String DELETE = 
		"DELETE FROM PRODUCT_REPORT where pro_report_no = ?";
	//後台修改檢舉狀態
	private static final String UPDATE = 
		"UPDATE PRODUCT_REPORT set product_no=?, proreport_state=? where pro_report_no = ?";

	@Override
	public void insert(Product_ReportVO product_reportVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, product_reportVO.getPro_report_content());
			pstmt.setInt(2, product_reportVO.getProduct_no());
			pstmt.setString(3, product_reportVO.getUser_id());
//			pstmt.setInt(4, product_reportVO.getEmpno());

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
	public void update(Product_ReportVO product_reportVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setInt(1, product_reportVO.getProduct_no());
			pstmt.setInt(2, product_reportVO.getProreport_state());
			pstmt.setInt(3, product_reportVO.getPro_report_no());

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
	public void delete(Integer pro_report_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, pro_report_no);

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
	public Product_ReportVO findByPrimaryKey(Integer pro_report_no){

		Product_ReportVO product_reportVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, pro_report_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
		
				product_reportVO = new Product_ReportVO();
				product_reportVO.setPro_report_no(rs.getInt("pro_report_no"));
				product_reportVO.setPro_report_content(rs.getString("pro_report_content"));
				product_reportVO.setProduct_no(rs.getInt("product_no"));
				product_reportVO.setUser_id(rs.getString("user_id"));
				product_reportVO.setReport_date(rs.getTimestamp("report_date"));
				product_reportVO.setEmpno(rs.getInt("empno"));
				product_reportVO.setProreport_state(rs.getInt("proreport_state"));
				
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
		return product_reportVO;
	}

	@Override
	public List<Product_ReportVO> getAll_Report_state() {

		List<Product_ReportVO> list = new ArrayList<Product_ReportVO>();
		Product_ReportVO product_reportVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_REPORT_STATE);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				product_reportVO = new Product_ReportVO();
				product_reportVO.setPro_report_no(rs.getInt("pro_report_no"));
				product_reportVO.setPro_report_content(rs.getString("pro_report_content"));
				product_reportVO.setProduct_no(rs.getInt("product_no"));
				product_reportVO.setUser_id(rs.getString("user_id"));
				product_reportVO.setReport_date(rs.getTimestamp("report_date"));
				product_reportVO.setEmpno(rs.getInt("empno"));
				product_reportVO.setProreport_state(rs.getInt("proreport_state"));
				list.add(product_reportVO); // Store the row in the list
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
	public List<Product_ReportVO> getAll() {
		List<Product_ReportVO> list = new ArrayList<Product_ReportVO>();
		Product_ReportVO product_reportVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// product_reportVO 也稱為 Domain objects
				product_reportVO = new Product_ReportVO();
				product_reportVO.setPro_report_no(rs.getInt("pro_report_no"));
				product_reportVO.setPro_report_content(rs.getString("pro_report_content"));
				product_reportVO.setProduct_no(rs.getInt("product_no"));
				product_reportVO.setUser_id(rs.getString("user_id"));
				product_reportVO.setReport_date(rs.getTimestamp("report_date"));
				product_reportVO.setEmpno(rs.getInt("empno"));
				product_reportVO.setProreport_state(rs.getInt("proreport_state"));
				list.add(product_reportVO); // Store the row in the list
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
	public Product_ReportVO userProduct_ReportInfo(Integer product_no){

		Product_ReportVO product_reportVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_REPORT_INFO);

			pstmt.setInt(1, product_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
		
				product_reportVO = new Product_ReportVO();
				product_reportVO.setPro_report_content(rs.getString("pro_report_content"));
				product_reportVO.setReport_date(rs.getTimestamp("report_date"));
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
		return product_reportVO;
	}
}