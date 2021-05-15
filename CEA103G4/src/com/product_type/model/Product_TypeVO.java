package com.product_type.model;

public class Product_TypeVO implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private Integer pdtype_no;
	private String pdtype_name;
	
	public Integer getPdtype_no() {
		return pdtype_no;
	}
	public void setPdtype_no(Integer pdtype_no) {
		this.pdtype_no = pdtype_no;
	}
	public String getPdtype_name() {
		return pdtype_name;
	}
	public void setPdtype_name(String pdtype_name) {
		this.pdtype_name = pdtype_name;
	}

	
}
