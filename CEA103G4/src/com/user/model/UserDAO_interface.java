package com.user.model;

import java.util.List;
import java.util.Optional;
import java.util.Set;

import com.live_report.model.*;

public interface UserDAO_interface {
	public void insert(UserVO userVO);

	public void update(UserVO userVO);
	
	public void delete(String user_id);
	
	public UserVO findByPrimaryKey(String user_id);

	public List<UserVO> getAll();
	// 萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map); 
	
	public Set<Live_reportVO> getLive_reportByUser_id(String user_id);
	
	public UserVO login(String user_id, String user_pwd);
	
	public void sendMail(UserVO userVO);
	
	public void getPassword_Update(UserVO userVO);
	
	public void newPassword_Update(UserVO userVO);

	public void update_user_report(UserVO userVO);
	
	public void updateUserRating(UserVO userVO);
	
	Optional<UserVO> findUserPic(String user_id);
	
	public void updateCash(UserVO userVO);
	
	public void addCash(UserVO userVO);
	
	public void updateUserViolation(String user_id, Integer violation);
}
