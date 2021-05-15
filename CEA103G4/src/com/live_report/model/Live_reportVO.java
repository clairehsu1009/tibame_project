package com.live_report.model;

import java.sql.Timestamp;

public class Live_reportVO {
	private Integer live_report_no;
	private String live_report_content;
	private Integer live_no;
	private String user_id;
	private Integer empno;
	private Integer live_report_state;
	private Timestamp report_date;
	private byte[] photo;
	public Integer getLive_report_no() {
		return live_report_no;
	}
	public void setLive_report_no(Integer live_report_no) {
		this.live_report_no = live_report_no;
	}
	public String getLive_report_content() {
		return live_report_content;
	}
	public void setLive_report_content(String live_report_content) {
		this.live_report_content = live_report_content;
	}
	public Integer getLive_no() {
		return live_no;
	}
	public void setLive_no(Integer live_no) {
		this.live_no = live_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Integer getEmpno() {
		return empno;
	}
	public void setEmpno(Integer empno) {
		this.empno = empno;
	}
	public Integer getLive_report_state() {
		return live_report_state;
	}
	public void setLive_report_state(Integer live_report_state) {
		this.live_report_state = live_report_state;
	}
	public Timestamp getReport_date() {
		return report_date;
	}
	public void setReport_date(Timestamp report_date) {
		this.report_date = report_date;
	}
	public byte[] getPhoto() {
		return photo;
	}
	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}
	
	
}
