package com.user.model;

import java.sql.Date;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import com.live_report.model.*;

public class UserService {

	private UserDAO_interface dao;

	public UserService() {
		dao = new UserDAO();
	}

	public UserVO addUser(String user_id, String user_pwd, String user_name, String id_card, String user_gender,
			Date user_dob, String user_mail, String user_phone, String user_mobile, String city, String town, Integer zipcode, String user_addr, Date regdate,
			Integer user_point, Integer violation, Integer user_state, Integer user_comment, Integer comment_total,
			Integer cash) {

		UserVO userVO = new UserVO();

		userVO.setUser_id(user_id);
		userVO.setUser_pwd(user_pwd);
		userVO.setUser_name(user_name);
		userVO.setId_card(id_card);
		userVO.setUser_gender(user_gender);
		userVO.setUser_dob(user_dob);
		userVO.setUser_mail(user_mail);
		userVO.setUser_phone(user_phone);
		userVO.setUser_mobile(user_mobile);
		userVO.setCity(city);
		userVO.setTown(town);
		userVO.setZipcode(zipcode);
		userVO.setUser_addr(user_addr);
		userVO.setRegdate(regdate);
		userVO.setUser_point(user_point);
		userVO.setViolation(violation);
		userVO.setUser_state(user_state);
		userVO.setUser_comment(user_comment);
		userVO.setComment_total(comment_total);
		userVO.setCash(cash);
		
		dao.insert(userVO);

		return userVO;
	}

	public UserVO updateUser(String user_id, String user_name, String user_gender, Date user_dob, String user_mail, String user_phone, 
			String user_mobile, String city, String town, Integer zipcode, String user_addr, byte[] user_pic) {
		
		UserVO userVO = new UserVO();

		userVO.setUser_id(user_id);
//		userVO.setUser_pwd(user_pwd);
		userVO.setUser_name(user_name);
//		userVO.setId_card(id_card);
		userVO.setUser_gender(user_gender);
		userVO.setUser_dob(user_dob);
		userVO.setUser_mail(user_mail);
		userVO.setUser_phone(user_phone);
		userVO.setUser_mobile(user_mobile);
		userVO.setCity(city);
		userVO.setTown(town);
		userVO.setZipcode(zipcode);
		userVO.setUser_addr(user_addr);
		userVO.setUser_pic(user_pic);
//		userVO.setRegdate(regdate);
//		userVO.setUser_point(user_point);
//		userVO.setViolation(violation);
//		userVO.setUser_state(user_state);
//		userVO.setUser_comment(user_comment);
//		userVO.setComment_total(comment_total);
//		userVO.setCash(cash);
		
		dao.update(userVO);
		
		return userVO;
	}
	
	public void deleteUser(String user_id) {
		dao.delete(user_id);
	}

	public UserVO getOneUser(String user_id) {
		return dao.findByPrimaryKey(user_id);
	}

	public List<UserVO> getAll() {
		return dao.getAll();
	}
	
	public Set<Live_reportVO> getLive_reportByUser_id(String user_id) {
		return dao.getLive_reportByUser_id(user_id);
	}
	
	public UserVO selectUser(String user_id, String user_pwd) {
		UserVO userVO = dao.login(user_id, user_pwd);
		return userVO;
	}
	
	public UserVO getPassword_Update(String user_id,String user_newpwd,String user_mail) {
		
		UserVO userVO = new UserVO();

		userVO.setUser_id(user_id);
		userVO.setUser_pwd(user_newpwd);
		userVO.setUser_mail(user_mail);
		
		dao.getPassword_Update(userVO);
		return userVO;
	}
	
	public UserVO sendPwdMail(UserVO userVO) {
		
		dao.sendMail(userVO);
		return userVO;
	}
	
public UserVO newPassword_Update(String user_id,String user_newNameCheck) {
		
		UserVO userVO = new UserVO();
		
		userVO.setUser_id(user_id);
		userVO.setUser_pwd(user_newNameCheck);
		
		dao.newPassword_Update(userVO);
		return userVO;
	}

	public UserVO userRepost(Integer user_state,String user_id) {
		UserVO userVO = new UserVO();
		userVO.setUser_state(user_state);
		userVO.setUser_id(user_id);
		dao.update_user_report(userVO);		
		return userVO;
	}
	
	public UserVO updateUserRating(Integer user_comment,Integer comment_total,String user_id) {
		UserVO userVO = new UserVO();
		userVO.setUser_comment(user_comment);
		userVO.setComment_total(comment_total);		
		userVO.setUser_id(user_id);
		
		dao.updateUserRating(userVO);
		return userVO;
	}
	public Optional<UserVO> getUserPic(String user_id){
		return dao.findUserPic(user_id);
	}	
	
	public UserVO updateCash(Integer cash,String user_id) {
		UserVO userVO = new UserVO();
		userVO.setCash(cash);
		userVO.setUser_id(user_id);
		dao.updateCash(userVO);
		return userVO;
	}
	public UserVO addCash(Integer cash,String user_id) {
		UserVO userVO = new UserVO();
		userVO.setCash(cash);
		userVO.setUser_id(user_id);
		dao.addCash(userVO);
		return userVO;
	}
	
	public void updateUserViolation(String user_id, Integer violation) {
		dao.updateUserViolation(user_id, violation);
	}
	
}
