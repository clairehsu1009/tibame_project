package com.live_report.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.live_report.model.Live_reportService;
import com.live_report.model.Live_reportVO;
import com.product.model.ProductService;
import com.product.model.ProductVO;

@MultipartConfig
public class Live_reportServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("live_report_no");
				
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入直播檢舉編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/live_report/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer live_report_no = null;
				try {
					live_report_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("直播檢舉編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/live_report/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				Live_reportService live_reportSvc = new Live_reportService();
				Live_reportVO live_reportVO = live_reportSvc.getOneLive_report(live_report_no);
				if (live_reportVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/live_report/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("live_reportVO", live_reportVO); // 資料庫取出的live_reportVO物件,存入req
				String url = "/back-end/live_report/listOneLive_report.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/live_report/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer live_report_no = new Integer(req.getParameter("live_report_no"));

				/*************************** 2.開始查詢資料 ****************************************/
				Live_reportService live_reportSvc = new Live_reportService();
				Live_reportVO live_reportVO = live_reportSvc.getOneLive_report(live_report_no);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("live_reportVO", live_reportVO); // 資料庫取出的live_reportVO物件,存入req
				String url = "/back-end/live_report/update_live_report_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/live_report/listAllLive_report.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Live_reportVO live_reportVO = new Live_reportVO();
				
				Integer live_report_no = new Integer(req.getParameter("live_report_no").trim());
				String live_report_content = req.getParameter("live_report_content");
				Integer live_no = new Integer(req.getParameter("live_no").trim());
				String user_id = req.getParameter("user_id");
				Integer empno = new Integer(req.getParameter("empno").trim());
				Integer live_report_state = new Integer(req.getParameter("live_report_state").trim());
				
				byte[] photo = null;
				Part part = req.getPart("photo");
				if (part == null || part.getSize() == 0) {
					req.setAttribute("live_reportVO", live_reportVO);
					Live_reportService live_reportSvc2 = new Live_reportService();
					Live_reportVO live_reportVO2 = live_reportSvc2.getOneLive_report(live_report_no);
					photo = live_reportVO2.getPhoto();
				} else {
					req.setAttribute("live_reportVO", live_reportVO);
					InputStream in = part.getInputStream();
					photo = new byte[in.available()];
					in.read(photo);
					in.close();
				}
				
				live_reportVO.setLive_report_no(live_report_no);
				live_reportVO.setLive_report_content(live_report_content);
				live_reportVO.setLive_no(live_no);
				live_reportVO.setUser_id(user_id);
				live_reportVO.setEmpno(empno);
				live_reportVO.setLive_report_state(live_report_state);
				live_reportVO.setPhoto(photo);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("live_reportVO", live_reportVO); // 含有輸入格式錯誤的live_reportVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/live_report/update_live_report_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				Live_reportService live_reportSvc = new Live_reportService();
				live_reportVO = live_reportSvc.updateLive_report(live_report_no, live_report_content, live_no, user_id, empno,
						live_report_state, photo);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("live_reportVO", live_reportVO); // 資料庫update成功後,正確的的live_reportVO物件,存入req
				String url = "/back-end/live_report/listOneLive_report.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/live_report/update_live_report_input.jsp");
				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // 來自addEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String live_report_content = req.getParameter("live_report_content");
				Integer live_no = new Integer(req.getParameter("live_no").trim());
				String user_id = req.getParameter("user_id");
				Integer empno = new Integer(req.getParameter("empno").trim());
				Integer live_report_state = new Integer(req.getParameter("live_report_state").trim());

				Part part = req.getPart("photo");
				InputStream in = part.getInputStream();
				byte[] photo = new byte[in.available()];

				in.read(photo);
				in.close();

				Live_reportVO live_reportVO = new Live_reportVO();
				live_reportVO.setLive_report_content(live_report_content);
				live_reportVO.setLive_no(live_no);
				live_reportVO.setUser_id(user_id);
				live_reportVO.setEmpno(empno);
				live_reportVO.setLive_report_state(live_report_state);
				live_reportVO.setPhoto(photo);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("live_reportVO", live_reportVO); // 含有輸入格式錯誤的live_reportVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/live_report/update_live_report_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始新增資料 ***************************************/
				Live_reportService live_reportSvc = new Live_reportService();
				live_reportVO = live_reportSvc.addLive_report(live_report_content, live_no, user_id, empno,
						live_report_state, photo);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/live_report/listAllLive_report.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/live_report/addLive_report.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer live_report_no = new Integer(req.getParameter("live_report_no"));

				/*************************** 2.開始刪除資料 ***************************************/
				Live_reportService live_reportSvc = new Live_reportService();
				live_reportSvc.deleteLive_report(live_report_no);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back-end/live_report/listAllLive_report.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/live_report/listAllLive_report.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
