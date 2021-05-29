package com.order.model;

import java.util.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.order_detail.model.Order_detailDAO;
import com.order_detail.model.Order_detailVO;
import com.product.model.ProductDAO;
import com.product.model.ProductVO;



public class OrderJNDIDAO implements OrderDAO_interface{  

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
			"INSERT INTO `ORDER` (`ORDER_NO`,`ORDER_STATE`,`ORDER_SHIPPING`,`ORDER_PRICE`,`PAY_METHOD`,`PAY_DEADLINE`,`REC_NAME`,`ZIPCODE`,`CITY`,`TOWN`,`REC_ADDR`,`REC_PHONE`,`REC_CELLPHONE`,`LOGISTICS`,`LOGISTICSSTATE`,`DISCOUNT`,`USER_ID`,`SELLER_ID`,`SRATING`,`SRATING_CONTENT`,`POINT`) VALUES (null, ?, ?, ?, ?, DATE_ADD(CURRENT_TIMESTAMP() , INTERVAL 3 HOUR), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String INSERT_STMT2 = 
			"INSERT INTO `ORDER` (`ORDER_NO`,`ORDER_STATE`,`ORDER_SHIPPING`,`ORDER_PRICE`,`PAY_METHOD`,`PAY_DEADLINE`,`REC_NAME`,`ZIPCODE`,`CITY`,`TOWN`,`REC_ADDR`,`REC_PHONE`,`REC_CELLPHONE`,`LOGISTICS`,`DISCOUNT`,`USER_ID`,`SELLER_ID`,`POINT`) VALUES (null, ?, ?, ?, ?, DATE_ADD(CURRENT_TIMESTAMP() , INTERVAL 3 HOUR), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT `ORDER_NO`,`ORDER_DATE`,`ORDER_STATE`,`ORDER_SHIPPING`,`ORDER_PRICE`,`PAY_METHOD`,`PAY_DEADLINE`,`REC_NAME`,`ZIPCODE`,`CITY`,`TOWN`,`REC_ADDR`,`REC_PHONE`,`REC_CELLPHONE`,`LOGISTICS`,`LOGISTICSSTATE`,`DISCOUNT`,`USER_ID`,`SELLER_ID`,`SRATING`,`SRATING_CONTENT`,`POINT` FROM `ORDER` ORDER BY `ORDER_NO`";
	private static final String GET_ONE_STMT = 
			"SELECT `ORDER_NO`,`ORDER_DATE`,`ORDER_STATE`,`ORDER_SHIPPING`,`ORDER_PRICE`,`PAY_METHOD`,`PAY_DEADLINE`,`REC_NAME`,`ZIPCODE`,`CITY`,`TOWN`,`REC_ADDR`,`REC_PHONE`,`REC_CELLPHONE`,`LOGISTICS`,`LOGISTICSSTATE`,`DISCOUNT`,`USER_ID`,`SELLER_ID`,`SRATING`,`SRATING_CONTENT`,`POINT` FROM `ORDER` WHERE `ORDER_NO` = ?";
	private static final String DELETE = 
			"DELETE FROM `ORDER` WHERE `ORDER_NO` = ?";
	private static final String CANCEL = 
			"UPDATE `ORDER` SET `ORDER_STATE`=? WHERE `ORDER_NO` = ?";
	private static final String UPDATE = 
			"UPDATE `ORDER` SET `ORDER_DATE`=?, `ORDER_STATE`=?, `ORDER_SHIPPING`=?,`ORDER_PRICE`=?,`PAY_METHOD`=?,`PAY_DEADLINE`=?,`REC_NAME`=?,`ZIPCODE`=?,`CITY`=?,`TOWN`=?,`REC_ADDR`=?,`REC_PHONE`=?,`REC_CELLPHONE`=?,`LOGISTICS`=?,`LOGISTICSSTATE`=?,`DISCOUNT`=?,`USER_ID`=?,`SELLER_ID`=?,`SRATING`=?,`SRATING_CONTENT`=?,`POINT`=? WHERE `ORDER_NO` = ?";
	private static final String GET_ORDER_BY_ID =
			"SELECT * FROM `ORDER` WHERE `USER_ID` = ? ORDER BY `ORDER_NO`";
	private static final String GET_ORDER_BY_ID2 =
			"SELECT * FROM `ORDER` WHERE `SELLER_ID` = ? ORDER BY `ORDER_NO`";
	private static final String UPDATE_SHIPPED =
			"UPDATE `ORDER` SET `LOGISTICSSTATE`=1 WHERE `ORDER_NO` = ?";
	private static final String UPDATE_UNSHIPPED =
			"UPDATE `ORDER` SET `LOGISTICSSTATE`=0 WHERE `ORDER_NO` = ?";
	private static final String UPDATE_SRATING =
			"UPDATE `ORDER` SET `SRATING` = ?, `SRATING_CONTENT` = ?, `LOGISTICSSTATE` = ? WHERE `ORDER_NO` = ?";
	private static final String GET_Details_ByNo_STMT =
			"SELECT * FROM `ORDER_DETAIL` WHERE `ORDER_NO` = ? ORDER BY `PRODUCT_NO`";
	
	
	@Override
	public Object insert(OrderVO orderVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(INSERT_STMT,PreparedStatement.RETURN_GENERATED_KEYS);

			pstmt.setInt(1, orderVO.getOrder_state());
			pstmt.setInt(2, orderVO.getOrder_shipping());			
			pstmt.setInt(3, orderVO.getOrder_price());
			pstmt.setInt(4, orderVO.getPay_method());
			pstmt.setString(5, orderVO.getRec_name());
			pstmt.setString(6, orderVO.getZipcode());
			pstmt.setString(7, orderVO.getCity());
			pstmt.setString(8, orderVO.getTown());
			pstmt.setString(9, orderVO.getRec_addr());
			pstmt.setString(10, orderVO.getRec_phone());
			pstmt.setString(11, orderVO.getRec_cellphone());
			pstmt.setInt(12, orderVO.getLogistics());
			pstmt.setInt(13, orderVO.getLogisticsstate());
			pstmt.setInt(14, orderVO.getDiscount());
			pstmt.setString(15, orderVO.getUser_id());
			pstmt.setString(16, orderVO.getSeller_id());
			pstmt.setInt(17, orderVO.getSrating());
			pstmt.setString(18, orderVO.getSrating_content());
			pstmt.setInt(19, orderVO.getPoint());
		
			pstmt.executeUpdate();
			
			ResultSet rs = pstmt.getGeneratedKeys();
			rs.next();
			Integer order_no = rs.getInt(1);
			orderVO.setOrder_no(order_no);
			
			con.commit();
			// Handle any SQL errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
		}return orderVO;
	}

	@Override
	public void update(OrderVO orderVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setTimestamp(1, orderVO.getOrder_date());
			pstmt.setInt(2, orderVO.getOrder_state());
			pstmt.setInt(3, orderVO.getOrder_shipping());			
			pstmt.setInt(4, orderVO.getOrder_price());
			pstmt.setInt(5, orderVO.getPay_method());
			pstmt.setTimestamp(6, orderVO.getPay_deadline());
			pstmt.setString(7, orderVO.getRec_name());
			pstmt.setString(8, orderVO.getZipcode());
			pstmt.setString(9, orderVO.getCity());
			pstmt.setString(10, orderVO.getTown());
			pstmt.setString(11, orderVO.getRec_addr());
			pstmt.setString(12, orderVO.getRec_phone());
			pstmt.setString(13, orderVO.getRec_cellphone());
			pstmt.setInt(14, orderVO.getLogistics());
			pstmt.setInt(15, orderVO.getLogisticsstate());
			pstmt.setInt(16, orderVO.getDiscount());
			pstmt.setString(17, orderVO.getUser_id());
			pstmt.setString(18, orderVO.getSeller_id());
			pstmt.setInt(19, orderVO.getSrating());
			pstmt.setString(20, orderVO.getSrating_content());
			pstmt.setInt(21, orderVO.getPoint());
			pstmt.setInt(22, orderVO.getOrder_no());
			

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
	public void delete(Integer order_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, order_no);

			pstmt.executeUpdate();

			Order_detailDAO dao = new Order_detailDAO();
			dao.delete(order_no);
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
	public OrderVO findByPrimaryKey(Integer order_no) {

		OrderVO orderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, order_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				//
				orderVO = new OrderVO();
				orderVO.setOrder_no(rs.getInt("order_no"));
				orderVO.setOrder_date(rs.getTimestamp("order_date"));
				orderVO.setOrder_state(rs.getInt("order_state"));
				orderVO.setOrder_shipping(rs.getInt("order_shipping"));
				orderVO.setOrder_price(rs.getInt("order_price"));
				orderVO.setPay_method(rs.getInt("pay_method"));
				orderVO.setPay_deadline(rs.getTimestamp("pay_deadline"));
				orderVO.setRec_name(rs.getString("rec_name"));
				orderVO.setZipcode(rs.getString("zipcode"));
				orderVO.setCity(rs.getString("city"));
				orderVO.setTown(rs.getString("town"));
				orderVO.setRec_addr(rs.getString("rec_addr"));
				orderVO.setRec_phone(rs.getString("rec_phone"));
				orderVO.setRec_cellphone(rs.getString("rec_cellphone"));
				orderVO.setLogistics(rs.getInt("logistics"));
				orderVO.setLogisticsstate(rs.getInt("logisticsstate"));
				orderVO.setDiscount(rs.getInt("discount"));
				orderVO.setUser_id(rs.getString("user_id"));
				orderVO.setSeller_id(rs.getString("seller_id"));
				orderVO.setSrating(rs.getInt("srating"));
				orderVO.setSrating_content(rs.getString("srating_content"));
				orderVO.setPoint(rs.getInt("point"));
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
		return orderVO;
	}

	@Override
	public List<OrderVO> getAll() {
		List<OrderVO> list = new ArrayList<OrderVO>();
		OrderVO orderVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				orderVO = new OrderVO();
				orderVO.setOrder_no(rs.getInt("order_no"));
				orderVO.setOrder_date(rs.getTimestamp("order_date"));
				orderVO.setOrder_state(rs.getInt("order_state"));
				orderVO.setOrder_shipping(rs.getInt("order_shipping"));
				orderVO.setOrder_price(rs.getInt("order_price"));
				orderVO.setPay_method(rs.getInt("pay_method"));
				orderVO.setPay_deadline(rs.getTimestamp("pay_deadline"));
				orderVO.setRec_name(rs.getString("rec_name"));
				orderVO.setZipcode(rs.getString("zipcode"));
				orderVO.setCity(rs.getString("city"));
				orderVO.setTown(rs.getString("town"));
				orderVO.setRec_addr(rs.getString("rec_addr"));
				orderVO.setRec_phone(rs.getString("rec_phone"));
				orderVO.setRec_cellphone(rs.getString("rec_cellphone"));
				orderVO.setLogistics(rs.getInt("logistics"));
				orderVO.setLogisticsstate(rs.getInt("logisticsstate"));
				orderVO.setDiscount(rs.getInt("discount"));
				orderVO.setUser_id(rs.getString("user_id"));
				orderVO.setSeller_id(rs.getString("seller_id"));
				orderVO.setSrating(rs.getInt("srating"));
				orderVO.setSrating_content(rs.getString("srating_content"));
				orderVO.setPoint(rs.getInt("point"));
				list.add(orderVO); // Store the row in the list
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
	@Override
	public List<OrderVO> getAllByID(String user_id) {
		List<OrderVO> list = new ArrayList<OrderVO>();
		OrderVO orderVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ORDER_BY_ID);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				orderVO = new OrderVO();
				orderVO.setOrder_no(rs.getInt("order_no"));
				orderVO.setOrder_date(rs.getTimestamp("order_date"));
				orderVO.setOrder_state(rs.getInt("order_state"));
				orderVO.setOrder_shipping(rs.getInt("order_shipping"));
				orderVO.setOrder_price(rs.getInt("order_price"));
				orderVO.setPay_method(rs.getInt("pay_method"));
				orderVO.setPay_deadline(rs.getTimestamp("pay_deadline"));
				orderVO.setRec_name(rs.getString("rec_name"));
				orderVO.setRec_addr(rs.getString("rec_addr"));
				orderVO.setRec_phone(rs.getString("rec_phone"));
				orderVO.setRec_cellphone(rs.getString("rec_cellphone"));
				orderVO.setLogistics(rs.getInt("logistics"));
				orderVO.setLogisticsstate(rs.getInt("logisticsstate"));
				orderVO.setDiscount(rs.getInt("discount"));
				orderVO.setUser_id(rs.getString("user_id"));
				orderVO.setSeller_id(rs.getString("seller_id"));
				orderVO.setSrating(rs.getInt("srating"));
				orderVO.setSrating_content(rs.getString("srating_content"));
				orderVO.setPoint(rs.getInt("point"));
				orderVO.setCity(rs.getString("City"));
				orderVO.setTown(rs.getString("Town"));
				orderVO.setZipcode(rs.getString("zipcode"));
				list.add(orderVO); // Store the row in the list
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
	public List<OrderVO> getAllByID2(String seller_id) {
		List<OrderVO> list = new ArrayList<OrderVO>();
		OrderVO orderVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ORDER_BY_ID2);
			pstmt.setString(1, seller_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				orderVO = new OrderVO();
				orderVO.setOrder_no(rs.getInt("order_no"));
				orderVO.setOrder_date(rs.getTimestamp("order_date"));
				orderVO.setOrder_state(rs.getInt("order_state"));
				orderVO.setOrder_shipping(rs.getInt("order_shipping"));
				orderVO.setOrder_price(rs.getInt("order_price"));
				orderVO.setPay_method(rs.getInt("pay_method"));
				orderVO.setPay_deadline(rs.getTimestamp("pay_deadline"));
				orderVO.setRec_name(rs.getString("rec_name"));
				orderVO.setRec_addr(rs.getString("rec_addr"));
				orderVO.setRec_phone(rs.getString("rec_phone"));
				orderVO.setRec_cellphone(rs.getString("rec_cellphone"));
				orderVO.setLogistics(rs.getInt("logistics"));
				orderVO.setLogisticsstate(rs.getInt("logisticsstate"));
				orderVO.setDiscount(rs.getInt("discount"));
				orderVO.setUser_id(rs.getString("user_id"));
				orderVO.setSeller_id(rs.getString("seller_id"));
				orderVO.setSrating(rs.getInt("srating"));
				orderVO.setSrating_content(rs.getString("srating_content"));
				orderVO.setPoint(rs.getInt("point"));
				orderVO.setCity(rs.getString("City"));
				orderVO.setTown(rs.getString("Town"));
				orderVO.setZipcode(rs.getString("zipcode"));
				list.add(orderVO); // Store the row in the list
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
	public void updateShipped(List <Integer> list) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_SHIPPED);

			for (Integer order_no  : list) {
				pstmt.setInt(1, order_no);
				pstmt.addBatch();
			}
			
			pstmt.executeBatch();

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
	public void updateUnshipped(List <Integer> list) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_UNSHIPPED);

			for (Integer order_no  : list) {
				pstmt.setInt(1, order_no);
				pstmt.addBatch();
			}
			
			pstmt.executeBatch();

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
	public Object insert2(OrderVO orderVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(INSERT_STMT2,PreparedStatement.RETURN_GENERATED_KEYS);

			pstmt.setInt(1, orderVO.getOrder_state());
			pstmt.setInt(2, orderVO.getOrder_shipping());			
			pstmt.setInt(3, orderVO.getOrder_price());
			pstmt.setInt(4, orderVO.getPay_method());
			pstmt.setString(5, orderVO.getRec_name());
			pstmt.setString(6, orderVO.getZipcode());
			pstmt.setString(7, orderVO.getCity());
			pstmt.setString(8, orderVO.getTown());
			pstmt.setString(9, orderVO.getRec_addr());
			pstmt.setString(10, orderVO.getRec_phone());
			pstmt.setString(11, orderVO.getRec_cellphone());
			pstmt.setInt(12, orderVO.getLogistics());
			pstmt.setInt(13, orderVO.getDiscount());
			pstmt.setString(14, orderVO.getUser_id());
			pstmt.setString(15, orderVO.getSeller_id());
			pstmt.setInt(16, orderVO.getPoint());
		
			pstmt.executeUpdate();
			
			ResultSet rs = pstmt.getGeneratedKeys();
			rs.next();
			Integer order_no = rs.getInt(1);
			orderVO.setOrder_no(order_no);
			con.commit();
			// Handle any SQL errors
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
		}return orderVO;
	}
	@Override
	public void updateSrating(OrderVO orderVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_SRATING);

			pstmt.setInt(1, orderVO.getSrating());
			pstmt.setString(2, orderVO.getSrating_content());
			pstmt.setInt(3, orderVO.getLogisticsstate());
			pstmt.setInt(4, orderVO.getOrder_no());

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
	public void insertWithOrderList(OrderVO orderVO, List<Order_detailVO> list) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			String cols[] = {"ORDER_NO"};
			pstmt = con.prepareStatement(INSERT_STMT2,cols);
			
			pstmt.setInt(1, orderVO.getOrder_state());
			pstmt.setInt(2, orderVO.getOrder_shipping());
			pstmt.setInt(3, orderVO.getOrder_price());
			pstmt.setInt(4, orderVO.getPay_method());
			pstmt.setString(5, orderVO.getRec_name());
			pstmt.setString(6, orderVO.getZipcode());
			pstmt.setString(7, orderVO.getCity());
			pstmt.setString(8, orderVO.getTown());
			pstmt.setString(9, orderVO.getRec_addr());
			pstmt.setString(10, orderVO.getRec_phone());
			pstmt.setString(11, orderVO.getRec_cellphone());
			pstmt.setInt(12, orderVO.getLogistics());
			pstmt.setInt(13, orderVO.getDiscount());
			pstmt.setString(14, orderVO.getUser_id());
			pstmt.setString(15, orderVO.getSeller_id());
			pstmt.setInt(16, orderVO.getPoint());
			
			pstmt.executeUpdate();
			String next_No = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_No = rs.getString(1);
				System.out.println("自增主鍵值= " + next_No +"(剛新增成功的訂單編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
			
			Order_detailDAO dao = new Order_detailDAO();
			System.out.println("list.size()-A="+list.size());
			for (Order_detailVO aDetail : list) {
				aDetail.setOrder_no(new Integer(next_No)) ;
				dao.insert2(aDetail,con);
			}
			
			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			
			System.out.println("list.size()-B="+list.size());
			System.out.println("新增訂單編號" + next_No + "時,共有明細" + list.size()
			+ "筆同時被新增");
			
			// Handle any driver errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	public Set<Order_detailVO> getDetailsByNo(Integer order_no) {
		Set<Order_detailVO> set = new LinkedHashSet<Order_detailVO>();
		Order_detailVO order_detailVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_Details_ByNo_STMT);
			pstmt.setInt(1, order_no);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				order_detailVO = new Order_detailVO();
				order_detailVO.setOrder_no(rs.getInt("order_no"));
				order_detailVO.setProduct_no(rs.getInt("product_no"));
				order_detailVO.setProduct_num(rs.getInt("product_num"));
				order_detailVO.setOrder_price(rs.getInt("order_price"));
				set.add(order_detailVO); // Store the row in the vector
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
		return set;
	}

	@Override
	public void cancel(Integer order_no) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(CANCEL);

			pstmt.setInt(1, 2);
			pstmt.setInt(2, order_no);

			pstmt.executeUpdate();

			Order_detailDAO dao = new Order_detailDAO();
			dao.delete(order_no);
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

}
