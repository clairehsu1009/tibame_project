package com.emp.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.auth.model.AuthService;
import com.auth.model.AuthVO;
import com.emp.model.*;
import com.fun.model.FunService;
import com.fun.model.FunVO;

public class EmpServlet extends HttpServlet {

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
				String str = req.getParameter("empno");
				if (str == null || (str.trim().length() == 0)) {
					errorMsgs.add("請輸入員工編號");
				} // 錯誤發生時將內容發送回表單
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/backendIndex.jsp");
					failureView.forward(req, res);
					return;
				} // 程式中斷，回傳當傳頁面

				Integer empno = null;
				try {
					empno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("員工編號格式不正確");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/backendIndex.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始查詢資料 *****************************************/
				EmpService empSvc = new EmpService();
				EmpVO empVO = empSvc.getOneEmp(empno);
				if (empVO == null) {
					errorMsgs.add("查無資料");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/backendIndex.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("empVO", empVO); // 資料庫取出的empVO物件,存入req
				String url = "/back-end/emp/listOneEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/backendIndex.jsp");
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

				/*************************** 2.開始查詢資料 ****************************************/
				EmpService empSvc = new EmpService();
				EmpVO empVO = empSvc.getOneEmp(empno);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("empVO", empVO);
				String url = "/back-end/emp/update_emp_input.jsp";
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
				Integer empno = new Integer(req.getParameter("empno").trim());

				String ename = req.getParameter("ename");
				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (ename == null || ename.trim().length() == 0) {
					errorMsgs.add("員工姓名: 請勿空白");
				} else if (!ename.trim().matches(enameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

				String job = req.getParameter("job").trim();
				if (job == null || job.trim().length() == 0) {
					errorMsgs.add("職位請勿空白");
				}

				Integer gender = new Integer(req.getParameter("gender"));

				String id = req.getParameter("id");
				String idReg = "^[a-zA-Z]{1}[1-2]{1}[0-9]{8}$";
				if (id == null || id.trim().length() == 0) {
					errorMsgs.add("身份證字號請勿空白");
				} else if (!id.trim().matches(idReg)) {
					errorMsgs.add("身份證字號不正確");
				}

				java.sql.Date dob = null;
				try {
					dob = java.sql.Date.valueOf(req.getParameter("dob").trim());
				} catch (IllegalArgumentException e) {
					dob = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入生日!");
				}
				String city = req.getParameter("city");
				if (city == null || city.length() == 0) {
					errorMsgs.add("請選擇縣市");
				}
				String dist = req.getParameter("dist");
				if (dist == null || dist.length() == 0) {
					errorMsgs.add("請選擇區域");
				}
				String addr = req.getParameter("addr").trim();
				if (addr == null || addr.length() == 0) {
					errorMsgs.add("地址請勿空白");
				}
//				StringBuffer sb = new StringBuffer();
//				addr = sb.append(req.getParameter("city")).toString();
//				addr = sb.append(req.getParameter("dist")).toString();
//				addr = sb.append(req.getParameter("addr")).toString().trim();

				String email = req.getParameter("email");
				String emailReg = "^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$";
				if (email == null || email.trim().length() == 0) {
					errorMsgs.add("email請勿空白");
				} else if (!email.trim().matches(emailReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("email格式不正確");
				}

				Double sal = null;
				try {
					sal = new Double(req.getParameter("sal").trim());
				} catch (NumberFormatException e) {
					sal = 0.0;
					errorMsgs.add("薪水請填數字.");
				}

				Integer state = new Integer(req.getParameter("state"));

				java.sql.Date hiredate = null;
				try {
					hiredate = java.sql.Date.valueOf(req.getParameter("hiredate").trim());
					if (hiredate.before(dob)) {
						errorMsgs.add("日期格式錯誤，到職日期小於生日，請重新輸入");
					}
				} catch (IllegalArgumentException e) {
					hiredate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入到職日!");
				}

				String empPwd = req.getParameter("emp_pwd");
				if (empPwd == null || empPwd.trim().length() == 0) {
					errorMsgs.add("密碼請勿空白");
				}

				EmpVO empVO = new EmpVO();
				empVO.setEmpno(empno);
				empVO.setEname(ename);
				empVO.setJob(job);
				empVO.setId(id);
				empVO.setGender(gender);
				empVO.setDob(dob);
				empVO.setCity(city);
				empVO.setDist(dist);
				empVO.setAddr(addr);
				empVO.setEmail(email);
				empVO.setSal(sal);
				empVO.setState(state);
				empVO.setHiredate(hiredate);
				empVO.setEmp_pwd(empPwd);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("empVO", empVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/emp/update_emp_input.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始修改資料 *****************************************/
				EmpService empSvc = new EmpService();
				//先修改員工資料
				empVO = empSvc.updateEmp(empno, ename, job, id, gender, dob, city, dist, addr, email, sal, state,
						hiredate, empPwd);
				//再修改權限資料
				empno = empVO.getEmpno();
//System.out.println("EmpServlet empno 228 ="+empno);
				String auth_nos[] = req.getParameterValues("auth_no");// 新增Emp的同時可以新增Auth並轉交給Auth Table
				String funnos[] = req.getParameterValues("funno");

				AuthVO authVO = new AuthVO();
				for (int i = 0; i < funnos.length; i++) {
					int auth_no = new Integer(auth_nos[i]);
//System.out.println("EmpServlet authno 235 = "+ auth_nos[i]);
					int funno = new Integer(funnos[i]);
//System.out.println("EmpServlet funno 237 = "+ funnos[i]);
					authVO.setEmpno(empno);
					authVO.setFunno(funno);
					authVO.setAuth_no(auth_no);
					AuthService authSvc = new AuthService();
					authVO = authSvc.updateAuth(auth_no, empno, funno);
				}
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/emp/update_emp_input.jsp");
				failureView.forward(req, res);
			}
		}
		// 新增EMP===============================================================================================
		if (("insert").equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String ename = req.getParameter("ename");
				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (ename == null || ename.trim().length() == 0) {
					errorMsgs.add("員工姓名: 請勿空白");
				} else if (!ename.trim().matches(enameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

				String job = req.getParameter("job");
				if (job == null || job.trim().length() == 0) {
					errorMsgs.add("職位請勿空白");
				}

				Integer gender = new Integer(req.getParameter("gender").trim());

				String id = req.getParameter("id");
				String idReg = "^[a-zA-Z]{1}[1-2]{1}[0-9]{8}$";
				if (id == null || id.trim().length() == 0) {
					errorMsgs.add("身份證字號請勿空白");
				} else if (!id.trim().matches(idReg)) {
					errorMsgs.add("身份證字號不正確");
				}

				java.sql.Date dob = null;
				try {
					dob = java.sql.Date.valueOf(req.getParameter("dob").trim());
				} catch (IllegalArgumentException e) {
					dob = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入生日!");
				}
				String city = req.getParameter("city");
				if (city == null || city.length() == 0) {
					errorMsgs.add("請選擇縣市");
				}

				String dist = req.getParameter("dist");
				if (dist == null || dist.length() == 0) {
					errorMsgs.add("請選擇區域");
				}
				String addr = req.getParameter("addr").trim();
				if (addr == null || addr.length() == 0) {
					errorMsgs.add("地址請勿空白");
				}
//				String addr = "";
//				StringBuffer sb = new StringBuffer();
//				addr = sb.append(req.getParameter("city")).toString();
//				addr = sb.append(req.getParameter("dist")).toString();
//				addr = sb.append(req.getParameter("addr")).toString().trim();
//				if (addr == null || addr.length() == 0) {
//					errorMsgs.add("地址請勿空白");
//				}

				String email = req.getParameter("email");
				String emailReg = "^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$";
				if (email == null || email.trim().length() == 0) {
					errorMsgs.add("email請勿空白");
				} else if (!email.trim().matches(emailReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("email格式不正確");
				}

				Double sal = null;
				try {
					sal = new Double(req.getParameter("sal").trim());
				} catch (NumberFormatException e) {
					sal = 0.0;
					errorMsgs.add("薪水請填數字.");
				}

				Integer state = new Integer(req.getParameter("state").trim());

				java.sql.Date hiredate = null;
				try {
					hiredate = java.sql.Date.valueOf(req.getParameter("hiredate").trim());
					if (hiredate.before(dob)) {
						errorMsgs.add("日期格式錯誤，到職日期小於生日，請重新輸入");
					}
				} catch (IllegalArgumentException e) {
					hiredate = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入到職日!");
				}
				String empPwd = null;

				EmpService empSvc = new EmpService();

				empPwd = empSvc.getPassword();// dao.service隨機密碼

				EmpVO empVO = new EmpVO();

				empVO.setEname(ename);
				empVO.setJob(job);
				empVO.setId(id);
				empVO.setGender(gender);
				empVO.setDob(dob);
				empVO.setCity(city);
				empVO.setDist(dist);
				empVO.setAddr(addr);
				empVO.setEmail(email);
				empVO.setSal(sal);
				empVO.setState(state);
				empVO.setHiredate(hiredate);
				empVO.setEmp_pwd(empPwd);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("empVO", empVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/emp/addEmp.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 *****************************************/
				empVO = empSvc.addEmp(ename, job, id, gender, dob, city, dist, addr, email, sal, state, hiredate,
						empPwd);
				// EmpDAO裡，在新增Emp的同時，呼叫getGeneratedKeys()回傳, 可以拿到自增主鍵的Empno
				Integer empno = empVO.getEmpno();
				String auth_nos[] = req.getParameterValues("auth_no");// 新增Emp的同時可以新增Auth並轉交給Auth Table
				String funnos[] = req.getParameterValues("funno");

				AuthVO authVO = new AuthVO();
				for (int i = 0; i < funnos.length; i++) {
					int auth_no = new Integer(auth_nos[i]);
					int funno = new Integer(funnos[i]);
					authVO.setEmpno(empno);
					authVO.setFunno(funno);
					authVO.setAuth_no(auth_no);
					AuthService authSvc = new AuthService();
					authVO = authSvc.addAuth(empno, funno, auth_no);
				}
				
				String link = req.getServerName() + ":" + req.getServerPort() + req.getContextPath();
				
				empVO = empSvc.sendPwdMail(empno,ename, email, empPwd, link);// dao.service發送password email
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/

				String url = "/back-end/emp/listAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/emp/addEmp.jsp");
				failureView.forward(req, res);
			}
		}

		// ===========================================================================================
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			String requestURL = req.getParameter("requestURL"); // 送出刪除的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer empno = new Integer(req.getParameter("empno"));

				/*************************** 2.開始刪除資料 ***************************************/
				EmpService empSvc = new EmpService();
				empSvc.deleteEmp(empno);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
//				if (requestURL.equals("/back-end/emp/listOneEmp.jsp"))
//					req.setAttribute("listAllEmp", empSvc.getOneEmp(empno)); // 資料庫取出的list物件,存入request

				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/emp/listAllEmp.jsp");
				failureView.forward(req, res);
			}
		}
		if ("getOne_From".equals(action)) {

			try {
				// Retrieve form parameters.
				Integer empno = new Integer(req.getParameter("empno"));

				EmpDAO dao = new EmpDAO();
				EmpVO empVO = dao.findByPrimaryKey(empno);

				req.setAttribute("empVO", empVO); // 資料庫取出的empVO物件,存入req

				// Bootstrap_modal
				boolean openModal = true;
				req.setAttribute("openModal", openModal);

				// 取出的empVO送給listOneEmp.jsp
				RequestDispatcher successView = req.getRequestDispatcher("/back-end/emp/listOneEmp.jsp");
				successView.forward(req, res);
				return;

				// Handle any unusual exceptions
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
	}

}
