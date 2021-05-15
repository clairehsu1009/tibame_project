package com.auth.model;

import java.util.List;




public interface AuthDAO_interface {
    public void insert(AuthVO authVO);
    public void update(AuthVO authVO);
    public void delete(Integer empno ,Integer funnno);
    public AuthVO findAuthAllValues(AuthVO authVO);
    public List<AuthVO> getAll();
    public List<AuthVO> getAuth(Integer empno);
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<AuthVO> getAll(Map<String, String[]> map); 

	
	
}
