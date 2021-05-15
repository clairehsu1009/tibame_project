package com.customer_service.model;

import java.util.List;


public interface CustomerDAO_interface {
	public void insert(CustomerSerVO customerSerVO);
	public void update(CustomerSerVO customerSerVO);
	public void delete(Integer caseno);
    public CustomerSerVO findByPrimaryKey(Integer caseno);
    public List<CustomerSerVO> getAll();
	
}
