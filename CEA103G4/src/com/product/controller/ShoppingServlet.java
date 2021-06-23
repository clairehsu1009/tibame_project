package com.product.controller;

import java.util.*;
import java.util.stream.Collectors;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONException;
import org.json.JSONObject;

import com.product.model.*;

@WebServlet("/ShoppingServlet")
public class ShoppingServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		
		@SuppressWarnings("unchecked")
		List<ProductVO> buylist = (Vector<ProductVO>) session.getAttribute("shoppingcart");

		String action = req.getParameter("action");
		ProductVO product= new ProductVO();
		if (!action.equals("CHECKOUT")) {

			// 刪除購物車中的單一商品
			if (action.equals("DELETE")) {
				Integer productNo = new Integer(req.getParameter("delProductNo"));
				for (int i = 0; i < buylist.size(); i++) { 
					if (buylist.get(i).getProduct_no().equals(productNo)) { 
						buylist.remove(i);
						break;
					}
				}
				session.setAttribute("shoppingcart", buylist);
				
				String url = "/front-end/productsell/shoppingCart.jsp";
				RequestDispatcher rd = req.getRequestDispatcher(url);
				rd.forward(req, res);
				return;
			}
			
			// 清空購物車中的商品
			if(action.equals("DELETEALL")) {
				
				session.removeAttribute("shoppingcart");
				
				String url = "/front-end/productsell/shoppingCart.jsp";
				RequestDispatcher rd = req.getRequestDispatcher(url);
				rd.forward(req, res);
				return;
			}
			
			// 新增商品至購物車中
			else if (action.equals("ADD") ||  action.equals("ADDFromFav")) {
				
				if (action.equals("ADDFromFav")) {
					Integer product_no = new Integer(req.getParameter("product_no"));
					ProductService productSvc = new ProductService();
					product = productSvc.getFavorite(product_no);
				}else {
					product = getProduct(req);
				}
				
				if (buylist == null) {
					buylist = new Vector<ProductVO>();
					buylist.add(product);
				} else {
					if (buylist.contains(product)) {
						ProductVO innerProductVO = buylist.get(buylist.indexOf(product));
						innerProductVO.setProduct_quantity(innerProductVO.getProduct_quantity() + product.getProduct_quantity());
						Integer newProductVO = innerProductVO.getProduct_quantity();
						// 避免重複點擊加入購物車之商品數量大於庫存
						if(newProductVO > innerProductVO.getProduct_remaining()) {
							innerProductVO.setProduct_quantity(innerProductVO.getProduct_quantity() - product.getProduct_quantity());
						}
					} else {
						buylist.add(product);
					}
				}
			}
			
			else if (action.equals("updateCount")) {
				
					product = getProduct(req);

					if (buylist.contains(product)) {
						ProductVO innerProductVO = buylist.get(buylist.indexOf(product));
						innerProductVO.setProduct_quantity(product.getProduct_quantity());
						Integer newProductVO = innerProductVO.getProduct_quantity();
						// 避免重複點擊加入購物車之商品數量大於庫存
						if(newProductVO > innerProductVO.getProduct_remaining()) {
							innerProductVO.setProduct_quantity(innerProductVO.getProduct_quantity() - product.getProduct_quantity());
						}
					} else {
						buylist.add(product);
					}
				}
			

			session.setAttribute("shoppingcart", buylist);
			req.setAttribute("productVO", product);
			
			res.setContentType("text/html; charset=utf-8");
			PrintWriter out = res.getWriter();
			JSONObject jsonObj = new JSONObject();
			try {
				jsonObj.put("results", buylist);
			} catch (JSONException e) {
				e.printStackTrace();
			}
			out.println(jsonObj.toString());
			out.flush();
			out.close();
			
		}		

	}

	private ProductVO getProduct(HttpServletRequest req) {
		
		String product_no = req.getParameter("product_no");
		String product_name = req.getParameter("product_name");
		String product_price = req.getParameter("product_price");
		String proqty = req.getParameter("proqty");
		String product_remaining = req.getParameter("product_remaining");
		String user_id = req.getParameter("user_id");
		
		ProductVO productVO = new ProductVO();

		productVO.setProduct_no(new Integer(product_no));
		productVO.setProduct_name(product_name);
		productVO.setProduct_price(new Integer(product_price));
		productVO.setProduct_quantity(new Integer(proqty));
		productVO.setProduct_remaining(new Integer(product_remaining));
		productVO.setUser_id(user_id);
		return productVO;
	}
	
}