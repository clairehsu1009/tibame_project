package com.ad.model;

import java.io.Serializable;
import java.sql.Date;

public class AdVO implements Serializable{
	
	private Integer ad_no;
	private Integer empno;
	private String ad_content;
	private byte[] ad_photo;
	private Integer ad_state;
	private Date ad_start_date;
	private Date ad_end_date;
	private String ad_url;
	
	public Integer getAd_no() {
		return ad_no;
	}
	public void setAd_no(Integer ad_no) {
		this.ad_no = ad_no;
	}
	public Integer getEmpno() {
		return empno;
	}
	public void setEmpno(Integer empno) {
		this.empno = empno;
	}
	public String getAd_content() {
		return ad_content;
	}
	public void setAd_content(String ad_content) {
		this.ad_content = ad_content;
	}
	public byte[] getAd_photo() {
		return ad_photo;
	}
	public void setAd_photo(byte[] ad_photo) {
		this.ad_photo = ad_photo;
	}
	public Integer getAd_state() {
		return ad_state;
	}
	public void setAd_state(Integer ad_state) {
		this.ad_state = ad_state;
	}
	public Date getAd_start_date() {
		return ad_start_date;
	}
	public void setAd_start_date(Date ad_start_date) {
		this.ad_start_date = ad_start_date;
	}
	public Date getAd_end_date() {
		return ad_end_date;
	}
	public void setAd_end_date(Date ad_end_date) {
		this.ad_end_date = ad_end_date;
	}
	public String getAd_url() {
		return ad_url;
	}
	public void setAd_url(String ad_url) {
		this.ad_url = ad_url;
	}
	
}
