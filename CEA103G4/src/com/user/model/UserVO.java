package com.user.model;

import java.io.Serializable;
import java.sql.Date;

public class UserVO implements Serializable{
	private String user_id;
	private String user_pwd;
	private String user_name;
	private String id_card;
	private String user_gender;
	private Date user_dob;
	private String user_mail;
	private String user_phone;
	private String user_mobile;
	private String city;
	private String town;
	private Integer zipcode;
	private String user_addr;
	private Date regdate;
	private Integer user_point;
	private Integer violation;
	private Integer user_state;
	private Integer user_comment;
	private Integer comment_total;
	private Integer cash;
	private byte[] user_pic;
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getId_card() {
		return id_card;
	}
	public void setId_card(String id_card) {
		this.id_card = id_card;
	}
	public String getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}
	public Date getUser_dob() {
		return user_dob;
	}
	public void setUser_dob(Date user_dob) {
		this.user_dob = user_dob;
	}
	public String getUser_mail() {
		return user_mail;
	}
	public void setUser_mail(String user_mail) {
		this.user_mail = user_mail;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_mobile() {
		return user_mobile;
	}
	public void setUser_mobile(String user_mobile) {
		this.user_mobile = user_mobile;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getTown() {
		return town;
	}
	public void setTown(String town) {
		this.town = town;
	}
	public Integer getZipcode() {
		return zipcode;
	}
	public void setZipcode(Integer zipcode) {
		this.zipcode = zipcode;
	}
	public String getUser_addr() {
		return user_addr;
	}
	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Integer getUser_point() {
		return user_point;
	}
	public void setUser_point(Integer user_point) {
		this.user_point = user_point;
	}
	public Integer getViolation() {
		return violation;
	}
	public void setViolation(Integer violation) {
		this.violation = violation;
	}
	public Integer getUser_state() {
		return user_state;
	}
	public void setUser_state(Integer user_state) {
		this.user_state = user_state;
	}
	public Integer getUser_comment() {
		return user_comment;
	}
	public void setUser_comment(Integer user_comment) {
		this.user_comment = user_comment;
	}
	public Integer getComment_total() {
		return comment_total;
	}
	public void setComment_total(Integer comment_total) {
		this.comment_total = comment_total;
	}
	public Integer getCash() {
		return cash;
	}
	public void setCash(Integer cash) {
		this.cash = cash;
	}
	public byte[] getUser_pic() {
		return user_pic;
	}
	public void setUser_pic(byte[] user_pic) {
		this.user_pic = user_pic;
	}
	
	

}
