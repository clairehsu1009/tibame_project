package com.auth.model;

public class AuthVO	implements java.io.Serializable {
	private Integer funno;
	private Integer empno;
	private Integer auth_no;
	
	public AuthVO() {
		super();
	}

	public AuthVO(Integer funno, Integer empno, Integer auth_no) {
		this.funno = funno;
		this.empno = empno;
		this.auth_no = auth_no;
	}

	public Integer getFunno() {
		return funno;
	}

	public void setFunno(Integer funno) {
		this.funno = funno;
	}

	public Integer getEmpno() {
		return empno;
	}

	public void setEmpno(Integer empno) {
		this.empno = empno;
	}

	public Integer getAuth_no() {
		return auth_no;
	}

	public void setAuth_no(Integer auth_no) {
		this.auth_no = auth_no;
	}

}
