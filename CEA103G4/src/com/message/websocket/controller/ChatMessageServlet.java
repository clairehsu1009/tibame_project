package com.message.websocket.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ChatMessageServlet extends HttpServlet {
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String user_id = req.getParameter("user_id");
		String seller_id = req.getParameter("seller_id");
		req.setAttribute("user_id", user_id);
		req.setAttribute("seller_id", seller_id);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/front-end/message/chatMessage.jsp");
		dispatcher.forward(req, res);
	}
}
