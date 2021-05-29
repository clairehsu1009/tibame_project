package com.product.model;
import java.util.*;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.live.model.LiveVO;
import com.product.controller.CompositeQuery_Product;


public class ProductDAO implements ProductDAO_interface {

	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/admin");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	//新增商品 賣家上架功能
	private static final String INSERT_STMT = "INSERT INTO PRODUCT (product_name,product_info,product_price,product_remaining,product_state,product_photo,user_id,pdtype_no) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	//查詢所有商品(後台/賣家查詢使用)
	private static final String GET_ALL_STMT = "SELECT product_no,product_name,product_info,product_price,product_quantity,product_remaining,product_sold,product_state,user_id,pdtype_no,start_price,live_no FROM PRODUCT order by product_no";	
	private static final String GET_ONE_STMT = "SELECT * FROM PRODUCT where product_no = ?";
	//刪除商品 賣家使用
	private static final String DELETE = "DELETE FROM PRODUCT where product_no = ?";
	//修改商品 賣家使用
	private static final String UPDATE = "UPDATE PRODUCT set product_name=?, product_info=?, product_price=?,product_remaining=?, product_state=?, product_photo=?, user_id=?, pdtype_no=? where product_no = ?";
	private static final String GET_ALLJSON = "SELECT product_no,product_name,product_info,product_price,product_quantity,product_remaining,product_state,user_id,pdtype_no,start_price,live_no FROM PRODUCT order by product_no";
	//修改商品 買家使用
	private static final String UPDATE_REMAINING = "UPDATE PRODUCT set product_remaining=?, product_sold=?, product_state=? where product_no = ?";
	
	//後台檢舉通過,狀態改為檢舉下架 or 商品狀態修改
	private static final String UPDATESTATE = "UPDATE PRODUCT set product_state=? where product_no = ?";
	//設定商品為直播並帶入直播編號
	private static final String UPDATELIVE = "UPDATE PRODUCT SET PRODUCT_STATE=2 , LIVE_NO=? WHERE PRODUCT_NO = ?";
	//設定多個商品下架並去除直播編號
	private static final String OFFSHELF = "UPDATE PRODUCT SET PRODUCT_STATE=0, LIVE_NO=NULL WHERE PRODUCT_NO = ?";
	/*--------------shop.jsp商品區------------*/
	//查詢所有商品狀態為直售的商品 (隨機排序)
	private static final String GET_ALL_SHOP = "SELECT product_no, product_name, product_info,product_price, product_quantity,product_remaining,product_state,user_id,pdtype_no FROM PRODUCT where product_state = 1 AND product_photo IS NOT NULL order by rand()";	
	//查詢價格區間的商品
	private static final String GET_MoneyRangeShop = "select product_no, product_name, product_info,product_price, product_quantity,product_remaining,product_state,user_id,pdtype_no from PRODUCT where product_photo IS NOT NULL AND product_state = 1 AND product_price between ? and ?";
	//賣家賣場頁面
	private static final String GET_SELLER_PRODUCTS = "select product_no, product_name, product_info,product_price, product_quantity,product_remaining,product_state,user_id,pdtype_no from PRODUCT where product_photo IS NOT NULL AND product_state = 1 AND user_id = ?";
	
	private static final String SOLD = "UPDATE PRODUCT SET PRODUCT_STATE=3 WHERE PRODUCT_NO = ?";
	
	private static final String GET_FAVORITE = "SELECT product_no,product_name,product_info,product_price,product_quantity,product_remaining,product_state,user_id,pdtype_no FROM PRODUCT where product_no = ?";
	@Override
	public void insert(ProductVO productVO){

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, productVO.getProduct_name());
			pstmt.setString(2, productVO.getProduct_info());
			pstmt.setInt(3, productVO.getProduct_price());
			pstmt.setInt(4, productVO.getProduct_remaining());
			pstmt.setInt(5, productVO.getProduct_state());
			pstmt.setBytes(6, productVO.getProduct_photo());
			pstmt.setString(7, productVO.getUser_id());
			pstmt.setInt(8, productVO.getPdtype_no());

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
	public void update(ProductVO productVO){

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

	
			pstmt.setString(1, productVO.getProduct_name());
			pstmt.setString(2, productVO.getProduct_info());
			pstmt.setInt(3, productVO.getProduct_price());
			pstmt.setInt(4, productVO.getProduct_remaining());
			pstmt.setInt(5, productVO.getProduct_state());
			pstmt.setBytes(6,productVO.getProduct_photo());
			pstmt.setString(7,productVO.getUser_id());
			pstmt.setInt(8, productVO.getPdtype_no());
			pstmt.setInt(9, productVO.getProduct_no());

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
	public void updateState(ProductVO productVO){

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATESTATE);

			pstmt.setInt(1, productVO.getProduct_state());
			pstmt.setInt(2, productVO.getProduct_no());

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
	public void delete(Integer product_no){

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			


			pstmt.setInt(1, product_no);

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
	public ProductVO findByPrimaryKey(Integer product_no){

		ProductVO productVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setInt(1, product_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
		
				productVO = new ProductVO();
				productVO.setProduct_no(rs.getInt("product_no"));
				productVO.setProduct_name(rs.getString("product_name"));
				productVO.setProduct_info(rs.getString("product_info"));
				productVO.setProduct_price(rs.getInt("product_price"));
				productVO.setProduct_quantity(rs.getInt("product_quantity"));
				productVO.setProduct_remaining(rs.getInt("product_remaining"));
				productVO.setProduct_sold(rs.getInt("product_sold"));
				productVO.setProduct_state(rs.getInt("product_state"));
				productVO.setProduct_photo(rs.getBytes("product_photo"));
				productVO.setUser_id(rs.getString("user_id"));
				productVO.setPdtype_no(rs.getInt("pdtype_no"));
				productVO.setStart_price(rs.getInt("start_price"));
				productVO.setLive_no(rs.getInt("live_no"));
				
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
		return productVO;
	}

	@Override
	public List<ProductVO> getAll(){
		List<ProductVO> list = new ArrayList<ProductVO>();
		ProductVO productVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				productVO = new ProductVO();
				productVO.setProduct_no(rs.getInt("product_no"));
				productVO.setProduct_name(rs.getString("product_name"));
				productVO.setProduct_info(rs.getString("product_info"));
				productVO.setProduct_price(rs.getInt("product_price"));
				productVO.setProduct_quantity(rs.getInt("product_quantity"));
				productVO.setProduct_remaining(rs.getInt("product_remaining"));
				productVO.setProduct_sold(rs.getInt("product_sold"));
				productVO.setProduct_state(rs.getInt("product_state"));
				productVO.setUser_id(rs.getString("user_id"));
				productVO.setPdtype_no(rs.getInt("pdtype_no"));
				productVO.setStart_price(rs.getInt("start_price"));
				productVO.setLive_no(rs.getInt("live_no"));
				list.add(productVO); // Store the row in the list
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
	
	@Override
	public List<ProductVO> getAllWithoutPhoto(){
		List<ProductVO> list = new ArrayList<ProductVO>();
		ProductVO productVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
		
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALLJSON);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				productVO = new ProductVO();
				productVO.setProduct_no(rs.getInt("product_no"));
				productVO.setProduct_name(rs.getString("product_name"));
				productVO.setProduct_info(rs.getString("product_info"));
				productVO.setProduct_price(rs.getInt("product_price"));
				productVO.setProduct_quantity(rs.getInt("product_quantity"));
				productVO.setProduct_remaining(rs.getInt("product_remaining"));
				productVO.setProduct_state(rs.getInt("product_state"));
				productVO.setUser_id(rs.getString("user_id"));
				productVO.setPdtype_no(rs.getInt("pdtype_no"));
				productVO.setStart_price(rs.getInt("start_price"));
				productVO.setLive_no(rs.getInt("live_no"));
				list.add(productVO); // Store the row in the list
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
	
	@Override
	public List<ProductVO> getAllShop(){
		List<ProductVO> list = new ArrayList<ProductVO>();
		ProductVO productVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_SHOP);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				productVO = new ProductVO();
				productVO.setProduct_no(rs.getInt("product_no"));
				productVO.setProduct_name(rs.getString("product_name"));
				productVO.setProduct_info(rs.getString("product_info"));
				productVO.setProduct_price(rs.getInt("product_price"));
				productVO.setProduct_quantity(rs.getInt("product_quantity"));
				productVO.setProduct_remaining(rs.getInt("product_remaining"));
				productVO.setProduct_state(rs.getInt("product_state"));
				productVO.setUser_id(rs.getString("user_id"));
				productVO.setPdtype_no(rs.getInt("pdtype_no"));
				list.add(productVO); // Store the row in the list
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
	
	
	@Override
	public List<ProductVO> getAllShop(Map<String, String[]> map) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		ProductVO productVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			
			con = ds.getConnection();
			String finalSQL = "select product_no, product_name, product_info,product_price, product_quantity,product_remaining,product_state,user_id,pdtype_no from PRODUCT where product_photo IS NOT NULL AND product_state = 1 "
		          + CompositeQuery_Product.get_WhereCondition(map);

			pstmt = con.prepareStatement(finalSQL);
//			有執行到會印出
//			System.out.println("●●finalSQL(by DAO) = "+finalSQL);  
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				productVO = new ProductVO();	
				productVO.setProduct_no(rs.getInt("product_no"));
				productVO.setProduct_name(rs.getString("product_name"));
				productVO.setProduct_info(rs.getString("product_info"));
				productVO.setProduct_price(rs.getInt("product_price"));
				productVO.setProduct_quantity(rs.getInt("product_quantity"));
				productVO.setProduct_remaining(rs.getInt("product_remaining"));
				productVO.setProduct_state(rs.getInt("product_state"));
				productVO.setUser_id(rs.getString("user_id"));
				productVO.setPdtype_no(rs.getInt("pdtype_no"));
				list.add(productVO); // Store the row in the List
			}
	
			// Handle any SQL errors
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
		return list;
	}
	
	@Override
	public List<ProductVO> getAdvSearchShop(String[] pdtypeNo, String priceType) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		ProductVO productVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {	
			con = ds.getConnection();
			StringBuffer AdvSearchSQL = new StringBuffer("select product_no, product_name, product_info,product_price, product_quantity,product_remaining,product_state,user_id,pdtype_no from PRODUCT where product_photo IS NOT NULL AND product_state = 1 ");
			if(priceType == null) {
				priceType = "E";
			}
			switch(priceType) {
				case "A":
					AdvSearchSQL.append(" AND product_price < 301 ");
					break;
				case "B":
					AdvSearchSQL.append(" AND product_price > 300 AND product_price < 501 ");
					break;
				case "C":
					AdvSearchSQL.append(" AND product_price > 500 AND product_price < 1001 ");
					break;
				case "D":
					AdvSearchSQL.append(" AND product_price > 1000 ");
					break;
				case "E":
					AdvSearchSQL.append("");
					break;	
				default:
					break;
			}
			
			if (pdtypeNo == null || pdtypeNo.length < 1) {
				AdvSearchSQL.append("");
			}else if (pdtypeNo.length > 0) {
				AdvSearchSQL.append("AND (");
				for(int i = 0; i < pdtypeNo.length; i++) {
					if(i != pdtypeNo.length - 1)
						AdvSearchSQL.append(("pdtype_no = " + pdtypeNo[i] + " OR "));
					else
						AdvSearchSQL.append(("pdtype_no = " + pdtypeNo[i]));
				}
				AdvSearchSQL.append(")");
			}
	  
//			System.out.println(AdvSearchSQL);
			
			pstmt = con.prepareStatement(AdvSearchSQL.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				productVO = new ProductVO();
				productVO.setProduct_no(rs.getInt("product_no"));
				productVO.setProduct_name(rs.getString("product_name"));
				productVO.setProduct_info(rs.getString("product_info"));
				productVO.setProduct_price(rs.getInt("product_price"));
				productVO.setProduct_quantity(rs.getInt("product_quantity"));
				productVO.setProduct_remaining(rs.getInt("product_remaining"));
				productVO.setProduct_state(rs.getInt("product_state"));
				productVO.setUser_id(rs.getString("user_id"));
				productVO.setPdtype_no(rs.getInt("pdtype_no"));
				list.add(productVO); // Store the row in the list
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
		return list;
	}
	
	@Override
	public List<ProductVO> getMoneyRangeShop(String minPrice, String maxPrice) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		ProductVO productVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MoneyRangeShop);
			pstmt.setString(1, minPrice);
			pstmt.setString(2, maxPrice);
			
			rs = pstmt.executeQuery();
		
			while (rs.next()) {
				
				productVO = new ProductVO();
				productVO.setProduct_no(rs.getInt("product_no"));
				productVO.setProduct_name(rs.getString("product_name"));
				productVO.setProduct_info(rs.getString("product_info"));
				productVO.setProduct_price(rs.getInt("product_price"));
				productVO.setProduct_quantity(rs.getInt("product_quantity"));
				productVO.setProduct_remaining(rs.getInt("product_remaining"));
				productVO.setProduct_state(rs.getInt("product_state"));
				productVO.setUser_id(rs.getString("user_id"));
				productVO.setPdtype_no(rs.getInt("pdtype_no"));
				list.add(productVO); // Store the row in the list
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
		return list;
	}
	
	
	//獲取某商品編號的圖片
	@Override
	public Optional<ProductVO> findProductPic(Integer product_no) {
		ProductVO productVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setInt(1, product_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				productVO = new ProductVO();
				productVO.setProduct_photo(rs.getBytes("product_photo"));
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
		return Optional.ofNullable(productVO);
	}
	
	@Override
	public void update_remaining(ProductVO productVO){

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE_REMAINING);

			pstmt.setInt(1, productVO.getProduct_remaining());
			pstmt.setInt(2, productVO.getProduct_sold());
			pstmt.setInt(3, productVO.getProduct_state());
			pstmt.setInt(4, productVO.getProduct_no());

			pstmt.executeUpdate();
			
			con.commit();
			// Handle any driver errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			try {
				con.setAutoCommit(true);
			} catch (SQLException e1) {
				e1.printStackTrace();
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

	}
	

	@Override
	public void updateStateLive(Integer live_no , List<ProductVO> list) {
		
			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATELIVE);
				
				
				for (ProductVO aProduct : list) {
					pstmt.setInt(1, live_no);
					pstmt.setInt(2, aProduct.getProduct_no());
					pstmt.addBatch();
				}
				
				pstmt.executeBatch();

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
	public void offShelf(List<ProductVO> list) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(OFFSHELF);
			
			
			for (ProductVO aProduct : list) {
				pstmt.setInt(1, aProduct.getProduct_no());
				pstmt.addBatch();
			}
			
			pstmt.executeBatch();

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
	public List<ProductVO> getSellerProducts(String user_id){
		List<ProductVO> list = new ArrayList<ProductVO>();
		ProductVO productVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_SELLER_PRODUCTS);
			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
		
				productVO = new ProductVO();
				productVO.setProduct_no(rs.getInt("product_no"));
				productVO.setProduct_name(rs.getString("product_name"));
				productVO.setProduct_info(rs.getString("product_info"));
				productVO.setProduct_price(rs.getInt("product_price"));
				productVO.setProduct_quantity(rs.getInt("product_quantity"));
				productVO.setProduct_remaining(rs.getInt("product_remaining"));
				productVO.setProduct_state(rs.getInt("product_state"));
				productVO.setUser_id(rs.getString("user_id"));
				productVO.setPdtype_no(rs.getInt("pdtype_no"));
				list.add(productVO);
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
	
	@Override
	public ProductVO getFavorite(Integer product_no){

		ProductVO productVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_FAVORITE );
			pstmt.setInt(1, product_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
		
				productVO = new ProductVO();
				productVO.setProduct_no(rs.getInt("product_no"));
				productVO.setProduct_name(rs.getString("product_name"));
				productVO.setProduct_info(rs.getString("product_info"));
				productVO.setProduct_price(rs.getInt("product_price"));
				productVO.setProduct_quantity(rs.getInt("product_quantity"));
				productVO.setProduct_remaining(rs.getInt("product_remaining"));
				productVO.setProduct_state(rs.getInt("product_state"));
				productVO.setUser_id(rs.getString("user_id"));
				productVO.setPdtype_no(rs.getInt("pdtype_no"));				
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
		return productVO;
	}

@Override
public void updateState(Integer product_state , List<ProductVO> list) {
	
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATESTATE);
			
			
			for (ProductVO aProduct : list) {
				pstmt.setInt(1, product_state);
				pstmt.setInt(2, aProduct.getProduct_no());
				pstmt.addBatch();
			}
			
			pstmt.executeBatch();

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
}