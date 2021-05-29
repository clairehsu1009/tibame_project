package com.product.model;
import java.sql.Blob;
import java.sql.Date;
import java.util.Arrays;


public class ProductVO implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	
	private Integer product_no;
	private String product_name;
	private String product_info;
	private Integer product_price;
	private Integer product_quantity;
	private Integer product_remaining;
	private Integer product_sold;
	private Integer product_state;
	private byte[] product_photo;
	private String user_id;
	private Integer pdtype_no;
	private Integer start_price;
	private Integer live_no;
	
	public ProductVO() {
		// TODO Auto-generated constructor stub
	}
	
	public Integer getProduct_no() {
		return product_no;
	}
	public void setProduct_no(Integer product_no) {
		this.product_no = product_no;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_info() {
		return product_info;
	}
	public void setProduct_info(String product_info) {
		this.product_info = product_info;
	}
	public Integer getProduct_price() {
		return product_price;
	}
	public void setProduct_price(Integer product_price) {
		this.product_price = product_price;
	}
	public Integer getProduct_quantity() {
		return product_quantity;
	}
	public void setProduct_quantity(Integer product_quantity) {
		this.product_quantity = product_quantity;
	}
	public Integer getProduct_remaining() {
		return product_remaining;
	}
	public void setProduct_remaining(Integer product_remaining) {
		this.product_remaining = product_remaining;
	}
	public Integer getProduct_sold() {
		return product_sold;
	}
	public void setProduct_sold(Integer product_sold) {
		this.product_sold = product_sold;
	}
	public Integer getProduct_state() {
		return product_state;
	}
	public void setProduct_state(Integer product_state) {
		this.product_state = product_state;
	}
	public byte[] getProduct_photo() {
		return product_photo;
	}
	public void setProduct_photo(byte[] product_photo) {
		this.product_photo = product_photo;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Integer getPdtype_no() {
		return pdtype_no;
	}
	public void setPdtype_no(Integer pdtype_no) {
		this.pdtype_no = pdtype_no;
	}
	public Integer getStart_price() {
		return start_price;
	}
	public void setStart_price(Integer start_price) {
		this.start_price = start_price;
	}
	public Integer getLive_no() {
		return live_no;
	}
	public void setLive_no(Integer live_no) {
		this.live_no = live_no;
	}
	
	public ProductVO(Integer product_no, String product_name, String product_info, Integer product_price,
			Integer product_quantity, Integer product_remaining, Integer product_state, byte[] product_photo,
			String user_id, Integer pdtype_no, Integer start_price, Integer live_no) {
		
		this.product_no = product_no;
		this.product_name = product_name;
		this.product_info = product_info;
		this.product_price = product_price;
		this.product_quantity = product_quantity;
		this.product_remaining = product_remaining;
		this.product_state = product_state;
		this.product_photo = product_photo;
		this.user_id = user_id;
		this.pdtype_no = pdtype_no;
		this.start_price = start_price;
		this.live_no = live_no;
	}
	
	@Override
	public String toString() {
		return "ProductVO [product_no=" + product_no + ", product_name=" + product_name + ", product_price="
				+ product_price + ", product_quantity=" + product_quantity + ", product_remaining=" + product_remaining + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((product_name == null) ? 0 : product_name.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ProductVO other = (ProductVO) obj;
		if (product_name == null) {
			if (other.product_name != null)
				return false;
		} else if (!product_name.equals(other.product_name))
			return false;
		return true;
	}
	
//	public void printSummary() {
//		System.out.printf("product_no: " + product_no + " product_name: " + product_name);
//	}

	
}
