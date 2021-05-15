package com.liveBid.websocket.model;

public class BidVO {
	private String type;
	private String sender;
	private String live_no;
	private String product_no;
	private String message;

	public BidVO(String type, String sender, String live_no, String product_no, String message) {
		super();
		this.type = type;
		this.sender = sender;
		this.live_no = live_no;
		this.product_no = product_no;
		this.message = message;
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

	public String getProduct_no() {
		return product_no;
	}

	public void setProduct_no(String product_no) {
		this.product_no = product_no;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
