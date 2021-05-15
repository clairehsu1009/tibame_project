package com.customer_service.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.customer_service.model.CustomerSerService;
import com.customer_service.model.CustomerSerVO;
import com.emp.model.EmpService;
import com.emp.model.EmpVO;

public class CustomerServiceServlet extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) {// 來自selectEmp.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.(將請求存起來，例外發生時可以查看)
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
			try {
				String str = req.getParameter("caseno");
				if (str == null || (str.trim().length() == 0)) {
					errorMsgs.add("請輸入客服編號");
				} // 錯誤發生時將內容發送回表單
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/customer/selectCustomer.jsp");
					failureView.forward(req, res);
					return;
				} // 程式中斷，回傳當傳頁面

				Integer caseno = null;
				try {
					caseno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("客服編號格式不正確");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/customer/selectCustomer.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始查詢資料 *****************************************/
				CustomerSerService cusSvc = new CustomerSerService();
				CustomerSerVO cusVO = cusSvc.getOneCus(caseno);
				if (cusVO == null) {
					errorMsgs.add("查無資料");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/customer/selectCustomer.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("cusVO", cusVO); // 資料庫取出的cusVO物件,存入req
				String url = "/back-end/customer/listOneCustomer.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/customer/selectCustomer.jsp");
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
				Integer caseno = new Integer(req.getParameter("caseno"));

				/*************************** 2.開始查詢資料 ****************************************/
				CustomerSerService cusSvc = new CustomerSerService();
				CustomerSerVO cusVO = cusSvc.getOneCus(caseno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("cusVO", cusVO);
				String url = "/back-end/costomer/update_cus_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);

			}
		}
		// 修改EMP===========================================================================================

		if ("update".equals(action)) {// 來自update_emp_input.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			String requestURL = req.getParameter("requestURL");
			
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer caseno = new Integer(req.getParameter("caseno").trim());

				String userid = req.getParameter("userid");
				

				String content = req.getParameter("content").trim();
			

				Integer caseState = new Integer(req.getParameter("caseState"));

				Integer empno = new Integer(req.getParameter("empno").trim());
				
				
				String empResponse = req.getParameter("empResponse").trim();
				
				java.sql.Date caseTime = null;
				try {
					caseTime = java.sql.Date.valueOf(req.getParameter("caseTime").trim());
				} catch (IllegalArgumentException e) {
					caseTime = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				

				CustomerSerVO cusVO = new CustomerSerVO();
				cusVO.setEmpno(caseno);
				cusVO.setUserid(userid);
				cusVO.setContent(content);
				cusVO.setCaseState(caseState);
				cusVO.setEmpno(empno);
				cusVO.setEmpResponse(empResponse);
				cusVO.setCaseTime(caseTime);


				if (!errorMsgs.isEmpty()) {
					req.setAttribute("cusVO", cusVO); // 含有輸入格式錯誤的cusVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/costomer/update_cus_input.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始修改資料 *****************************************/
				CustomerSerService cusSvc = new CustomerSerService();
				cusVO = cusSvc.updateCus(caseno, userid, content, caseState, empno, empResponse, caseTime);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/

//				if (requestURL.equals("/back-end/customer/listOneCustomer.jsp"))
//					req.setAttribute("CustomerSerVO", cusVO); // 資料庫取出的list物件,存入request

				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);
			
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/costomer/update_cus_input.jsp");
				failureView.forward(req, res);
			}
		}
		// 新增EMP===============================================================================================
		if (("insert").equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer caseno = new Integer(req.getParameter("caseno").trim());

				String userid = req.getParameter("userid");
				

				String content = req.getParameter("content").trim();
			

				Integer caseState = new Integer(req.getParameter("caseState"));

				Integer empno = new Integer(req.getParameter("empno").trim());
				
				
				String empResponse = req.getParameter("empResponse").trim();
				
				java.sql.Date caseTime = null;
				try {
					caseTime = java.sql.Date.valueOf(req.getParameter("caseTime").trim());
				} catch (IllegalArgumentException e) {
					caseTime = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				

				CustomerSerVO cusVO = new CustomerSerVO();
				cusVO.setEmpno(caseno);
				cusVO.setUserid(userid);
				cusVO.setContent(content);
				cusVO.setCaseState(caseState);
				cusVO.setEmpno(empno);
				cusVO.setEmpResponse(empResponse);
				cusVO.setCaseTime(caseTime);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("cusVO", cusVO); // 含有輸入格式錯誤的cusVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/costomer/addCustomer.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始新增資料 *****************************************/
				CustomerSerService cusSvc = new CustomerSerService();
				cusVO = cusSvc.addCus(userid, content, caseState, empno, empResponse, caseTime);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/customer/listAllCustomer";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/costomer/addCustomer.jsp");
				failureView.forward(req, res);
			}
		}

		// ===========================================================================================
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			String requestURL = req.getParameter("requestURL"); // 送出刪除的來源網頁路徑: 可能為【/customer/listAllCustomer】 或
																// 【/dept/listEmps_ByDeptno.jsp】 或 【
																// /dept/listAllDept.jsp】 或 【
																// /emp/listEmps_ByCompositeQuery.jsp】

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer caseno = new Integer(req.getParameter("caseno"));

				/*************************** 2.開始刪除資料 ***************************************/
				CustomerSerService cusSvc = new CustomerSerService();
				cusSvc.deleteCus(caseno);;

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				if (requestURL.equals("/back-end/customer/listOneCustomer.jsp") || requestURL.equals("/dept/listAllDept.jsp"))
					req.setAttribute("listAllCustomer", cusSvc.getOneCus(caseno)); // 資料庫取出的list物件,存入request

//				if(requestURL.equals("/emp/listEmps_ByCompositeQuery.jsp")){
//					HttpSession session = req.getSession();
//					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
//					List<CustomerSerVO> list  = cusSvc.getAll(map);
//					req.setAttribute("listEmps_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
//				}				

//				req.setAttribute("cusVO", cusVO); // 資料庫update成功後,正確的的cusVO物件,存入req
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/customer/listAllCustomer");
				failureView.forward(req, res);
			}
		}

	}

}

