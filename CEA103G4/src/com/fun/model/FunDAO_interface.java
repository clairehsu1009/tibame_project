package com.fun.model;

import java.util.List;

public interface FunDAO_interface {
	public void insert(FunVO funVO);
	public void update(FunVO funVO);
	public void delete(Integer funno);
	public FunVO findByPrimaryKey(Integer funno);
	public List<FunVO> getAll();
	    //萬用複合查詢(傳入參數型態Map)(回傳 List)
	//  public List<FunVO> getAll(Map<String, String[]> map); 

}
