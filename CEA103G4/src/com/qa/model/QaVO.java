package com.qa.model;

import java.io.Serializable;
import java.sql.Date;

public class QaVO implements Serializable{
	
	private Integer qa_no;
	private Integer empno;
	private Date qa_date;
	private Integer qa_type;
	private String question; 
	private String answer;
	
	public Integer getQa_no() {
		return qa_no;
	}
	public void setQa_no(Integer qa_no) {
		this.qa_no = qa_no;
	}
	public Integer getEmpno() {
		return empno;
	}
	public void setEmpno(Integer empno) {
		this.empno = empno;
	}
	public Date getQa_date() {
		return qa_date;
	}
	public void setQa_date(Date qa_date) {
		this.qa_date = qa_date;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public Integer getQa_type() {
		return qa_type;
	}
	public void setQa_type(Integer qa_type) {
		this.qa_type = qa_type;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	
	
}
