package com.message.model;
import java.sql.Date;

public class MessageVO implements java.io.Serializable{
	private Integer message_no;
	private String user_id;
	private String content;
	private String seller_id;
	private Date message_time;
	
	public Integer getMessage_no() {
		return message_no;
	}
	public void setMessage_no(Integer message_no) {
		this.message_no = message_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(String seller_id) {
		this.seller_id = seller_id;
	}
	public Date getMessage_time() {
		return message_time;
	}
	public void setMessage_time(Date message_time) {
		this.message_time = message_time;
	}
	
	
}
