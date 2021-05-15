package com.live.model;

import java.sql.Date;
import java.sql.Timestamp;

public class LiveVO implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private Integer live_no;
	private String live_type;
	private String live_name;
	private Timestamp live_time;
	private Integer live_state;
	private String user_id;
	private Integer empno;
	private byte[] live_photo;
	private String live_id;

	public Integer getLive_no() {
		return live_no;
	}

	public void setLive_no(Integer live_no) {
		this.live_no = live_no;
	}

	public String getLive_type() {
		return live_type;
	}

	public void setLive_type(String live_type) {
		this.live_type = live_type;
	}

	public String getLive_name() {
		return live_name;
	}

	public void setLive_name(String live_name) {
		this.live_name = live_name;
	}

	public Timestamp getLive_time() {
		return live_time;
	}

	public void setLive_time(Timestamp live_time) {
		this.live_time = live_time;
	}

	public Integer getLive_state() {
		return live_state;
	}

	public void setLive_state(Integer live_state) {
		this.live_state = live_state;
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

	public byte[] getLive_photo() {
		return live_photo;
	}

	public void setLive_photo(byte[] live_photo) {
		this.live_photo = live_photo;
	}

	public String getLive_id() {
		return live_id;
	}

	public void setLive_id(String live_id) {
		this.live_id = live_id;
	}

}
