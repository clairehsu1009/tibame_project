package com.customer_service.model;

import java.io.Serializable;
import java.sql.Date;

public class CustomerSerVO implements Serializable{
	private Integer caseno;
	private String	userid;
	private String content;
	private Integer caseState;
	private Integer empno;
	private String empResponse;
	private Date caseTime;
	public Integer getCaseno() {
		return caseno;
	}
	public void setCaseno(Integer caseno) {
		this.caseno = caseno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getCaseState() {
		return caseState;
	}
	public void setCaseState(Integer caseState) {
		this.caseState = caseState;
	}
	public Integer getEmpno() {
		return empno;
	}
	public void setEmpno(Integer empno) {
		this.empno = empno;
	}
	public String getEmpResponse() {
		return empResponse;
	}
	public void setEmpResponse(String empResponse) {
		this.empResponse = empResponse;
	}
	public Date getCaseTime() {
		return caseTime;
	}
	public void setCaseTime(Date caseTime) {
		this.caseTime = caseTime;
	}
	
	
}
