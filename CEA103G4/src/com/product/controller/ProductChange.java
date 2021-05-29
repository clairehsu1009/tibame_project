package com.product.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.product.model.ProductService;
import com.product.model.ProductVO;
@WebServlet("/ProductChange")
public class ProductChange  extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("getOne_For_Update".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer product_no = new Integer(req.getParameter("product_no"));

				/***************************2.開始查詢資料****************************************/
				ProductService productSvc = new ProductService();
				ProductVO productVO = productSvc.getOneProduct(product_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("productVO", productVO);         // 資料庫取出的productVO物件,存入req
				
				String url = null;
				if("getOne_For_Update".equals(action))
					url = "/front-end/productManagement/productUpdate.jsp";
				else if ("getOne_For_Update_B".equals(action))
					url = "/front-end/liveManagement/productUpdate.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_product_input.jsp
				successView.forward(req, res);


				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/productManagement/productList.jsp");
				failureView.forward(req, res);

			}
		}
		
		
		if ("update".equals(action)) { // 來自update_product_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				ProductVO productVO = new ProductVO();
				
				Integer product_no = new Integer(req.getParameter("product_no").trim());
				
				String product_name = req.getParameter("product_name");
				String product_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,20}$";
				if (product_name == null || product_name.trim().length() == 0) {
					errorMsgs.add("商品名稱: 請勿空白");
				} else if(!product_name.trim().matches(product_nameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("商品名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到20之間");
	            }
				
				String product_info = req.getParameter("product_info");
				if (product_info == null || product_info.trim().length() == 0) {
					errorMsgs.add("商品說明請勿空白");
				}
				
				Integer product_price = null;
				try {
					product_price = new Integer(req.getParameter("product_price").trim());
				} catch (NumberFormatException e) {
					errorMsgs.add("商品價格請填數字");
				}
				
				
				Integer product_remaining = null;
				try {
					product_remaining = new Integer(req.getParameter("product_remaining").trim());
				} catch (NumberFormatException e) {
					product_remaining = 1;
					errorMsgs.add("商品數量請填數字");
				}
				
				Integer product_state = new Integer(req.getParameter("product_state").trim());

				
				byte[] product_photo = null;
					Part part = req.getPart("product_photo");
					if (part == null || part.getSize() == 0) {
						req.setAttribute("productVO", productVO);
						ProductService productSvc2 = new ProductService();
						ProductVO productVO2 = productSvc2.getOneProduct(product_no);
						product_photo = productVO2.getProduct_photo();
				} else {
					req.setAttribute("productVO", productVO);
					InputStream in = part.getInputStream();
					product_photo = new byte[in.available()];
					in.read(product_photo);
					in.close();
				}
				
				String user_id = req.getParameter("user_id").trim();

				
				Integer pdtype_no = null;
				try {
					pdtype_no = new Integer(req.getParameter("pdtype_no").trim());
				} catch (NumberFormatException e) {
					errorMsgs.add("商品類別請勿空白");
				}

				
				productVO.setProduct_no(product_no);
				productVO.setProduct_name(product_name);
				productVO.setProduct_info(product_info);
				productVO.setProduct_price(product_price);
				productVO.setProduct_remaining(product_remaining);
				productVO.setProduct_state(product_state);
				productVO.setProduct_photo(product_photo);
				productVO.setUser_id(user_id);
				productVO.setPdtype_no(pdtype_no);


				if (!errorMsgs.isEmpty()) {
					req.setAttribute("productVO", productVO); // 含有輸入格式錯誤的productVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/productManagement/productUpdate.jsp");
					failureView.forward(req, res);

				}
				
				/***************************2.開始修改資料*****************************************/
				ProductService productSvc = new ProductService();
				productVO = productSvc.updateProduct(product_no, product_name, product_info, product_price, product_remaining, product_state,
						product_photo, user_id, pdtype_no);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("productVO", productVO); // 資料庫update成功後,正確的的productVO物件,存入req
				String url = "/front-end/productManagement/productList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/productManagement/productUpdate.jsp");
				failureView.forward(req, res);
			}
		}
		
	}

}
