package com.bid.model;

public class BidVO {
	private Integer bid_no;
	private String user_id;
	private Integer product_no;
	private Integer bid_price;
	public Integer getBid_no() {
		return bid_no;
	}
	public void setBid_no(Integer bid_no) {
		this.bid_no = bid_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Integer getProduct_no() {
		return product_no;
	}
	public void setProduct_no(Integer product_no) {
		this.product_no = product_no;
	}
	public Integer getBid_price() {
		return bid_price;
	}
	public void setBid_price(Integer bid_price) {
		this.bid_price = bid_price;
	}
}
