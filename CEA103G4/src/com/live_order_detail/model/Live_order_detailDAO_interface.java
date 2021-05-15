package com.live_order_detail.model;

import java.util.List;

import com.live_order.model.Live_orderVO;

public interface Live_order_detailDAO_interface {
    public void insert(Live_order_detailVO live_order_detailVO);
    public void update(Live_order_detailVO live_order_detailVO);
    public void delete(Integer live_order_no,Integer product_no);
    public Live_order_detailVO findByPrimaryKey(Integer live_order_no,Integer product_no);
    public List<Live_order_detailVO> getAll();
    public void insert2 (Live_order_detailVO live_order_detailVO , java.sql.Connection con);
}
