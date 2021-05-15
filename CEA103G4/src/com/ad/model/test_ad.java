package com.ad.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/test_ad")
public class test_ad extends HttpServlet{

		public void doGet(HttpServletRequest req, HttpServletResponse res) {
			

			AdDAO dao = new AdDAO();

			// 新增
//			AdVO adVO = new AdVO();
//			
//			adVO.setEmpno(14001);
//			adVO.setAd_content("全館商品促銷");
//			adVO.setAd_photo(null);
//			adVO.setAd_state(1);
//			adVO.setAd_start_date(java.sql.Date.valueOf("2021-04-16"));
//			adVO.setAd_end_date(java.sql.Date.valueOf("2021-04-16"));
//			adVO.setAd_url("www.xxx.com");
//			dao.insert(adVO);

//			// 修改
//			AdVO adVO = new AdVO();
//			
//			adVO.setEmpno(14001);
//			adVO.setAd_content("全館商品促銷特賣");
//			adVO.setAd_photo(null);
//			adVO.setAd_state(1);
//			adVO.setAd_start_date(java.sql.Date.valueOf("2021-04-16"));
//			adVO.setAd_end_date(java.sql.Date.valueOf("2021-04-16"));
//			adVO.setAd_url("www.xxx.com");
//			adVO.setAd_no(18006);
//			
//			dao.update(adVO);

			// 刪除
//			dao.delete(18006);

//			// 查詢
//			AdVO adVO = dao.findByPrimaryKey(18001);
//			System.out.print(adVO.getAd_no() + ",");
//			System.out.print(adVO.getEmpno() + ",");
//			System.out.print(adVO.getAd_content() + ",");
//			System.out.print(adVO.getAd_photo()+ ",");
//			System.out.print(adVO.getAd_state()+ ",");
//			System.out.print(adVO.getAd_start_date()+ ",");
//			System.out.print(adVO.getAd_end_date()+ ",");
//			System.out.print(adVO.getAd_url());

			// 查詢
			List<AdVO> list = dao.getAll();
			
//			for (AdVO aAd : list) {
//				System.out.print(aAd.getAd_no() + ",");
//				System.out.print(aAd.getEmpno() + ",");
//				System.out.print(aAd.getAd_content() + ",");
//				System.out.print(aAd.getAd_photo() + ",");
//				System.out.print(aAd.getAd_state() + ",");
//				System.out.print(aAd.getAd_start_date() + ",");
//				System.out.print(aAd.getAd_end_date() + ",");
//				System.out.print(aAd.getAd_url() + ",");
//				System.out.println();
//			}
			
			res.setContentType("text/html; charset=UTF-8");
			try {
				PrintWriter out = res.getWriter();
				out.println("<HTML>");
				out.println("<HEAD><TITLE>Hello World</TITLE></HEAD>");
				out.println("<BODY>");
				out.println("<BIG>Hello World , 世界你好 !</BIG>" + dao.findByPrimaryKey(18001).getEmpno() + list.get(1).getEmpno());
				out.println("</BODY></HTML>");
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
}
