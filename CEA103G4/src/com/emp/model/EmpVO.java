package com.emp.model;

import java.io.Serializable;
import java.sql.Date;

public class EmpVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -9191334111533849001L;
	private Integer empno;
	private String ename;
	private String job;
	private String id;
	private Integer gender;
	private Date dob;
	private String addr;
	private String email;
	private Double sal;
	private Integer state;
	private Date hiredate;
	private String emp_pwd;
	private String city;
	private String dist;
	private String link;
	
	@Override
	public String toString() {
		return "EmpVO [empno=" + empno + ", ename=" + ename + ", job=" + job + ", id=" + id + ", gender=" + gender
				+ ", dob=" + dob + ", addr=" + addr + ", email=" + email + ", sal=" + sal + ", state=" + state
				+ ", hiredate=" + hiredate + ", emp_pwd=" + emp_pwd + ", city=" + city + ", dist=" + dist + ", link="
				+ link + "]";
	}

	public EmpVO() {
		super();

	}

	public EmpVO(Integer empno, String ename, String job, String id, Integer gender, Date dob, String addr,
			String email, Double sal, Integer state, Date hiredate, String emp_pwd, String city, String dist,
			String link) {
		super();
		this.empno = empno;
		this.ename = ename;
		this.job = job;
		this.id = id;
		this.gender = gender;
		this.dob = dob;
		this.addr = addr;
		this.email = email;
		this.sal = sal;
		this.state = state;
		this.hiredate = hiredate;
		this.emp_pwd = emp_pwd;
		this.city = city;
		this.dist = dist;
		this.link = link;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDist() {
		return dist;
	}

	public void setDist(String dist) {
		this.dist = dist;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getEmpno() {
		return empno;
	}

	public void setEmpno(Integer empno) {
		this.empno = empno;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public Double getSal() {
		return sal;
	}

	public void setSal(Double sal) {
		this.sal = sal;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Date getHiredate() {
		return hiredate;
	}

	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}

	public String getEmp_pwd() {

		return emp_pwd;
	}

	public void setEmp_pwd(String empPwd) {
		this.emp_pwd = empPwd;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

}
