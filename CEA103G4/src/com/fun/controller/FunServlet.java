package com.fun.controller;


import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fun.model.FunService;
import com.fun.model.FunVO;

public class FunServlet extends HttpServlet{
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res); 
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) {// 來自selectFun.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.(將請求存起來，例外發生時可以查看)
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			try {
				String str = req.getParameter("funno");
				if (str == null || (str.trim().length() == 0)) {
					errorMsgs.add("請輸入查詢功能編號");
				} // 錯誤發生時將內容發送回表單
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/fun/selectFun.jsp");
					failureView.forward(req, res);
					return;
				} // 程式中斷，回傳當傳頁面

				Integer funno = null;
				try {
					funno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("功能編號格式不正確");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/fun/selectFun.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始查詢資料 *****************************************/
				FunService funSvc = new FunService();
				FunVO funVO = funSvc.getOneFun(funno);
				if (funVO == null) {
					errorMsgs.add("查無資料");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/fun/selectFun.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("funVO", funVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/fun/listOneFun.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneFun.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/fun/selectFun.jsp");
				failureView.forward(req, res);
			}
		}
		// ================================================================================================	
		if ("getOne_For_Update".equals(action)) {// 來自listAllEmp.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer funno = new Integer(req.getParameter("funno"));

				/*************************** 2.開始查詢資料 ****************************************/
				FunService funSvc = new FunService();
				FunVO funVO = funSvc.getOneFun(funno);
			
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("funVO", funVO);
				String url = "/back-end/fun/update_fun_input.jsp";
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
		if ("update".equals(action)) {// 來自update_emp_input.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer funno = new Integer(req.getParameter("funno"));

				String funName = req.getParameter("fun_name");
				
				Integer state = new Integer(req.getParameter("state"));
				
				FunVO funVO = new FunVO();
				funVO.setFunno(funno);
				funVO.setFunName(funName);
				funVO.setState(state);
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("funVO", funVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/fun/update_fun_input.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始修改資料 *****************************************/
				FunService funSvc = new FunService();
				funVO = funSvc.updateFun(funno, funName, state);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
//				req.setAttribute("funVO", funVO); // 資料庫update成功後,正確的的funVO物件,存入req
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneFun.jsp
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/fun/update_fun_input.jsp");
				failureView.forward(req, res);
			}
		}
		// ====================================================================================================
		if (("insert").equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String funName = req.getParameter("fun_name");
				String funNameReg = "^[(\u4e00-\u9fa5)]{2,10}$";
				if (funName == null || funName.trim().length() == 0) {
					errorMsgs.add("功能名稱: 請勿空白");
				} else if (!funName.trim().matches(funNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("功能名稱: 只能是中文且長度必需在2到10之間");
				}
				Integer state = new Integer(req.getParameter("state"));
				
				FunVO funVO = new FunVO();
				funVO.setFunName(funName);
				funVO.setState(state);
				

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("funVO", funVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/fun/addFun.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始新增資料 *****************************************/
				FunService funSvc = new FunService();
				funVO =funSvc.addFun(funName,state);
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/fun/listAllFun.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllFun.jsp
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/fun/addFun.jsp");
				failureView.forward(req, res);
			}
		}
		//===========================================================================================
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer funno = new Integer(req.getParameter("funno"));

				/*************************** 2.開始刪除資料 ***************************************/
				FunService funSvc = new FunService();
				funSvc.deleteFun(funno);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/fun/listAllFun.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/fun/listAllFun.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
