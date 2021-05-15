package com.live.controller;

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

import com.live.model.LiveService;
import com.live.model.LiveVO;


@MultipartConfig
public class LiveServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String liveURL = "/front-end/live/liveRoom.jsp";
		Integer live_no = new Integer(req.getParameter("live_no"));
		LiveService liveSvc = new LiveService();
		LiveVO liveVO = liveSvc.getOneLive(live_no);
		req.setAttribute("liveVO", liveVO);
		req.getRequestDispatcher(liveURL).forward(req, res);

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
				String str = req.getParameter("live_no");
				
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入直播編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/live/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer live_no = null;
				try {
					live_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("直播編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/live/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				LiveService liveSvc = new LiveService();
				LiveVO liveVO = liveSvc.getOneLive(live_no);
				if (liveVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/live/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("liveVO", liveVO); // 資料庫取出的liveVO物件,存入req
				String url = "/front-end/live/listOneLive.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/live/select_page.jsp");
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
				Integer live_no = new Integer(req.getParameter("live_no"));

				/*************************** 2.開始查詢資料 ****************************************/
				LiveService liveSvc = new LiveService();
				LiveVO liveVO = liveSvc.getOneLive(live_no);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("liveVO", liveVO); // 資料庫取出的liveVO物件,存入req
				String url = "/front-end/liveManagement/liveUpdate.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/liveManagement/liveList.jsp");
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
				LiveVO liveVO = new LiveVO();
				
				Integer live_no = new Integer(req.getParameter("live_no").trim());
				
				String live_type = req.getParameter("live_type");
				String live_name = req.getParameter("live_name");
				
				java.sql.Timestamp live_time = null;
				try {
					live_time = java.sql.Timestamp.valueOf(req.getParameter("live_time").trim());
				} catch (IllegalArgumentException e) {
					live_time = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				
				Integer live_state = new Integer(req.getParameter("live_state").trim());
				String user_id = req.getParameter("user_id");
				Integer empno = new Integer(req.getParameter("empno").trim());

				byte[] live_photo = null;
				Part part = req.getPart("live_photo");
				if (part == null || part.getSize() == 0) {
					req.setAttribute("liveVO", liveVO);
					LiveService liveSvc2 = new LiveService();
					LiveVO liveVO2 = liveSvc2.getOneLive(live_no);
					live_photo = liveVO2.getLive_photo();
				} else {
					req.setAttribute("liveVO", liveVO);
					InputStream in = part.getInputStream();
					live_photo = new byte[in.available()];
					in.read(live_photo);
					in.close();
				}
				String live_id = req.getParameter("live_id");
				
				
				liveVO.setLive_no(live_no);
				liveVO.setLive_type(live_type);
				liveVO.setLive_name(live_name);
				liveVO.setLive_time(live_time);
				liveVO.setLive_state(live_state);
				liveVO.setUser_id(user_id);
				liveVO.setEmpno(empno);
				liveVO.setLive_photo(live_photo);
				liveVO.setLive_id(live_id);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("liveVO", liveVO); // 含有輸入格式錯誤的liveVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/liveManagement/liveUpdate.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				LiveService liveSvc = new LiveService();
				liveVO = liveSvc.updateLive( live_type, live_name, live_time, live_state
					,user_id,empno, live_photo,live_id,live_no);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("liveVO", liveVO); // 資料庫update成功後,正確的的liveVO物件,存入req
				String url = "/front-end/liveManagement/liveList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/liveManagement/liveUpdate.jsp");
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
				LiveVO liveVO = new LiveVO();

				String live_type = req.getParameter("live_type");
				String live_name = req.getParameter("live_name");
				
				java.sql.Timestamp live_time = null;
				try {
					live_time = java.sql.Timestamp.valueOf(req.getParameter("live_time").trim());
				} catch (IllegalArgumentException e) {
					live_time = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入直播日期!");
				}
				
				Integer live_state = new Integer(req.getParameter("live_state").trim());
				String user_id = req.getParameter("user_id");
				Integer empno = new Integer(req.getParameter("empno").trim());

				
				
				byte[] live_photo = null;
				Part part = req.getPart("live_photo");
				if (part == null || part.getSize() == 0) {
					errorMsgs.add("請上傳一張圖片");
				} else {
					InputStream in = part.getInputStream();
					live_photo = new byte[in.available()];
					in.read(live_photo);
					in.close();
				}
				String live_id = req.getParameter("live_id");
				
				liveVO.setLive_type(live_type);
				liveVO.setLive_name(live_name);
				liveVO.setLive_time(live_time);
				liveVO.setLive_state(live_state);
				liveVO.setUser_id(user_id);
				liveVO.setEmpno(empno);
				liveVO.setLive_photo(live_photo);
				liveVO.setLive_id(live_id);
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("liveVO", liveVO); // 含有輸入格式錯誤的liveVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/liveManagement/liveAdd.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始新增資料 ***************************************/
				LiveService liveSvc = new LiveService();
				liveVO = liveSvc.addLive(live_type,live_name,live_time,live_state,user_id,empno,live_photo,live_id);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front-end/liveManagement/liveList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/liveManagement/liveAdd.jsp");
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
				Integer live_no = new Integer(req.getParameter("live_no"));

				/*************************** 2.開始刪除資料 ***************************************/
				LiveService liveSvc = new LiveService();
				liveSvc.deleteLive(live_no);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/front-end/liveManagement/liveList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/liveManagement/liveList.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("over".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer live_no = new Integer(req.getParameter("live_no"));

				/*************************** 2.開始刪除資料 ***************************************/
				LiveService liveSvc = new LiveService();
				liveSvc.overLive(live_no);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/front-end/liveManagement/liveList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/liveManagement/liveList.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
