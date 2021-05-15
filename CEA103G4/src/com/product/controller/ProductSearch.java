package com.product.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.product.model.ProductDAO;
import com.product.model.ProductService;
import com.product.model.ProductVO;
import com.product_type.model.Product_TypeService;




@WebServlet("/ProductSearch")
public class ProductSearch extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final String SUCESS_URL = "/front-end/productsell/shop.jsp";
	private static final String ERROR_URL = "/front-end/index.jsp";

	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("getJson".equals(action)) {
			ProductService productSvc = new ProductService();
			List<ProductVO> list = productSvc.getAllShop();
			JSONObject jsonObj = new JSONObject();
			
			try {
				jsonObj.put("results", list);

			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			res.setContentType("text/html; charset=UTF-8");
		
			PrintWriter out = res.getWriter();
			
			out.println(jsonObj.toString());
			out.close();
		}
		
		doPost(req, res);		

	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		

		
//		商品區ajax查詢
		if (("search_ajax".equals(action)))  {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
				
				// 以下的 if 區塊只對第一次執行時有效
				if (req.getParameter("whichPage") == null){
					Map<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
					session.setAttribute("map",map1);
					map = map1;
				} 
				
				/*************************** 2.開始查詢資料 ****************************************/
				ProductService productSvc = new ProductService();
				List<ProductVO> list  = productSvc.getAllShop(map);
//				session.setAttribute("products", list);
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				
				res.setContentType("text/html; charset=utf-8");
				PrintWriter out = res.getWriter();
				
				JSONObject jsonObj = new JSONObject();
				
				try {
					jsonObj.put("results", list);
				} catch (JSONException e) {
					e.printStackTrace();
				}
				
				out.println(jsonObj.toString());
				out.flush();
				out.close();
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(ERROR_URL);
				failureView.forward(req, res);
			}	
		} 
		//價格區間查詢
		if (("moneyRange".equals(action)))  {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
				
				// 以下的 if 區塊只對第一次執行時有效
				if (req.getParameter("whichPage") == null){
					Map<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
					session.setAttribute("map",map1);
					map = map1;
				}
				String minPrice = req.getParameter("minPrice");
				String maxPrice = req.getParameter("maxPrice");

				/*************************** 2.開始查詢資料 ****************************************/
				ProductService productSvc = new ProductService();
				List<ProductVO> list  = productSvc.getMoneyRangeShop(minPrice, maxPrice);
//				session.setAttribute("products", list);
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				
				res.setContentType("text/html; charset=utf-8");
				PrintWriter out = res.getWriter();
				
				JSONObject jsonObj = new JSONObject();
				
				try {
					jsonObj.put("results", list);
				} catch (JSONException e) {
					e.printStackTrace();
				}
				
				out.println(jsonObj.toString());
				out.flush();
				out.close();
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(ERROR_URL);
				failureView.forward(req, res);
			}	
		} 
		
		//進階查詢
		if (("fw-all-choose".equals(action)))  {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
				
				// 以下的 if 區塊只對第一次執行時有效
				if (req.getParameter("whichPage") == null){
					Map<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
					session.setAttribute("map",map1);
					map = map1;
				} 
				String[] pdtypeNo = req.getParameterValues("pdtypeNo[]");
				String priceType = req.getParameter("productPrice");
				
				/*************************** 2.開始查詢資料 ****************************************/
				ProductService productSvc = new ProductService();
				List<ProductVO> list  = productSvc.getAdvSearchShop(pdtypeNo, priceType);
//				session.setAttribute("products", list);
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				res.setContentType("text/html; charset=utf-8");
				PrintWriter out = res.getWriter();
				JSONObject jsonObj = new JSONObject();
				try {
					jsonObj.put("results", list);
				} catch (JSONException e) {
					e.printStackTrace();
				}
				
				out.println(jsonObj.toString());
				out.flush();
				out.close();
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) { 
				return;
			}	
		}
		
		

}			
}

