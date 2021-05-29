package com.fun.controller;


import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.auth.model.AuthService;
import com.auth.model.AuthVO;
import com.fun.model.FunService;
import com.fun.model.FunVO;

public class FunServlet extends HttpServlet{
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res); 
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");		
		if ("getOne_For_Update".equals(action)) {// 來自listAllFun.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
//			String requestURL = req.getParameter("requestURL");
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer funno = new Integer(req.getParameter("funno"));
				/*************************** 2.開始查詢資料 ****************************************/
				AuthService authSvc = new AuthService();
				Set<AuthVO> set = authSvc.getAllAuthByFunno(funno);
//				for(AuthVO auth:set) {
//System.out.println(auth.getFunno()+",");
//System.out.println(auth.getEmpno()+",");
//System.out.println(auth.getAuth_no());
//			}
		
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("getOne_For_Update", set);
				String url = "/back-end/fun/listOneFun.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/fun/listAllFun.jsp");
				failureView.forward(req, res);
			}
		}
		// =================================================================================================

	}
}
