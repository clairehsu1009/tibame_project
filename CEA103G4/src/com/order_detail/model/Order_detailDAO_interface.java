package com.order_detail.model;

import java.util.List;

import com.notice.model.NoticeVO;

public interface Order_detailDAO_interface {
	public void insert(Order_detailVO order_detailVO);
	public void update(Order_detailVO order_detailVO);
	public void delete(Integer Order_detailVO);
	public Order_detailVO findByPrimaryKey(Integer Order_detailVO);
	public List<Order_detailVO> getAll();
	
}