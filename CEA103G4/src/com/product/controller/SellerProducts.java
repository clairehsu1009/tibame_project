package com.product.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.product.model.ProductService;
import com.product.model.ProductVO;

@WebServlet("/SellerProducts")
public class SellerProducts extends HttpServlet {

		private static final long serialVersionUID = 1L;

		protected void doGet(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {
			
			
			String sellerURL = "/front-end/productsell/sellerHome.jsp";
			String user_id = req.getParameter("user_id").trim();
			ProductService productSvc = new ProductService();
			List <ProductVO> SellerProducts = productSvc.getSellerProducts(user_id);
			req.setAttribute("SellerProducts", SellerProducts);
			req.getRequestDispatcher(sellerURL).forward(req, res);

		} 


		protected void doPost(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {
			doGet(req, res);
		}

	}

