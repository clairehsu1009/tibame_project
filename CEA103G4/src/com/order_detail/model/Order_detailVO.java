package com.order_detail.model;
import java.sql.Date;

public class Order_detailVO implements java.io.Serializable{
	private Integer Order_no;
	private Integer Product_no;
	private Integer Product_num;
	private Integer Order_price;
	
	public Integer getOrder_no() {
		return Order_no;
	}
	public void setOrder_no(Integer order_no) {
		Order_no = order_no;
	}
	public Integer getProduct_no() {
		return Product_no;
	}
	public void setProduct_no(Integer product_no) {
		Product_no = product_no;
	}
	public Integer getProduct_num() {
		return Product_num;
	}
	public void setProduct_num(Integer product_num) {
		Product_num = product_num;
	}
	public Integer getOrder_price() {
		return Order_price;
	}
	public void setOrder_price(Integer order_price) {
		Order_price = order_price;
	}
	
	
}
