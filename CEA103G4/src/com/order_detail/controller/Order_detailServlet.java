package com.order_detail.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.model.OrderService;
import com.order_detail.model.Order_detailDAO;
import com.order_detail.model.Order_detailService;
import com.order_detail.model.Order_detailVO;


@WebServlet("/Order_detailServlet")
public class Order_detailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
//		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp 或  /dept/listEmps_ByDeptno.jsp 的請求
//
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】		
//			
//			try {
//				/***************************1.接收請求參數****************************************/
//				Integer order_no = new Integer(req.getParameter("order_no"));
//				
//				/***************************2.開始查詢資料****************************************/
//				Order_detailService order_detailSvc = new Order_detailService();
//				Order_detailVO order_detailVO = order_detailSvc.getOneOrder_detail(order_no);
//								
//				/***************************3.查詢完成,準備轉交(Send the Success view)************/
//				req.setAttribute("order_detailVO", order_detailVO); // 資料庫取出的live_order_detailVO物件,存入req
//				String url = "/front-end/order_detail/update_detail_input.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_emp_input.jsp
//				successView.forward(req, res);
//
//				/***************************其他可能的錯誤處理************************************/
//			} catch (Exception e) {
//				errorMsgs.add("修改資料取出時失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher(requestURL);
//				failureView.forward(req, res);
//			}
//		}
		
//		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
//			
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/front-end/live_order_detail/listAllDetail.jsp】 或  【/front-end/live_order/listDetails_ByNo.jsp】 或 【 /front-end/live_order/listAllLive_order.jsp】
//		
//			try {
//				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				Integer order_no = new Integer(req.getParameter("order_no").trim());
//				Integer product_no = new Integer(req.getParameter("product_no").trim());
//				Integer price = new Integer(req.getParameter("price").trim());
//				Integer product_num = new Integer(req.getParameter("product_num").trim());
//				
//				Order_detailVO order_detailVO = new Order_detailVO();
//				order_detailVO.setOrder_no(order_no);
//				order_detailVO.setProduct_no(product_no);
//				order_detailVO.setOrder_price(price);
//				order_detailVO.setProduct_num(product_num);
//
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("order_detailVO", order_detailVO); // 含有輸入格式錯誤的live_order_detailVO物件,也存入req
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-ent/order_detail.update_detail_input.jsp");
//					failureView.forward(req, res);
//					return; //程式中斷
//				}
//				
//				/***************************2.開始修改資料*****************************************/
//				Order_detailService order_detailSvc = new Order_detailService();
//				order_detailVO = order_detailSvc.updateOrder_detail(order_no,product_no,price,product_num);
//				
//				/***************************3.修改完成,準備轉交(Send the Success view)*************/				
//				OrderService orderSvc = new OrderService();
//				if(requestURL.equals("/front-end/order/listDetails_ByNo.jsp") || requestURL.equals("/front-end/order/listAllLive_order.jsp"))
//					req.setAttribute("listDetails_ByNo",orderSvc.getDetailsByNo(order_no)); // 資料庫取出的list物件,存入request
//
//                String url = requestURL;
//				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
//				successView.forward(req, res);
//
//				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("修改資料失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front-ent/live_order_detail/update_detail_input.jsp");
//				failureView.forward(req, res);
//			}
//		}

//        if ("insert".equals(action)) { // 來自addEmp.jsp的請求  
//			
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
//				Integer order_no = new Integer(req.getParameter("order_no").trim());
//				Integer product_no = new Integer(req.getParameter("product_no").trim());
//				Integer order_price = new Integer(req.getParameter("order_price").trim());
//				Integer product_num = new Integer(req.getParameter("product_num").trim());
//				
//				Order_detailVO order_detailVO = new Order_detailVO();
//				order_detailVO.setOrder_no(order_no);
//				order_detailVO.setProduct_no(product_no);
//				order_detailVO.setOrder_price(order_price);
//				order_detailVO.setProduct_num(product_num);
//
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("order_detailVO", order_detailVO); // 含有輸入格式錯誤的live_order_detailVO物件,也存入req
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/order_detail/addDetail.jsp");
//					failureView.forward(req, res);
//					return;
//				}
//				
//				/***************************2.開始新增資料***************************************/
//				Order_detailService order_detailSvc = new Order_detailService();
//				order_detailVO = order_detailSvc.addOrder_detail(order_no,product_no,order_price,product_num);
//				
//				/***************************3.新增完成,準備轉交(Send the Success view)***********/
//				String url = "/front-end/live_order_detail/listAllDetail.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
//				successView.forward(req, res);				
//				
//				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e) {
//				errorMsgs.add(e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front-end/live_order_detail/addDetail.jsp");
//				failureView.forward(req, res);
//			}
//		}
		
       
//		if ("delete".equals(action)) { // 來自listAllEmp.jsp 或  /front-end/live_order/listDetails_ByNo.jsp的請求
//
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//			String requestURL = req.getParameter("requestURL"); // 送出刪除的來源網頁路徑: 可能為【/front-end/live_order_detail/listAllDetail.jsp】 或  【/front-end/live_order/listDetails_ByNo.jsp】 或 【 /front-end/live_order/listAllLive_order.jsp】
//
//			try {
//				/***************************1.接收請求參數***************************************/
//				Integer order_no = new Integer(req.getParameter("order_no"));
//				
//				/***************************2.開始刪除資料***************************************/
//				Order_detailService order_detailSvc = new Order_detailService();
//				Order_detailVO order_detailVO = order_detailSvc.getOneOrder_detail(order_no);
//				order_detailSvc.deleteOrder_detail(order_no);
//				
//				/***************************3.刪除完成,準備轉交(Send the Success view)***********/
//				OrderService orderSvc = new OrderService();
//				if(requestURL.equals("/front-end/order/listDetails_ByNo.jsp") || requestURL.equals("/front-end/order/listAllOrder.jsp"))
//					req.setAttribute("listDetails_ByNo",orderSvc.getDetailsByNo(order_detailVO.getOrder_no())); // 資料庫取出的list物件,存入request
//				
//				String url = requestURL;
//System.out.println("url" +url);
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 刪除成功後,轉交回送出刪除的來源網頁
//				successView.forward(req, res);
//				
//				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e) {
//				errorMsgs.add("刪除資料失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher(requestURL);
//				failureView.forward(req, res);
//			}
//		}
		
	}
}
