package com.notice.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import org.json.JSONObject;

import com.mysql.fabric.Response;
import com.notice.model.NoticeService;
import com.notice.model.NoticeVO;

public class NoticeServlet extends HttpServlet{

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("notice_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入通知編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/notice/select_page.jsp");
					failureView.forward(req, res);
					return;//{程式中斷
				}
				
				Integer notice_no = null;
				try {
					notice_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("通知編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/notice/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				NoticeService noticeSvc = new NoticeService();
				NoticeVO noticeVO = noticeSvc.getOneNotice(notice_no);
				if (noticeVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/notice/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("noticeVO", noticeVO); // 資料庫取出的empVO物件,存入req
				String url = "/front-end/notice/listOneNotice.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneNotice.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/notice/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllNotice.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 ****************************************/
				Integer notice_no = new Integer(req.getParameter("notice_no"));
				
				/***************************2.開始查詢資料****************************************/
				NoticeService noticeSvc = new NoticeService();
				NoticeVO noticeVO = noticeSvc.getOneNotice(notice_no);
								
				/***************************3查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("noticeVO", noticeVO);         // 資料庫取出的noticeVO物件,存入req
				String url = "/front-end/notice/update_notice_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_notice_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/notice/listAllNotice.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // 來自update_notice_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer notice_no = new Integer(req.getParameter("notice_no"));
				
				java.sql.Timestamp noc_date = null;
				try {
					noc_date = java.sql.Timestamp.valueOf(req.getParameter("noc_date").trim());
				} catch (IllegalArgumentException e) {
					noc_date=new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				Integer noc_state = null;
				try {
					noc_state = new Integer(req.getParameter("noc_state").trim());
				} catch (NumberFormatException e) {
					noc_state = 0;
					errorMsgs.add("狀態請.");
				}
				
				String user_id = new String(req.getParameter("user_id").trim());
				

				String noc_content = req.getParameter("srating_content");
				String noc_contentReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
				if (noc_content == null || noc_content.trim().length() == 0) {
					errorMsgs.add("評價內容: 請勿空白");
				} else if(!noc_content.trim().matches(noc_contentReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("評價內容: 只能是中、英文字母、數字和_ , 且長度必需在2到20之間");
	            }

				NoticeVO noticeVO = new NoticeVO();
				noticeVO.setNotice_no(notice_no);
				noticeVO.setNoc_date(noc_date);
				noticeVO.setNoc_state(noc_state);
				noticeVO.setUser_id(user_id);
				noticeVO.setNoc_content(noc_content);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("noticeVO", noticeVO); // 含有輸入格式錯誤的noticeVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/notice/update_notice_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}

				/***************************2.開始修改資料*****************************************/
				NoticeService noticeSvc = new NoticeService();
				noticeVO = noticeSvc.updateNotice(notice_no, user_id, noc_content, noc_date, noc_state);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("noticeVO", noticeVO); //資料庫update成功後,正確的的noticeVO物件,存入req
				String url = "/front-end/notice/listAllNotice.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); //修改成功後,轉交listOneNotice.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/notice/update_notice_input.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { // 來自addNotice.jsp的請求 
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				Integer noc_state = null;
				try {
					noc_state = new Integer(req.getParameter("noc_state").trim());
				} catch (NumberFormatException e) {
					noc_state = 0;
					errorMsgs.add("訂單狀態請填數字.");
				}
				
				
				String user_id = new String(req.getParameter("user_id").trim());
				

				String noc_content = req.getParameter("noc_content");
				String noc_contentReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (noc_content == null || noc_content.trim().length() == 0) {
					errorMsgs.add("評價內容: 請勿空白");
				} else if(!noc_content.trim().matches(noc_contentReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("評價內容: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }


				NoticeVO noticeVO = new NoticeVO();
				noticeVO.setNoc_state(noc_state);
				noticeVO.setUser_id(user_id);
				noticeVO.setNoc_content(noc_content);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("noticeVO", noticeVO); // 資料庫取出的noticeVO物件,存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/notice/addNotice.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始修改資料***************************************/
				NoticeService noticeSvc = new NoticeService();
				noticeVO = noticeSvc.addNotice(user_id, noc_content, noc_state);
				
				/***************************3.修改完成,準備轉交(Send the Success view)***********/
				String url = "/front-end/notice/listAllNotice.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneNotice.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/notice/addNotice.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("delete".equals(action)) { //來自listAllNotice.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer notice_no = new Integer(req.getParameter("notice_no"));
				
				/***************************2.開始刪除資料***************************************/
				NoticeService noticeSvc = new NoticeService();
				noticeSvc.deleteNotice(notice_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/notice/listAllNotice.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/notice/listAllNotice.jsp");
				failureView.forward(req, res);
			}
		}
	}
}

