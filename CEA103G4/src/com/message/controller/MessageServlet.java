package com.message.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.message.model.*;

public class MessageServlet extends HttpServlet{

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("getOne_For_Display".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {

				String str = req.getParameter("message_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入訊息編號");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/message/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				
				Integer message_no = null;
				try {
					message_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("訊息編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/message/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				

				MessageService messageSvc = new MessageService();
				MessageVO messageVO = messageSvc.getOneMessage(message_no);
				if (messageVO == null) {
					errorMsgs.add("查無資料");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/message/select_page.jsp");
					failureView.forward(req, res);
					return;
				}
				

				req.setAttribute("messageVO", messageVO); 
				String url = "/front-end/message/listOneMessage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);


			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/message/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				Integer message_no = new Integer(req.getParameter("message_no"));
				
				MessageService messageSvc = new MessageService();
				MessageVO messageVO = messageSvc.getOneMessage(message_no);

				req.setAttribute("messageVO", messageVO);        
				String url = "/front-end/message/update_message_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);


			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/message/listAllMessage.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { 
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				String user_id = req.getParameter("user_id");
				String content = req.getParameter("content");
				String seller_id = req.getParameter("seller_id");
				java.sql.Date message_time = null;

				try {
					message_time = java.sql.Date.valueOf(req.getParameter("message_time").trim());
				} catch (IllegalArgumentException e) {
					message_time=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				Integer message_no = new Integer(req.getParameter("message_no").trim());

				MessageVO messageVO = new MessageVO();
				messageVO.setMessage_no(message_no);
				messageVO.setUser_id(user_id);
				messageVO.setContent(content);
				messageVO.setSeller_id(seller_id);
				messageVO.setMessage_time(message_time);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("messageVO", messageVO); 
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/message/update_message_input.jsp");
					failureView.forward(req, res);
					return; 
				}
				
				MessageService messageSvc = new MessageService();
				messageVO = messageSvc.updateMessage(message_no, user_id, content, seller_id, message_time);
				
				req.setAttribute("messageVO", messageVO);
				String url = "/front-end/message/listOneMessage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

			} catch (Exception e) {
				errorMsgs.add("無法取得資料:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/message/update_message_input.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { 
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {

				String user_id = req.getParameter("user_id");
				String user_idReg = "^[(a-zA-Z0-9_)]{2,10}$";
				if (user_id == null || user_id.trim().length() == 0) {
					errorMsgs.add("買家帳號: 請勿空白");
				} else if(!user_id.trim().matches(user_idReg)) { 
					errorMsgs.add("買家帳號: 只能是中、英文字母、數字和- , 且長度必需在2到10之間");
	            }
				
				String content = req.getParameter("content").trim();
				if (content == null || content.trim().length() == 0) {
					errorMsgs.add("訊息內容請勿空白");
				}
				
				String seller_id = req.getParameter("seller_id");
				String seller_idReg = "^[(a-zA-Z0-9_)]{2,10}$";
				if (seller_id == null || seller_id.trim().length() == 0) {
					errorMsgs.add("賣家帳號: 請勿空白");
				} else if(!seller_id.trim().matches(seller_idReg)) { 
					errorMsgs.add("買家帳號: 只能是中、英文字母、數字和- , 且長度必需在2到10之間");
	            }
				
				java.sql.Date message_time = null;
				try {
					message_time = java.sql.Date.valueOf(req.getParameter("message_time").trim());
				} catch (IllegalArgumentException e) {
					message_time=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				MessageVO messageVO = new MessageVO();
				messageVO.setUser_id(user_id);
				messageVO.setContent(content);
				messageVO.setSeller_id(seller_id);
				messageVO.setMessage_time(message_time);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("messageVO", messageVO);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/message/addMessage.jsp");
					failureView.forward(req, res);
					return;
				}
				
				MessageService messageSvc = new MessageService();
				messageVO = messageSvc.addMessage(user_id, content, seller_id, message_time);
				
				String url = "/front-end/message/listAllMessage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);				
				
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/message/addMessage.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("delete".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				Integer message_no = new Integer(req.getParameter("message_no"));
				
				MessageService messageSvc = new MessageService();
				messageSvc.deleteMessage(message_no);
				
				String url = "/front-end/message/listAllMessage.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/message/listAllMessage.jsp");
				failureView.forward(req, res);
			}
		}
	}
}

