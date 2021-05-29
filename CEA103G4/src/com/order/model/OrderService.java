package com.order.model;

//import java.sql.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.live_order.model.Live_orderVO;
import com.live_order_detail.model.Live_order_detailVO;
import com.order_detail.model.Order_detailVO;

public class OrderService {

	private OrderDAO_interface dao;

	public OrderService() {
		dao = new OrderJNDIDAO();
	}

	public OrderVO addOrder(Integer order_state, Integer order_shipping,  Integer order_price, Integer pay_method, String rec_name, String zipcode, String city, String town,  String rec_addr, String rec_phone, String rec_cellphone, Integer logistics, Integer logisticsstate, Integer discount, String user_id, String seller_id, Integer srating, String srating_content, Integer point) {

		OrderVO orderVO = new OrderVO();

		orderVO.setOrder_state(order_state);
		orderVO.setOrder_shipping(order_shipping);
		orderVO.setOrder_price(order_price);
		orderVO.setPay_method(pay_method);
		orderVO.setRec_name(rec_name);
		orderVO.setZipcode(zipcode);
		orderVO.setCity(city);
		orderVO.setTown(town);
		orderVO.setRec_addr(rec_addr);
		orderVO.setRec_phone(rec_phone);
		orderVO.setRec_cellphone(rec_cellphone);
		orderVO.setLogistics(logistics);
		orderVO.setLogisticsstate(logisticsstate);
		orderVO.setDiscount(discount);
		orderVO.setUser_id(user_id);
		orderVO.setSeller_id(seller_id);
		orderVO.setSrating(srating);
		orderVO.setSrating_content(srating_content);
		orderVO.setPoint(point);
		
		dao.insert(orderVO);

		return orderVO;
	}

	public OrderVO updateOrder(java.sql.Timestamp order_date, Integer order_state, Integer order_shipping,  Integer order_price, Integer pay_method, java.sql.Timestamp pay_deadline, String rec_name, String zipcode, String city, String town, String rec_addr, String rec_phone, String rec_cellphone, Integer logistics, Integer logisticsstate, Integer discount, String user_id, String seller_id, Integer srating, String srating_content, Integer point, Integer order_no) 
	{
		OrderVO orderVO = new OrderVO();
		
		orderVO.setOrder_date(order_date);
		orderVO.setOrder_state(order_state);
		orderVO.setOrder_shipping(order_shipping);
		orderVO.setOrder_price(order_price);
		orderVO.setPay_method(pay_method);
		orderVO.setPay_deadline(pay_deadline);
		orderVO.setRec_name(rec_name);
		orderVO.setZipcode(zipcode);
		orderVO.setCity(city);
		orderVO.setTown(town);
		orderVO.setRec_addr(rec_addr);
		orderVO.setRec_phone(rec_phone);
		orderVO.setRec_cellphone(rec_cellphone);
		orderVO.setLogistics(logistics);
		orderVO.setLogisticsstate(logisticsstate);
		orderVO.setDiscount(discount);
		orderVO.setUser_id(user_id);
		orderVO.setSeller_id(seller_id);
		orderVO.setSrating(srating);
		orderVO.setSrating_content(srating_content);
		orderVO.setPoint(point);
		orderVO.setOrder_no(order_no);
		
		dao.update(orderVO);
		return orderVO;
	}
	
	public OrderVO updateSrating(Integer srating, String srating_content,Integer logisticsstate , Integer order_no) {
		
		OrderVO orderVO = new OrderVO();
		
		orderVO.setSrating(srating);
		orderVO.setSrating_content(srating_content);
		orderVO.setLogisticsstate(logisticsstate);
		orderVO.setOrder_no(order_no);
		
		dao.updateSrating(orderVO);
		return orderVO;
	}
	
	public OrderVO addOrderList(Integer order_state, Integer order_shipping,  Integer order_price, Integer pay_method, String rec_name, String zipcode, String city, String town,  String rec_addr, String rec_phone, String rec_cellphone, Integer logistics, Integer discount, String user_id, String seller_id, Integer point) {

		OrderVO orderVO = new OrderVO();
		System.out.println("check OrderService");
		orderVO.setOrder_state(order_state);
		orderVO.setOrder_shipping(order_shipping);
		orderVO.setOrder_price(order_price);
		orderVO.setPay_method(pay_method);
		orderVO.setRec_name(rec_name);
		orderVO.setZipcode(zipcode);
		orderVO.setCity(city);
		orderVO.setTown(town);
		orderVO.setRec_addr(rec_addr);
		orderVO.setRec_phone(rec_phone);
		orderVO.setRec_cellphone(rec_cellphone);
		orderVO.setLogistics(logistics);
		orderVO.setDiscount(discount);
		orderVO.setUser_id(user_id);
		orderVO.setSeller_id(seller_id);
		orderVO.setPoint(point);
		
		dao.insert2(orderVO);

		return orderVO;
	}
	public Set<Order_detailVO> getDetailsByNo(Integer order_no){
		return dao.getDetailsByNo(order_no);
	}
	
	public void deleteOrder(Integer order_no) {
		dao.delete(order_no);
	}
	public void cancelOrder(Integer order_no) {
		dao.cancel(order_no);
	}

	public OrderVO getOneOrder(Integer order_no) {
		return dao.findByPrimaryKey(order_no);
	}

	public List<OrderVO> getAll() {
		return dao.getAll();
	}
	public List<OrderVO> getAllByID(String user_id) {
		return dao.getAllByID(user_id);
	}
	public List<OrderVO> getAllByID2(String seller_id) {
		return dao.getAllByID2(seller_id);
	}
	public void updateShipped(List<Integer> list){
		dao.updateShipped(list);
		
	}
	public void updateUnshipped(List<Integer> list){
		dao.updateUnshipped(list);
		
	}
	public void insertWithDetails (OrderVO orderVO,List<Order_detailVO> list) {
		dao.insertWithOrderList(orderVO, list);
	}
	
}
