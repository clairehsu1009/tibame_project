package com.user.controller;

import java.io.*;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.*;
import javax.servlet.http.*;
import com.user.model.*;


import javax.servlet.annotation.WebServlet;

@WebServlet("/UpdateUserPwdServlet")
public class UpdateUserPwdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html; charset=utf-8");
		String action = req.getParameter("action");
		PrintWriter out = res.getWriter();
	
		if ("updateUserPwd".equals(action)) {
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String user_id = req.getParameter("user_id").trim();
				
				String user_pwd = req.getParameter("user_pwd").trim();
				
				//已在前端做密碼勿空白的驗證(required)
//				if (user_pwd == null || user_pwd.trim().length() == 0) {
//					errorMsgs.put("user_pwd","*密碼請勿空白");
//				}
				
				String user_newName = req.getParameter("user_newName").trim();
//				if (user_newName == null || user_newName.trim().length() == 0) {
//					errorMsgs.put("user_newName","*新密碼請勿空白");
//				}
				
				String user_newNameCheck = req.getParameter("user_newNameCheck").trim();
//				if (user_newNameCheck == null || user_newNameCheck.trim().length() == 0) {
//					errorMsgs.put("user_newNameCheck","*確認密碼請勿空白");
//				}
				
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/user/updateUserPwd.jsp");
//					failureView.forward(req, res);
//					return;
//				}
				
				/***************************2.開始查詢資料***************************************/
				UserService userSvc = new UserService();
				UserVO userVO = new UserVO();
				userVO = userSvc.selectUser(user_id,user_pwd);
				if(userVO == null) {
					errorMsgs.put("user_pwd","密碼不正確，請重新輸入！");
					String url = "/front-end/user/updateUserPwd.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); 
					successView.forward(req, res);
					return;
				}
				/***************************3.開始修改資料***************************************/
				if(!(user_newNameCheck.equals(user_newName))) {
					errorMsgs.put("user_newNameCheck","與新密碼不同，請重新輸入！");
					req.setAttribute("userVO", userVO); // 含有輸入格式錯誤的userVO物件,也存入req
					String url = "/front-end/user/updateUserPwd.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); 
					successView.forward(req, res);
					return;
				}
				userVO = userSvc.newPassword_Update(user_id,user_newNameCheck);
				/***************************4.修改完成,準備轉交(Send the Success view)***********/
				String url = "/front-end/protected/userIndex.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交userIndex.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/user/updateUserPwd.jsp");
				failureView.forward(req, res);
			}
		}
	}
}