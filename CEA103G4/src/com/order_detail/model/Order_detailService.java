package com.order_detail.model;

import java.util.List;

public class Order_detailService {

	private Order_detailDAO_interface dao;

	public Order_detailService() {
		dao = new Order_detailDAO();
	}

	public Order_detailVO addOrder_detail(Integer order_no, Integer product_no, Integer product_num,Integer order_price) 
	{

		Order_detailVO order_detailVO = new Order_detailVO();
		order_detailVO.setOrder_no(order_no);
		order_detailVO.setProduct_no(product_no);
		order_detailVO.setProduct_num(product_num);
		order_detailVO.setOrder_price(order_price);
		dao.insert(order_detailVO);

		return order_detailVO;
	}

	public Order_detailVO updateOrder_detail(Integer order_no, Integer product_no, Integer product_num,Integer order_price) 
	{

		Order_detailVO order_detailVO = new Order_detailVO();
		order_detailVO.setOrder_no(order_no);
		order_detailVO.setProduct_no(product_no);
		order_detailVO.setProduct_num(product_num);
		order_detailVO.setOrder_price(order_price);
		dao.update(order_detailVO);

		return order_detailVO;
	}

	public void deleteOrder_detail(Integer order_no) {
		dao.delete(order_no);
	}

	public Order_detailVO getOneOrder_detail(Integer order_no) {
		return dao.findByPrimaryKey(order_no);
	}

	public List<Order_detailVO> getAll() {
		return dao.getAll();
	}
}
