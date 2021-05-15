package com.seller_follow.controller;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

import com.product_type.model.Product_TypeVO;
import com.seller_follow.model.*;


public class Seller_FollowServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");


		
        if ("insert".equals(action)) { // 來自addSeller_Follow.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				
				String user_id = req.getParameter("user_id");
				String seller_id = req.getParameter("seller_id");
				
				
				
				Seller_FollowVO seller_followVO = new Seller_FollowVO();
				seller_followVO.setUser_id(user_id);
				seller_followVO.setSeller_id(seller_id);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("seller_followVO", seller_followVO); // 含有輸入格式錯誤的seller_followVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/productsell/product.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				Seller_FollowService seller_followSvc = new Seller_FollowService();
				Seller_FollowVO following = seller_followSvc.getTracerNo(user_id, seller_id);

				if (following != null) {
					errorMsgs.add("已關注過此賣家");
					req.setAttribute("seller_followVO", seller_followVO); // 含有輸入格式錯誤的seller_followVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/productsell/product.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				} else {
					seller_followVO = seller_followSvc.addSeller_Follow(user_id, seller_id);
				}
				
			
				
				/***************************2.開始新增資料*****************************************/
//				Seller_FollowService seller_followSvc = new Seller_FollowService();
//				seller_followVO = seller_followSvc.addSeller_Follow(user_id, seller_id);
				
				/***************************3.新增完成,準備轉交(Send the Success view)*************/
//				String url = "/back-end/seller_follow/listAllSeller_Follow.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listAllSeller_Follow.jsp
//				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/productsell/product.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("deleteUserIndex".equals(action) || "deleteFromProduct".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer tracer_no = new Integer(req.getParameter("tracer_no"));
				
				/***************************2.開始刪除資料***************************************/
				Seller_FollowService seller_followSvc = new Seller_FollowService();
				seller_followSvc.deleteSeller_Follow(tracer_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
				String url = null;
				if ("deleteUserIndex".equals(action)) {
					url = "/front-end/protected/userIndex.jsp"; 
				
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				}
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
	}
}
