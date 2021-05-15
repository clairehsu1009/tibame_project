package com.seller_follow.model;

import java.util.*;

public interface Seller_FollowDAO_interface {
	
	 public void insert(Seller_FollowVO seller_followVO);
     public void delete(Integer tracer_no);
     public List<Seller_FollowVO> getOneUser(String user_id);
     public List<Seller_FollowVO> getAll();
     //萬用複合查詢(傳入參數型態Map)(回傳 List)
//   public List<Seller_FollowVO> getAll(Map<String, String[]> map); 
     public Seller_FollowVO getTracerNo(String user_id, String seller_id);

}
