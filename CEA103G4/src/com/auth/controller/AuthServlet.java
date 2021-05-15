package com.auth.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.auth.model.AuthService;
import com.auth.model.AuthVO;

public class AuthServlet extends HttpServlet {
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

				Integer empno = new Integer(req.getParameter("empno"));

				Integer funno = new Integer(req.getParameter("funno"));

				Integer auth_no = new Integer(req.getParameter("auth_no"));

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/auth/selectAuth.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始查詢資料 *****************************************/
				AuthService authSvc = new AuthService();
				AuthVO authVO = authSvc.getOneAuth(empno, funno, auth_no);

				if (authVO == null) {
					errorMsgs.add("查無資料");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/auth/selectAuth.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("authVO", authVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/auth/listOneAuth.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/auth/selectAuth.jsp");
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
				Integer empno = new Integer(req.getParameter("empno"));
//System.out.println("Auth empno="+empno);
				Integer funno = new Integer(req.getParameter("funno"));
//System.out.println("Auth funno="+funno);
				Integer auth_no = new Integer(req.getParameter("auth_no"));
//System.out.println("Auth auth_no="+auth_no);

				/*************************** 2.開始查詢資料 ****************************************/
				AuthService authSvc = new AuthService();
				AuthVO authVO = authSvc.getOneAuth(empno, funno, auth_no);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("authVO", authVO);
				String url = "/back-end/auth/update_auth_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);

			}
		}
		// 修改===========================================================================================

		if ("update".equals(action)) {// 來自update_auth_input.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			String requestURL = req.getParameter("requestURL");

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				//來自listAllAuth.jsp的修改請求，針對單一員工的單一權限
				
				Integer empno = new Integer(req.getParameter("empno"));
//System.out.println("Auth empno="+empno);
				Integer funno = new Integer(req.getParameter("funno"));
//System.out.println("Auth funno="+funno);
				Integer auth_no = new Integer(req.getParameter("auth_no"));
//System.out.println("Auth auth_no="+auth_no);
				AuthVO authVO = new AuthVO();
				authVO.setEmpno(empno);
				authVO.setFunno(funno);
				authVO.setAuth_no(auth_no);

				/*************************** 2.開始修改資料 *****************************************/
				AuthService authSvc = new AuthService();
				authVO = authSvc.updateAuth(auth_no, empno, funno);
//System.out.println(authVO);
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/

//				if (requestURL.equals("/back-end/emp/listOneEmp.jsp"))
//					req.setAttribute("EmpVO", empVO); // 資料庫取出的list物件,存入request
				req.setAttribute("authVO", authVO);
				String url = "/back-end/auth/listAllAuth.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/auth/listAllAuth.jsp");
				failureView.forward(req, res);
			}
		}
		// ===============================================================================================
		if (("insert").equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
//				Integer empno = new Integer(req.getParameter("empno"));

//				Integer funno = new Integer(req.getParameter("funno"));
//				System.out.println(funno);

//				Integer auth_no = new Integer(req.getParameter("auth_no"));
//				System.out.println(auth_no);

//				AuthVO authVO = new AuthVO();
//				authVO.setEmpno(empno);
//				authVO.setFunno(funno);
//				authVO.setAuth_no(auth_no);
//				Integer empno = new Integer(req.getParameter("empno"));
//System.out.println(empno);
//					
				Integer empno = new Integer(req.getParameter("empno"));
				String auth_nos[] = req.getParameterValues("auth_no");
				String funnos[] = req.getParameterValues("funno");
				try {
					for (int i = 0; i < funnos.length; i++) {
						int auth_no = new Integer(auth_nos[i]);
						int funno = new Integer(funnos[i]);

						AuthVO authVO = new AuthVO();
						authVO.setEmpno(empno);
						authVO.setFunno(funno);
						authVO.setAuth_no(auth_no);
						AuthService authSvc = new AuthService();
						authVO = authSvc.addAuth(empno, funno, auth_no);
					}
				} catch (Exception e) {
					errorMsgs.add("此員工已有資料，故只能修改權限");
				}

//				List <String>authNOList = Arrays.asList<String>(checkbox);
//				List<Integer> newList = list.stream()
//                        .map(s -> Integer.parseInt(s))
//                        .collect(Collectors.toList());
//				req.setAttribute("authNo", funnoList);
//				
//				AuthVO authVO = new AuthVO();
//				authVO.setEmpno(empno);
//				authVO.setFunno(funno);
//				authVO.setAuth_no(auth_no);
				if (!errorMsgs.isEmpty()) {
//				req.setAttribute("authVO", authVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/auth/addAuth.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始新增資料 *****************************************/
//				AuthService authSvc = new AuthService();
//				authVO = authSvc.addAuth(empno, funno, auth_no);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/auth/listAllAuth.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/auth/addAuth.jsp");
				failureView.forward(req, res);
			}
		}

		// ===========================================================================================
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			String requestURL = req.getParameter("requestURL");

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer empno = new Integer(req.getParameter("empno"));

				Integer funno = new Integer(req.getParameter("funno"));

				/*************************** 2.開始刪除資料 ***************************************/
				AuthService authSvc = new AuthService();
				authSvc.deleteAuth(funno, empno);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/auth/listAllAuth.jsp");
				failureView.forward(req, res);
			}
		}

	}

}
