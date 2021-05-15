package com.bid.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.bid.model.BidService;
import com.bid.model.BidVO;


public class BidServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
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
				String str = req.getParameter("bid_no");
				
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入得標編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/bid/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer bid_no = null;
				try {
					bid_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("得標編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/bid/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				BidService bidSvc = new BidService();
				BidVO bidVO = bidSvc.getOneBid(bid_no);
				if (bidVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/bid/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("bidVO", bidVO); // 資料庫取出的bidVO物件,存入req
				String url = "/front-end/bid/listOneBid.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/bid/select_page.jsp");
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
				Integer bid_no = new Integer(req.getParameter("bid_no"));

				/*************************** 2.開始查詢資料 ****************************************/
				BidService bidSvc = new BidService();
				BidVO bidVO = bidSvc.getOneBid(bid_no);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("bidVO", bidVO); // 資料庫取出的bidVO物件,存入req
				String url = "/front-end/bid/update_bid_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/bid/listAllBid.jsp");
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
				BidVO bidVO = new BidVO();
				
				String user_id = req.getParameter("user_id");
				Integer product_no = new Integer(req.getParameter("product_no").trim());
				Integer bid_price = new Integer(req.getParameter("bid_price").trim());
				Integer bid_no = new Integer(req.getParameter("bid_no").trim());

				bidVO.setUser_id(user_id);
				bidVO.setProduct_no(product_no);
				bidVO.setBid_price(bid_price);
				bidVO.setBid_no(bid_no);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("bidVO", bidVO); // 含有輸入格式錯誤的bidVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/bid/update_bid_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				BidService bidSvc = new BidService();
				bidVO = bidSvc.updateBid( user_id,product_no,bid_price,bid_no);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("bidVO", bidVO); // 資料庫update成功後,正確的的bidVO物件,存入req
				String url = "/front-end/bid/listOneBid.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/bid/update_bid_input.jsp");
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
				BidVO bidVO = new BidVO();

				String user_id = req.getParameter("user_id");
				Integer product_no = new Integer(req.getParameter("product_no").trim());
				Integer bid_price = new Integer(req.getParameter("bid_price").trim());
				

				bidVO.setUser_id(user_id);
				bidVO.setProduct_no(product_no);
				bidVO.setBid_price(bid_price);
	
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("bidVO", bidVO); // 含有輸入格式錯誤的bidVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/bid/addBid.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始新增資料 ***************************************/
				BidService bidSvc = new BidService();
				bidVO = bidSvc.addBid(user_id,product_no,bid_price);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front-end/bid/listAllBid.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/bid/addBid.jsp");
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
				Integer bid_no = new Integer(req.getParameter("bid_no"));

				/*************************** 2.開始刪除資料 ***************************************/
				BidService bidSvc = new BidService();
				bidSvc.deleteBid(bid_no);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/front-end/bid/listAllBid.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/bid/listAllBid.jsp");
				failureView.forward(req, res);
			}
		}
	}
}