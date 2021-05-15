package com.customer_service.model;

import java.sql.Date;
import java.util.List;

public class CustomerSerService {

	private CustomerDAO_interface dao;
	
	public CustomerSerService() {
		dao=new CustomerDAO();
	}
	
	public CustomerSerVO addCus(String userid,String content,Integer caseState,Integer empno,String empResponse,Date caseTime) {
		
		CustomerSerVO customerSerVO = new CustomerSerVO();
		
		customerSerVO.setUserid(userid);
		customerSerVO.setContent(content);
		customerSerVO.setCaseState(caseState);
		customerSerVO.setEmpno(empno);
		customerSerVO.setEmpResponse(empResponse);
		customerSerVO.setCaseTime(caseTime);
		
		dao.insert(customerSerVO);
		
		return customerSerVO;
	}
	
	public CustomerSerVO updateCus(Integer caseno,String userid,String content,Integer caseState,Integer empno,String empResponse,Date caseTime) {
		
		CustomerSerVO customerSerVO = new CustomerSerVO();
		
		customerSerVO.setCaseno(caseno);
		customerSerVO.setUserid(userid);
		customerSerVO.setContent(content);
		customerSerVO.setCaseState(caseState);
		customerSerVO.setEmpno(empno);
		customerSerVO.setEmpResponse(empResponse);
		customerSerVO.setCaseTime(caseTime);
		
		dao.update(customerSerVO);
		
		return customerSerVO;
	}
	
	public void deleteCus(Integer caseno) {
		dao.delete(caseno);
	}
	public CustomerSerVO getOneCus(Integer caseno) {
		return dao.findByPrimaryKey(caseno);
	}
	public List<CustomerSerVO>getAll(){
		return dao.getAll();
	}
}
