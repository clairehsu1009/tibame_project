package com.product.controller;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.product.model.ProductService;
import com.product.model.ProductVO;

@WebServlet("/ProductShowPhoto")
public class ProductShowPhoto extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("image/*");
		Integer product_no = new Integer(request.getParameter("product_no"));
	
		if (product_no != null) {
		ProductService productSvc = new ProductService();
		Optional<ProductVO> productVO = productSvc.getProductPic(product_no);
		
		if (productVO.isPresent()) {
			OutputStream out = response.getOutputStream();
			out.write(productVO.get().getProduct_photo());
			out.flush();
			out.close();
		}
	} 
}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
