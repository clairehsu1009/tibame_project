package com.user.controller;

import java.io.*;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.*;
import javax.servlet.http.*;
import com.user.model.*;


import javax.servlet.annotation.WebServlet;

@WebServlet("/User_LogoutHandler")
public class User_LogoutHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html; charset=utf-8");
		String action = req.getParameter("action");
		PrintWriter out = res.getWriter();
	
		if ("signOut".equals(action)) {
			HttpSession session = req.getSession();
			if(!session.isNew()) {
				//使用者登出
		        session.invalidate();
//		        session.removeAttribute("account");
		        
				String url = "/front-end/index.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); //登出後轉至首頁
				successView.forward(req, res);
			}
		} 
	}
}