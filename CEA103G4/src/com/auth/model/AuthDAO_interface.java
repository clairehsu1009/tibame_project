package com.auth.model;

import java.util.List;
import java.util.Set;




public interface AuthDAO_interface {
    public void insert(AuthVO authVO);
    public void update(AuthVO authVO);
    public void delete(Integer empno ,Integer funnno);
    public AuthVO findAuthAllValues(AuthVO authVO);
    public Set<AuthVO> findAuthByFunno(Integer funno);
    public List<AuthVO> getAll();
    public List<AuthVO> getAuth(Integer empno);
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<AuthVO> getAll(Map<String, String[]> map); 
    

	
	
}
