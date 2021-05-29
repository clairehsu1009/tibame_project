package com.order_detail.model;

import java.sql.Connection;
import java.util.List;

import com.notice.model.NoticeVO;

public interface Order_detailDAO_interface {
	public void insert(Order_detailVO order_detailVO);
	public void update(Order_detailVO order_detailVO);
	public void delete(Integer Order_detailVO);
	public List<Order_detailVO> findByPrimaryKey(Integer Order_detailVO);
	public List<Order_detailVO> getAll();
	public void insert2(Order_detailVO order_detailVO,Connection con);
	List<Order_detailVO> getAllByNo(Integer order_no);
}