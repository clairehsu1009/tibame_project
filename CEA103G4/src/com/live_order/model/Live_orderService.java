package com.live_order.model;

import java.util.List;
import java.util.Set;

import com.live.model.LiveVO;
import com.live_order_detail.model.Live_order_detailVO;

public class Live_orderService {
	private Live_orderDAO_interface dao;

	public Live_orderService() {
		dao = new Live_orderJNDIDAO();
	}

	public Live_orderVO addLive_order( Integer order_state, Integer order_shipping,
			Integer order_price, Integer pay_method, String rec_name, String rec_addr,
			String rec_phone, String rec_cellphone, Integer logistics, Integer logistics_state, Integer discount,
			Integer live_no, String user_id, String seller_id, Integer srating, String srating_content, Integer point,String city,String town,Integer zipcode) {

		Live_orderVO live_orderVO = new Live_orderVO();

//		live_orderVO.setOrder_date(order_date);
		live_orderVO.setOrder_state(order_state);
		live_orderVO.setOrder_shipping(order_shipping);
		live_orderVO.setOrder_price(order_price);
		live_orderVO.setPay_method(pay_method);
//		live_orderVO.setPay_deadline(pay_deadline);
		live_orderVO.setRec_name(rec_name);
		live_orderVO.setRec_addr(rec_addr);
		live_orderVO.setRec_phone(rec_phone);
		live_orderVO.setRec_cellphone(rec_cellphone);
		live_orderVO.setLogistics(logistics);
		live_orderVO.setLogistics_state(logistics_state);
		live_orderVO.setDiscount(discount);
		live_orderVO.setLive_no(live_no);
		live_orderVO.setUser_id(user_id);
		live_orderVO.setSeller_id(seller_id);
		live_orderVO.setSrating(srating);
		live_orderVO.setSrating_content(srating_content);
		live_orderVO.setPoint(point);
		live_orderVO.setCity(city);
		live_orderVO.setTown(town);
		live_orderVO.setZipcode(zipcode);

		dao.insert(live_orderVO);

		return live_orderVO;

	}

	public Live_orderVO updateLive_order(java.sql.Timestamp order_date, Integer order_state, Integer order_shipping,
			Integer order_price, Integer pay_method, java.sql.Timestamp pay_deadline, String rec_name, String rec_addr,
			String rec_phone, String rec_cellphone, Integer logistics, Integer logistics_state, Integer discount,
			Integer live_no, String user_id, String seller_id, Integer srating, String srating_content, Integer point,
			String city,String town,Integer zipcode,Integer live_order_no) {

		Live_orderVO live_orderVO = new Live_orderVO();

		live_orderVO.setOrder_date(order_date);
		live_orderVO.setOrder_state(order_state);
		live_orderVO.setOrder_shipping(order_shipping);
		live_orderVO.setOrder_price(order_price);
		live_orderVO.setPay_method(pay_method);
		live_orderVO.setPay_deadline(pay_deadline);
		live_orderVO.setRec_name(rec_name);
		live_orderVO.setRec_addr(rec_addr);
		live_orderVO.setRec_phone(rec_phone);
		live_orderVO.setRec_cellphone(rec_cellphone);
		live_orderVO.setLogistics(logistics);
		live_orderVO.setLogistics_state(logistics_state);
		live_orderVO.setDiscount(discount);
		live_orderVO.setLive_no(live_no);
		live_orderVO.setUser_id(user_id);
		live_orderVO.setSeller_id(seller_id);
		live_orderVO.setSrating(srating);
		live_orderVO.setSrating_content(srating_content);
		live_orderVO.setPoint(point);
		live_orderVO.setCity(city);
		live_orderVO.setTown(town);
		live_orderVO.setZipcode(zipcode);
		live_orderVO.setLive_order_no(live_order_no);

		dao.update(live_orderVO);

		return live_orderVO;

	}

	public void deleteLive_order(Integer live_order_no) {
		dao.delete(live_order_no);
	}

	public Live_orderVO getOneLive_order(Integer live_order_no) {
		return dao.findByPrimaryKey(live_order_no);
	}

	public List<Live_orderVO> getAll() {
		return dao.getAll();
	}
	
	public Set<Live_order_detailVO> getDetailsByNo(Integer live_order_no){
		return dao.getDetailsByNo(live_order_no);
	}

	public List<Live_orderVO> getAllByID(String user_id) {
		return dao.getAllByID(user_id);
	}
	
	public List<Live_orderVO> getAllByID2(String seller_id) {
		return dao.getAllByID2(seller_id);
	}
	
	public void updateShipment(List<Live_orderVO> live_order_no){
		dao.updateShipment(live_order_no);
	}
	
	public void insertWithDetails (Live_orderVO live_orderVO,List<Live_order_detailVO> list) {
		dao.insertWithDetails(live_orderVO, list);
	}
}
