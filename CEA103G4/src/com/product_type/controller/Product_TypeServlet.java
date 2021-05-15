package com.product_type.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.product.model.ProductVO;
import com.product_type.model.Product_TypeService;
import com.product_type.model.Product_TypeVO;

public class Product_TypeServlet  extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
		try {
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("pdtype_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入商品類別編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/product_type/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer pdtype_no = null;
				try {
					pdtype_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("商品類別編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/product_type/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				Product_TypeService product_typeSvc = new Product_TypeService();
				Product_TypeVO product_typeVO = product_typeSvc.getOneProduct_Type(pdtype_no);
				if (product_typeVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/product_type/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("product_typeVO", product_typeVO); // 資料庫取出的product_typeVO物件,存入req
				String url = "/back-end/product_type/listOneProduct_Type.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneProduct_Tyep.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/product_type/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllProduct_Type.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer pdtype_no = new Integer(req.getParameter("pdtype_no"));
				
				/***************************2.開始查詢資料****************************************/
				Product_TypeService product_typeSvc = new Product_TypeService();
				Product_TypeVO product_typeVO = product_typeSvc.getOneProduct_Type(pdtype_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("product_typeVO", product_typeVO);         
				String url = "/back-end/productManagement/backUpdatePdtype.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/productManagement/backProductType.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_product_type_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				Integer pdtype_no = new Integer(req.getParameter("pdtype_no").trim());
				
				String pdtype_name = req.getParameter("pdtype_name");
				String pdtype_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
				if (pdtype_name == null || pdtype_name.trim().length() == 0) {
					errorMsgs.add("商品類別名稱: 請勿空白");
				} else if(!pdtype_name.trim().matches(pdtype_nameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("商品類別名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到20之間");
	            }
				
				Product_TypeVO product_typeVO = new Product_TypeVO();
				product_typeVO.setPdtype_no(pdtype_no);
				product_typeVO.setPdtype_name(pdtype_name);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("product_typeVO", product_typeVO); // 含有輸入格式錯誤的product_typeVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/productManagement/backUpdatePdtype.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				Product_TypeService product_typeSvc = new Product_TypeService();
				product_typeVO = product_typeSvc.updateProduct_Type(pdtype_no, pdtype_name);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("product_typeVO", product_typeVO); // 資料庫update成功後,正確的的product_typeVO物件,存入req
				String url = "/back-end/productManagement/backProductType.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneProduct_Type.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/productManagement/backUpdatePdtype.jsp");
				failureView.forward(req, res);
			}
		}

        if ("insert".equals(action)) { // 來自addProduct_Type.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String pdtype_name = req.getParameter("pdtype_name");

				String pdtype_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
				if (pdtype_name == null || pdtype_name.trim().length() == 0) {
					errorMsgs.add("商品類別名稱: 請勿空白");
				} else if(!pdtype_name.trim().matches(pdtype_nameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("商品類別名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到20之間");
	            }
				
				Product_TypeVO product_typeVO = new Product_TypeVO();
				product_typeVO.setPdtype_name(pdtype_name);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("product_typeVO", product_typeVO); // 含有輸入格式錯誤的product_typeVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/productManagement/backProductType.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始新增資料*****************************************/
				Product_TypeService product_typeSvc = new Product_TypeService();
				product_typeVO = product_typeSvc.addProduct_Type(pdtype_name);
				
				/***************************3.新增完成,準備轉交(Send the Success view)*************/
				String url = "/back-end/productManagement/backProductType.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後,轉交listAllProduct_Type.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/productManagement/backProductType.jsp");
				failureView.forward(req, res);
			}
		}
				
		if ("delete".equals(action)) { // 來自listAllProduct_Type.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer pdtype_no = new Integer(req.getParameter("pdtype_no"));
				
				/***************************2.開始刪除資料***************************************/
				Product_TypeService product_typeSvc = new Product_TypeService();
				product_typeSvc.deleteProduct_Type(pdtype_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/back-end/product_type/listAllProduct_Type.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/product_type/listAllProduct_Type.jsp");
				failureView.forward(req, res);
			}
		}
	    // 來自product select_page.jsp的請求                                  
			if ("getProductsByPdtype".equals(action)) {

				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/*************************** 1.接收請求參數 ****************************************/
					Integer pdtype_no = new Integer(req.getParameter("pdtype_no"));

					/*************************** 2.開始查詢資料 ****************************************/
					Product_TypeService product_typeSvc = new Product_TypeService();
					Set<ProductVO> set = product_typeSvc.getProductsByPdtype_no(pdtype_no);

					/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
					req.setAttribute("products", set);    // 資料庫取出的set物件,存入request

					String url = null;
					url = "/front-end/productsell/shop.jsp";
					
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);

					/*************************** 其他可能的錯誤處理 ***********************************/
				} catch (Exception e) {
					throw new ServletException(e);
				}
			}
	}	
	
}
