package com.product.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.product.model.ProductService;
import com.product.model.ProductVO;

@WebServlet("/Favorite")
public class Favorite extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		HttpSession session = req.getSession();

		List<ProductVO> favorites = (Vector<ProductVO>) session.getAttribute("favorite");

		ProductVO product = new ProductVO();
		if ("addFavorite".equals(action)) {
			Integer product_no = new Integer(req.getParameter("product_no"));
			ProductService productSvc = new ProductService();
			product = productSvc.getFavorite(product_no);

			if (favorites == null) {
				favorites = new Vector<ProductVO>();
				favorites.add(product);
			} else if (!(favorites.contains(product))) {
				favorites.add(product);
			}
		}
		if (action.equals("remove")) {
			String index = req.getParameter("index");
			int removeindex = Integer.parseInt(index);
			favorites.remove(removeindex);
			session.setAttribute("favorite", favorites);
			return;
		}
		
		session.setAttribute("favorite", favorites);
		req.setAttribute("productVO", product);
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		JSONObject jsonObj = new JSONObject();
		try {
			jsonObj.put("results", favorites);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}
}
