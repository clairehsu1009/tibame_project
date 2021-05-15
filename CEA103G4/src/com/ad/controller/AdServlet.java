package com.ad.controller;

import java.io.*;
import java.sql.Date;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.ad.model.*;

@MultipartConfig
public class AdServlet extends HttpServlet {

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
				String str = req.getParameter("ad_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入廣告編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ad/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer ad_no = null;
				try {
					ad_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("廣告編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ad/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				AdService adSvc = new AdService();
				AdVO adVO = adSvc.getOneAd(ad_no);
				if (adVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ad/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("adVO", adVO); // 資料庫取出的adVO物件,存入req
				String url = "/back-end/ad/listOneAd.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneAd.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ad/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllAd.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer ad_no = new Integer(req.getParameter("ad_no"));
				
				/***************************2.開始查詢資料****************************************/
				AdService adSvc = new AdService();
				AdVO adVO = adSvc.getOneAd(ad_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("adVO", adVO);         // 資料庫取出的adVO物件,存入req
				String url = "/back-end/ad/update_ad_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_ad_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ad/listAllAd.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_ad_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer ad_no = new Integer(req.getParameter("ad_no").trim());

				Integer empno = new Integer(req.getParameter("empno").trim());
				
				String ad_content = req.getParameter("ad_content").trim();
				if (ad_content == null || ad_content.trim().length() == 0) {
					errorMsgs.add("廣告內容請勿空白");
				}
				
				AdVO adVO = new AdVO();
				byte[] ad_photo = null;
				Part part = req.getPart("ad_photo");
				if (part == null || part.getSize() == 0) {
					req.setAttribute("adVO", adVO);
					AdService adSvc2 = new AdService();
					AdVO adVO2 = adSvc2.getOneAd(ad_no);
					ad_photo = adVO2.getAd_photo();
				} else {
					req.setAttribute("adVO", adVO);
					InputStream in = part.getInputStream();
					ad_photo = new byte[in.available()];
					in.read(ad_photo);
					in.close();
				}
				
				Integer ad_state = new Integer(req.getParameter("ad_state").trim());
				
				java.sql.Date ad_start_date = null;
				try {
					ad_start_date = java.sql.Date.valueOf(req.getParameter("ad_start_date").trim());
				} catch (IllegalArgumentException e) {
					ad_start_date =new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入開始日期!");
				}
				
				java.sql.Date ad_end_date = null;
				try {
					ad_end_date = java.sql.Date.valueOf(req.getParameter("ad_end_date").trim());
				} catch (IllegalArgumentException e) {
					ad_end_date =new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入結束日期!");
				}
				
				String ad_url = req.getParameter("ad_url");

				adVO.setAd_no(ad_no);
				adVO.setEmpno(empno);
				adVO.setAd_content(ad_content);
				adVO.setAd_photo(ad_photo);
				adVO.setAd_state(ad_state);
				adVO.setAd_start_date(ad_start_date);
				adVO.setAd_end_date(ad_end_date);
				adVO.setAd_url(ad_url);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("adVO", adVO); // 含有輸入格式錯誤的adVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ad/update_ad_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				AdService adSvc = new AdService();
				
				adVO = adSvc.updateAd(ad_no, empno, ad_content, ad_photo, ad_state, ad_start_date, ad_end_date, ad_url);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("adVO", adVO); // 資料庫update成功後,正確的的adVO物件,存入req
				String url = "/back-end/ad/listOneAd.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneAd.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ad/update_ad_input.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { // 來自addAd.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				Integer empno = new Integer(req.getParameter("empno").trim());
				
				String ad_content = req.getParameter("ad_content");
				if (ad_content == null || ad_content.trim().length() == 0) {
					errorMsgs.add("廣告內容請勿空白");
				}
				
				Part part = req.getPart("ad_photo");
				InputStream in = part.getInputStream();
				byte[] ad_photo = new byte[in.available()];

				in.read(ad_photo);
				in.close();
				
				Integer ad_state = new Integer(req.getParameter("ad_state").trim());
				
				java.sql.Date ad_start_date = null;
				try {
				ad_start_date = java.sql.Date.valueOf(req.getParameter("ad_start_date").trim());
				} catch (IllegalArgumentException e) {
					ad_start_date=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				java.sql.Date ad_end_date = null;
				try {
					ad_end_date = java.sql.Date.valueOf(req.getParameter("ad_end_date").trim());
				} catch (IllegalArgumentException e) {
					ad_end_date=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				String ad_url = req.getParameter("ad_url");
				if (ad_url == null || ad_url.trim().length() == 0) {
					errorMsgs.add("商品網址請勿空白");
				}
				
				AdVO adVO = new AdVO();
				
				adVO.setEmpno(empno);
				adVO.setAd_content(ad_content);
				adVO.setAd_photo(ad_photo);
				adVO.setAd_state(ad_state);
				adVO.setAd_start_date(ad_start_date);
				adVO.setAd_end_date(ad_end_date);
				adVO.setAd_url(ad_url);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("adVO", adVO); // 含有輸入格式錯誤的adVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/ad/addAd.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
AdService adSvc = new AdService();
adVO = adSvc.addAd(empno, ad_content, ad_photo, ad_state, ad_start_date, ad_end_date, ad_url);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back-end/ad/listAllAd.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllAd.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ad/addAd.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("delete".equals(action)) { // 來自listAllAd.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer ad_no = new Integer(req.getParameter("ad_no"));
				
				/***************************2.開始刪除資料***************************************/
				AdService adSvc = new AdService();
				adSvc.deleteAd(ad_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/back-end/ad/listAllAd.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/ad/listAllAd.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
