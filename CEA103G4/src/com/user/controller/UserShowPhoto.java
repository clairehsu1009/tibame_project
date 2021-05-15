package com.user.controller;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.user.model.*;

@WebServlet("/UserShowPhoto")
public class UserShowPhoto extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("image/*");
		String user_id = new String(request.getParameter("user_id"));
	
		if (user_id != null) {
		UserService userSvc = new UserService();
		Optional<UserVO> userVO = userSvc.getUserPic(user_id);
		
		if (userVO.isPresent()) {
			OutputStream out = response.getOutputStream();
			out.write(userVO.get().getUser_pic());
			out.flush();
			out.close();
		}
	} 
}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
