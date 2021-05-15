package com.ad.controller;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ad.model.AdService;
import com.ad.model.AdVO;

@WebServlet("/AdShowPhoto")
public class AdShowPhoto extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("image/*");
		Integer ad_no = new Integer(request.getParameter("ad_no"));
	
		if (ad_no != null) {
		AdService adSvc = new AdService();
		Optional<AdVO> adVO = adSvc.getAdPic(ad_no);
		
		if (adVO.isPresent()) {
			OutputStream out = response.getOutputStream();
			out.write(adVO.get().getAd_photo());
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
