package com.fun.model;

import java.io.Serializable;

public class FunVO implements Serializable{
	private Integer funno;
	private String fun_name;
	private Integer state;
	
	
	
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getFunno() {
		return funno;
	}
	public void setFunno(Integer funno) {
		this.funno = funno;
	}
	public String getFunName() {
		return fun_name;
	}
	public void setFunName(String funName) {
		this.fun_name = funName;
	}
	
}
