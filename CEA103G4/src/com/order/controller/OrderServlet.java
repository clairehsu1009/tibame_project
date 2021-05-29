package com.order.controller;

import java.io.*;
import java.util.*;
import java.util.Map.Entry;

import javax.servlet.*;
import javax.servlet.http.*;

import org.json.JSONObject;

import com.live_order.model.Live_orderService;
import com.live_order_detail.model.Live_order_detailVO;
import com.notice.model.NoticeService;
import com.order.model.OrderService;
import com.order.model.OrderVO;
import com.order_detail.model.Order_detailService;
import com.order_detail.model.Order_detailVO;
import com.product.model.ProductService;
import com.product.model.ProductVO;
import com.user.model.UserService;
import com.user.model.UserVO;

public class OrderServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	@SuppressWarnings("unlikely-arg-type")
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Add".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("product_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入產品編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer product_no = null;
				try {
					product_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				ProductService productSvc = new ProductService();
				ProductVO productVO = productSvc.getOneProduct(product_no);

				if (productVO == null) {
					errorMsgs.add("查無資料");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("productVO", productVO); // 資料庫取出的productVO物件,存入req
				String url = "/front-end/order/addOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 addOrder.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Insert".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("product_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入產品編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer product_no = null;
				try {
					product_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("編號格式不正確");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				ProductService productSvc = new ProductService();
				ProductVO productVO = productSvc.getOneProduct(product_no);
				if (productVO == null) {
					errorMsgs.add("查無資料");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("productVO", productVO); // 資料庫取出的productVO物件,存入req
				String url = "/front-end/order/addOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 addOrder.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("order_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入訂單編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/select_page.jsp");
					failureView.forward(req, res);
					return;// {程式中斷
				}

				Integer order_no = null;
				try {
					order_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("訂單編號格式不正確");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/select_page.jsp");
					failureView.forward(req, res);
					return;// {程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				OrderService orderSvc = new OrderService();
				OrderVO orderVO = orderSvc.getOneOrder(order_no);
				if (orderVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("orderVO", orderVO); // 資料庫取出的orderVO物件,存入req
				String url = "/front-end/order/listOneOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneOrder.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllOrder.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer order_no = new Integer(req.getParameter("order_no"));

				/*************************** 2.開始查詢資料 ****************************************/
				OrderService orderSvc = new OrderService();
				OrderVO orderVO = orderSvc.getOneOrder(order_no);

				/*************************** 3查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("orderVO", orderVO); // 資料庫取出的orderVO物件,存入req
				String url = "/front-end/order/update_order_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_order_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/listAllOrder.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自update_order_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				java.sql.Timestamp order_date = null;
				try {
					order_date = java.sql.Timestamp.valueOf(req.getParameter("order_date").trim());
				} catch (IllegalArgumentException e) {
					order_date = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				Integer order_state = null;
				try {
					order_state = new Integer(req.getParameter("order_state").trim());
				} catch (NumberFormatException e) {
					order_state = 0;
					errorMsgs.add("狀態請填數字.");
				}

				Integer order_shipping = null;
				try {
					order_shipping = new Integer(req.getParameter("order_shipping").trim());
				} catch (NumberFormatException e) {
					order_shipping = 0;
					errorMsgs.add("運費請填數字.");
				}

				Integer order_price = null;
				try {
					order_price = new Integer(req.getParameter("order_price").trim());
				} catch (NumberFormatException e) {
					order_price = 0;
					errorMsgs.add("訂單金額請填數字.");
				}

				Integer pay_method = null;
				try {
					pay_method = new Integer(req.getParameter("pay_method").trim());
				} catch (NumberFormatException e) {
					pay_method = 0;
					errorMsgs.add("付款方式請填數字.");
				}

				java.sql.Timestamp pay_deadline = null;
				try {
					pay_deadline = java.sql.Timestamp.valueOf(req.getParameter("pay_deadline").trim());
				} catch (IllegalArgumentException e) {
					pay_deadline = new java.sql.Timestamp(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				String rec_name = req.getParameter("rec_name");
				String rec_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (rec_name == null || rec_name.trim().length() == 0) {
					errorMsgs.add("收件人姓名: 請勿空白");
				} else if (!rec_name.trim().matches(rec_nameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("收件人姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}
				String zipcode = req.getParameter("zipcode");
				if (zipcode == null || zipcode.trim().length() == 0) {
					errorMsgs.add("請選擇郵遞區號");
				}
				String city = req.getParameter("city");
				String town = req.getParameter("town");

				String rec_addr = req.getParameter("rec_addr");
				String rec_addrReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,30}$";
				if (rec_addr == null || rec_addr.trim().length() == 0) {
					errorMsgs.add("收件人地址: 請勿空白");
				} else if (!rec_addr.trim().matches(rec_addrReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("收件人地址: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

				String rec_phone = req.getParameter("rec_phone");

				String rec_cellphone = req.getParameter("rec_cellphone");
				String rec_cellphoneReg = "^09[0-9]{8}$";
				if (rec_cellphone == null || rec_cellphone.trim().length() == 0) {
					errorMsgs.add("手機號碼: 請勿空白");
				} else if (!rec_cellphone.trim().matches(rec_cellphoneReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("手機號碼: 只能是數字 , 且長度是10");
				}

				Integer logistics = null;
				try {
					logistics = new Integer(req.getParameter("logistics").trim());
				} catch (NumberFormatException e) {
					logistics = 0;
					errorMsgs.add("物流方式請填數字.");
				}

				Integer logisticsstate = null;
				try {
					logisticsstate = new Integer(req.getParameter("logisticsstate").trim());
				} catch (NumberFormatException e) {
					logisticsstate = 0;
					errorMsgs.add("物流狀態請填數字.");
				}

				Integer discount = null;
				try {
					discount = new Integer(req.getParameter("discount").trim());
				} catch (NumberFormatException e) {
					discount = 0;
					errorMsgs.add("點數折抵請填數字.");
				}
				String user_id = new String(req.getParameter("user_id").trim());

				String seller_id = new String(req.getParameter("seller_id").trim());

				Integer srating = null;
				try {
					srating = new Integer(req.getParameter("srating").trim());
				} catch (NumberFormatException e) {
					srating = 0;
					errorMsgs.add("評價分數請填數字.");
				}

				String srating_content = req.getParameter("srating_content");
				String srating_contentReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
				if (srating_content == null || srating_content.trim().length() == 0) {
					errorMsgs.add("評價內容: 請勿空白");
				} else if (!srating_content.trim().matches(srating_contentReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("評價內容: 只能是中、英文字母、數字和_ , 且長度必需在2到20之間");
				}

				Integer point = null;
				try {
					point = new Integer(req.getParameter("point").trim());
				} catch (NumberFormatException e) {
					point = 0;
					errorMsgs.add("點數請填數字.");
				}
				Integer order_no = new Integer(req.getParameter("order_no"));

				OrderVO orderVO = new OrderVO();
				orderVO.setOrder_date(order_date);
				orderVO.setOrder_state(order_state);
				orderVO.setOrder_shipping(order_shipping);
				orderVO.setOrder_price(order_price);
				orderVO.setPay_method(pay_method);
				orderVO.setPay_deadline(pay_deadline);
				orderVO.setRec_name(rec_name);
				orderVO.setZipcode(zipcode);
				orderVO.setCity(city);
				orderVO.setTown(town);
				orderVO.setRec_addr(rec_addr);
				orderVO.setRec_phone(rec_phone);
				orderVO.setRec_cellphone(rec_cellphone);
				orderVO.setLogistics(logistics);
				orderVO.setLogisticsstate(logisticsstate);
				orderVO.setDiscount(discount);
				orderVO.setUser_id(user_id);
				orderVO.setSeller_id(seller_id);
				orderVO.setSrating(srating);
				orderVO.setSrating_content(srating_content);
				orderVO.setPoint(point);
				orderVO.setOrder_no(order_no);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("orderVO", orderVO); // 含有輸入格式錯誤的orderVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/update_order_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				OrderService orderSvc = new OrderService();
				orderVO = orderSvc.updateOrder(order_date, order_state, order_shipping, order_price, pay_method,
						pay_deadline, rec_name, zipcode, city, town, rec_addr, rec_phone, rec_cellphone, logistics,
						logisticsstate, discount, user_id, seller_id, srating, srating_content, point, order_no);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("orderVO", orderVO); // 資料庫update成功後,正確的的orderVO物件,存入req
				String url = "/front-end/order/listAllOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneOrder.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/update_order_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("insert".equals(action)) { // 來自addOrder.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				Integer product_no = new Integer(req.getParameter("product_no").trim());

				Integer product_remaining = new Integer(req.getParameter("product_remaining").trim());

				Integer product_state = new Integer(req.getParameter("product_state").trim());
				try {
					product_state = new Integer(req.getParameter("product_state").trim());
				} catch (NumberFormatException e) {
					product_state = 0;
					errorMsgs.add("產品狀態請選數字.");
				}

				Integer product_num = null;
				try {
					product_num = new Integer(req.getParameter("product_num").trim());
				} catch (NumberFormatException e) {
					product_num = 0;
					errorMsgs.add("產品數量請填數字.");
				}

				Integer order_state = new Integer(req.getParameter("order_state").trim());

				Integer order_shipping = new Integer(req.getParameter("order_shipping").trim());

				Integer order_price = null;
				try {
					order_price = new Integer(req.getParameter("order_price").trim());
				} catch (NumberFormatException e) {
					order_price = 0;
					errorMsgs.add("訂單金額請填數字.");
				}

				Integer pay_method = null;
				try {
					pay_method = new Integer(req.getParameter("pay_method").trim());
				} catch (NumberFormatException e) {
					pay_method = 0;
					errorMsgs.add("付款方式請填數字.");
				}

				String rec_name = req.getParameter("rec_name");
				String rec_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (rec_name == null || rec_name.trim().length() == 0) {
					errorMsgs.add("收件人姓名: 請勿空白");
				} else if (!rec_name.trim().matches(rec_nameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("收件人姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

				String zipcode = req.getParameter("zipcode");
				String city = req.getParameter("city");
				String town = req.getParameter("town");

				String rec_addr = req.getParameter("rec_addr");
				String rec_addrReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,30}$";
				if (rec_addr == null || rec_addr.trim().length() == 0) {
					errorMsgs.add("收件人地址: 請勿空白");
				} else if (!rec_addr.trim().matches(rec_addrReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("收件人地址: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

				String rec_phone = req.getParameter("rec_phone");

				String rec_cellphone = req.getParameter("rec_cellphone");
				String rec_cellphoneReg = "^09[0-9]{8}$";
				if (rec_cellphone == null || rec_cellphone.trim().length() == 0) {
					errorMsgs.add("手機號碼: 請勿空白");
				} else if (!rec_cellphone.trim().matches(rec_cellphoneReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("手機號碼: 只能是數字 , 且長度必需是10");
				}

				Integer logistics = null;
				try {
					logistics = new Integer(req.getParameter("logistics").trim());
				} catch (NumberFormatException e) {
					logistics = 0;
					errorMsgs.add("物流方式請填數字.");
				}

				Integer logisticsstate = null;
				try {
					logisticsstate = new Integer(req.getParameter("logisticsstate").trim());
				} catch (NumberFormatException e) {
					logisticsstate = 0;
					errorMsgs.add("物流狀態請填數字.");
				}

				Integer discount = null;
				try {
					discount = new Integer(req.getParameter("discount").trim());
				} catch (NumberFormatException e) {
					discount = 0;
					errorMsgs.add("折扣點數請填數字.");
				}

				String user_id = new String(req.getParameter("user_id").trim());

				String seller_id = new String(req.getParameter("seller_id").trim());

				Integer srating = null;
				try {
					srating = new Integer(req.getParameter("srating").trim());
				} catch (NumberFormatException e) {
					srating = 0;
					errorMsgs.add("評價分數請填數字.");
				}

				String srating_content = req.getParameter("srating_content");

				Integer point = null;
				try {
					point = new Integer(req.getParameter("point").trim());
				} catch (NumberFormatException e) {
					point = 0;
					errorMsgs.add("點數請填數字.");
				}

				if ((product_remaining - product_num) > 0) {
					product_remaining -= product_num;
				} else if ((product_remaining - product_num) == 0) {
					product_remaining -= product_num;
					product_state = 3; // 售完狀態變更為已售出
				}

				OrderVO orderVO = new OrderVO();
				orderVO.setOrder_state(order_state);
				orderVO.setOrder_shipping(order_shipping);
				orderVO.setOrder_price(order_price);
				orderVO.setPay_method(pay_method);
				orderVO.setRec_name(rec_name);
				orderVO.setZipcode(zipcode);
				orderVO.setCity(city);
				orderVO.setTown(town);
				orderVO.setRec_addr(rec_addr);
				orderVO.setRec_phone(rec_phone);
				orderVO.setRec_cellphone(rec_cellphone);
				orderVO.setLogistics(logistics);
				orderVO.setLogisticsstate(logisticsstate);
				orderVO.setDiscount(discount);
				orderVO.setUser_id(user_id);
				orderVO.setSeller_id(seller_id);
				orderVO.setSrating(srating);
				orderVO.setSrating_content(srating_content);
				orderVO.setPoint(point);

				ProductVO productVO = new ProductVO();
				productVO.setProduct_no(product_no);
				productVO.setProduct_remaining(product_remaining);
				productVO.setProduct_state(product_state);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("orderVO", orderVO); // 資料庫取出的orderVO物件,存入req
//					req.setAttribute("productVO", productVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/addOrder.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始修改資料 ***************************************/
				OrderService orderSvc = new OrderService();
				orderVO = orderSvc.addOrder(order_state, order_shipping, order_price, pay_method, rec_name, zipcode,
						city, town, rec_addr, rec_phone, rec_cellphone, logistics, logisticsstate, discount, user_id,
						seller_id, srating, srating_content, point);

				Order_detailVO order_detailVO = new Order_detailVO();
				Integer order_no = orderVO.getOrder_no();
				order_detailVO.setOrder_no(order_no);
				order_detailVO.setOrder_price(order_price);
				order_detailVO.setProduct_no(product_no);
				order_detailVO.setProduct_num(product_num);

				ProductService productSvc = new ProductService();
//				productVO = productSvc.updateProductRemaining(product_no, product_remaining, product_state);

				Order_detailService order_detailSvc = new Order_detailService();
				order_detailVO = order_detailSvc.addOrder_detail(order_no, product_no, product_num, order_price);

				/*************************** 3.修改完成,準備轉交(Send the Success view) ***********/
				String url = "/front-end/order/listAllOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listAllOrder.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/order/addOrder.jsp");
				failureView.forward(req, res);
			}
		}

		if ("cancel".equals(action)) { // 來自listAllOrder.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer order_no = new Integer(req.getParameter("order_no"));
				Integer order_price = new Integer(req.getParameter("order_price"));
				Integer cash = new Integer(req.getParameter("cash"));
				String user_id = req.getParameter("user_id");
				
				/*************************** 2.開始刪除資料 ***************************************/
				OrderService orderSvc = new OrderService();
				orderSvc.cancelOrder(order_no); //取消訂單
				System.out.println("取消訂單： "+ order_no);
				UserService userSvc = new UserService();
				cash +=order_price;
				userSvc.updateCash(cash,user_id); //返還金額
				System.out.println("返還金額： "+ order_price);
				
				Set<Order_detailVO> set = orderSvc.getDetailsByNo(order_no);
			
				ProductService productSvc = new ProductService();
				System.out.println("list-size:"+set.size());
				
				for(Order_detailVO odv : set) {
					Integer product_remaining = productSvc.getOneProduct(odv.getProduct_no()).getProduct_remaining();
					Integer product_sold = productSvc.getOneProduct(odv.getProduct_no()).getProduct_sold();
					System.out.println("check1");
					Integer product_state = productSvc.getOneProduct(odv.getProduct_no()).getProduct_state();
					product_remaining +=  odv.getProduct_num();
					product_sold -= odv.getProduct_num();
					System.out.println("check");
					if(product_state == 3) {
						product_state = 1;
					}
					System.out.println("商品："+ odv.getProduct_no()+"庫存補回："+product_remaining+"商品售出數量："+product_sold+"商品狀態："+product_state);
					productSvc.updateProductRemaining(odv.getProduct_no(), product_remaining,product_sold, product_state);
				} //更換商品狀態及庫存復原
				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/front-end/orderManagement/OrderListA.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/orderManagement/OrderListA.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("listDetails_ByNo".equals(action) || "listDetails_ByNo_B".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer order_no = new Integer(req.getParameter("order_no"));
				
				/*************************** 2.開始查詢資料 ****************************************/
				OrderService orderSvc = new OrderService();
				Set<Order_detailVO> set = orderSvc.getDetailsByNo(order_no);
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("listDetails_ByNo", set);    // 資料庫取出的list物件,存入request
				String url = null;
				if ("listDetails_ByNo".equals(action))
					url = "/front-end/orderManagement/OrderListA.jsp";              // 成功轉交 dept/listAllDept.jsp
				else if ("listDetails_ByNo_B".equals(action))
					url = "/front-end/orderManagement/OrderListB.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
		
		if ("shipped".equals(action)) { // 來自update_order_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				List<Integer> list = new ArrayList<Integer>();

				String order_no_arr[] = req.getParameterValues("order_no");

				for (String s : order_no_arr) {
					Integer order_no = new Integer(s);
					list.add(order_no);
				}
				;

				/*************************** 2.開始修改資料 *****************************************/
				OrderService orderSvc = new OrderService();
				orderSvc.updateShipped(list);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				String url = "/front-end/orderManagement/OrderListB.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/orderManagement/OrderListB.jsp");
				failureView.forward(req, res);
			}
		}
		if ("unshipped".equals(action)) { // 來自update_order_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				List<Integer> list = new ArrayList<Integer>();

				String order_no_arr[] = req.getParameterValues("order_no");

				for (String s : order_no_arr) {
					Integer order_no = new Integer(s);
					list.add(order_no);
				}
				;

				/*************************** 2.開始修改資料 *****************************************/
				OrderService orderSvc = new OrderService();
				orderSvc.updateUnshipped(list);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				String url = "/front-end/orderManagement/OrderListB.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/orderManagement/OrderListB.jsp");
				failureView.forward(req, res);
			}
		}

		if ("updateSrating".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				String seller_id = req.getParameter("seller_id");

				Integer order_no = null;
				try {
					order_no = new Integer(req.getParameter("order_no").trim());
				} catch (NumberFormatException e) {
					errorMsgs.add("訂單編號非數字.");
				}

				Integer srating = null;
				try {
					srating = new Integer(req.getParameter("srating").trim());
				} catch (NumberFormatException e) {
					errorMsgs.add("請選擇評分");
				}

				String srating_content = req.getParameter("srating_content");
				
				Integer logisticsstate = 2;
				/*************************** 2.開始修改資料 *****************************************/
				OrderService orderSvc = new OrderService();
				orderSvc.updateSrating(srating, srating_content,logisticsstate ,order_no);//更新評價 已取貨預留更改
				
				UserService userSvc = new UserService();
				userSvc.updateUserRating(srating, 1, seller_id); // seller_id轉user_id
				
				OrderVO orderVO = orderSvc.getOneOrder(order_no);
				Integer price =orderVO.getOrder_price();
				userSvc.addCash(price, seller_id);//訂單完成撥款給賣家
				
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				String url = "/front-end/orderManagement/OrderListA.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/orderManagement/OrderListA.jsp");
				failureView.forward(req, res);
			}
		}

		if ("addOrderList".equals(action)) { // 來自addOrder.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			HttpSession session = req.getSession();
			session.removeAttribute("shoppingcart");
			try {

				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				
				String rec_name = req.getParameter("rec_name");
				String zipcode = req.getParameter("zipcode");
				String city = req.getParameter("city");
				String town = req.getParameter("town");
				String rec_addr = req.getParameter("rec_addr");
				String rec_phone = req.getParameter("rec_phone");
				String rec_cellphone = req.getParameter("rec_cellphone");
				String user_id = req.getParameter("user_id");
				Integer point = 0; //判斷 依照總金額傳送點數到後端
				Integer discount = 0; //前端取值 顧客用多少點數折抵（最後實現）
				Integer order_state = 1; // 訂單狀態 預設已付款
				Integer order_shipping = 1; // 物流方式 預設宅配
				Integer logistics = 1;
				Integer pay_method = 1;
				
				@SuppressWarnings("unchecked")
				Map<String, Vector<ProductVO>> mBuylist = (Map<String, Vector<ProductVO>>) req.getSession()
						.getAttribute("list");

				for (String seller_id : mBuylist.keySet()) {

					OrderVO orderVO = new OrderVO();
					orderVO.setOrder_state(order_state);
					orderVO.setOrder_shipping(order_shipping);
					orderVO.setPay_method(pay_method);
					orderVO.setRec_name(rec_name);
					orderVO.setZipcode(zipcode);
					orderVO.setCity(city);
					orderVO.setTown(town);
					orderVO.setRec_addr(rec_addr);
					orderVO.setRec_phone(rec_phone);
					orderVO.setRec_cellphone(rec_cellphone);
					orderVO.setLogistics(logistics);
					orderVO.setDiscount(discount);
					orderVO.setUser_id(user_id);
					orderVO.setSeller_id(seller_id);
					orderVO.setPoint(point);
					List<Order_detailVO> list = new ArrayList<Order_detailVO>();
					Integer order_price = 0;
					
					Vector<ProductVO> productlist = mBuylist.get(seller_id);
					System.out.println("訂單筆數為:"+productlist.size());

					for (ProductVO asd : productlist) {
						Order_detailVO order_detailVO = new Order_detailVO();
						
						int price	= asd.getProduct_price() * asd.getProduct_quantity();
						order_price += price;
						
						order_detailVO.setOrder_price(price);
						order_detailVO.setProduct_no(asd.getProduct_no());
						order_detailVO.setProduct_num(asd.getProduct_quantity());
						list.add(order_detailVO);
						
						Integer remaining = null;
						Integer sold = null;
						ProductService productSvc = new ProductService();
						if(asd.getProduct_remaining()-asd.getProduct_quantity()>0) {
							remaining = asd.getProduct_remaining() - asd.getProduct_quantity();
							sold = productSvc.getOneProduct(asd.getProduct_no()).getProduct_sold();				
							sold += asd.getProduct_quantity();
							System.out.println("產品： "+ asd.getProduct_no()+"庫存： "+remaining+"已售出： "+sold+"商品狀態： "+asd.getProduct_state());
							productSvc.updateProductRemaining(asd.getProduct_no(), remaining ,sold, asd.getProduct_state());
						}else {
							remaining = asd.getProduct_remaining() - asd.getProduct_quantity();
							sold = productSvc.getOneProduct(asd.getProduct_no()).getProduct_sold();
							sold += asd.getProduct_quantity();
							System.out.println("產品： "+ asd.getProduct_no()+"庫存： "+remaining+"已售出： "+sold+"商品狀態： "+asd.getProduct_state());
							productSvc.updateProductRemaining(asd.getProduct_no(), remaining ,sold, 3);//售完狀態變更為已售出
						}
					}					

					/*************************** 2.開始修改資料 ***************************************/
					OrderService orderSvc = new OrderService();
					orderVO.setOrder_price(order_price); //單筆訂單金額
					orderSvc.insertWithDetails(orderVO, list);
					System.out.println("訂單金額"+order_price);
	
					UserService userSvc = new UserService();
					UserVO userVO = userSvc.getOneUser(user_id);
					Integer nowMoney = userVO.getCash();
					nowMoney -= order_price;
					System.out.println("現在錢包"+nowMoney);
					userSvc.updateCash(nowMoney, user_id);
					//買家扣款
				}
				
				/*************************** 3.修改完成,準備轉交(Send the Success view) ***********/
				mBuylist.remove(mBuylist);//刪除購物車
				String url = "/front-end/orderManagement/OrderListA.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交index.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/index.jsp");
				failureView.forward(req, res);
				System.out.println(errorMsgs);
			}
		}

//		if ("pay".equals(action)) { //付款方式有多種在修正
//
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//
//			try {
//				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
//
//				String user_id = req.getParameter("user_id");
//
//				Integer order_no = new Integer(req.getParameter("order_no"));;
//
//				Integer order_price = new Integer(req.getParameter("order_price"));
//				
//				/*************************** 2.開始修改資料 *****************************************/
//				OrderService orderSvc = new OrderService();
//				orderSvc.updateSrating(srating, srating_content, order_no);//更新評價
//				
//				UserService userSvc = new UserService();
//				userSvc.updateUserRating(srating, 1, seller_id); // seller_id轉user_id
//				
//				OrderVO orderVO = orderSvc.getOneOrder(order_no);
//				Integer price =orderVO.getOrder_price();
//				userSvc.addCash(price, seller_id);//訂單完成撥款給賣家
//				
//				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
//				String url = "/front-end/orderManagement/OrderListA.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
//				successView.forward(req, res);
//
//				/*************************** 其他可能的錯誤處理 *************************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得資料:" + e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/orderManagement/OrderListA.jsp");
//				failureView.forward(req, res);
//			}
//		}
		
	}
}
