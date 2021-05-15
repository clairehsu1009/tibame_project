package com.liveBid.websocket.model;

public class MaxVO {

	private String type;
	private String sender;
	private String live_no;
	private String user_id;
	private String maxPrice;
	private String product_no;
	private String timeStart;
	private String lastTime;

	public MaxVO(String type, String sender, String live_no, String user_id, String maxPrice, String product_no,
			String timeStart, String lastTime) {
		super();
		this.type = type;
		this.sender = sender;
		this.live_no = live_no;
		this.user_id = user_id;
		this.maxPrice = maxPrice;
		this.product_no = product_no;
		this.timeStart = timeStart;
		this.lastTime = lastTime;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getLive_no() {
		return live_no;
	}

	public void setLive_no(String live_no) {
		this.live_no = live_no;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getMaxPrice() {
		return maxPrice;
	}

	public void setMaxPrice(String maxPrice) {
		this.maxPrice = maxPrice;
	}

	public String getProduct_no() {
		return product_no;
	}

	public void setProduct_no(String product_no) {
		this.product_no = product_no;
	}

	public String getTimeStart() {
		return timeStart;
	}

	public void setTimeStart(String timeStart) {
		this.timeStart = timeStart;
	}

	public String getLastTime() {
		return lastTime;
	}

	public void setLastTime(String lastTime) {
		this.lastTime = lastTime;
	}

}
