package com.qa.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/test1")
public class test1 extends HttpServlet{

		public void doGet(HttpServletRequest req, HttpServletResponse res) {
			

			QaDAO dao = new QaDAO();

			// 新增
			QaVO qaVO = new QaVO();
			qaVO.setEmpno(14001);
			qaVO.setQa_date(java.sql.Date.valueOf("2021-04-16"));
			qaVO.setQa_content("Q:XXXX,A:XXXX");
			dao.insert(qaVO);

//			// 修改
//			QaVO qaVO = new QaVO();
//			
//			qaVO.setEmpno(14001);
//			qaVO.setQa_date(java.sql.Date.valueOf("2021-04-16"));
//			qaVO.setQa_content("Q:OOOOO,A:OOOOO");
//			qaVO.setQa_no(17008);
//			
//			dao.update(qaVO);

			// 刪除
//			dao.delete(17010);

//			// 查詢
//			QaVO qaVO = dao.findByPrimaryKey(17001);
//			System.out.print(qaVO.getQa_no() + ",");
//			System.out.print(qaVO.getEmpno() + ",");
//			System.out.print(qaVO.getQa_date() + ",");
//			System.out.print(qaVO.getQa_content());

			// 查詢
			List<QaVO> list = dao.getAll();
//			for (QaVO aQa : list) {
//				System.out.print(aQa.getQa_no() + ",");
//				System.out.print(aQa.getEmpno() + ",");
//				System.out.print(aQa.getQa_date() + ",");
//				System.out.print(aQa.getQa_content() + ",");
//				System.out.println();
//			}
			
			res.setContentType("text/html; charset=UTF-8");
			try {
				PrintWriter out = res.getWriter();
				out.println("<HTML>");
				out.println("<HEAD><TITLE>Hello World</TITLE></HEAD>");
				out.println("<BODY>");
				out.println("<BIG>Hello World , 世界你好 !</BIG>" + dao.findByPrimaryKey(17001).getEmpno() + list.get(1).getEmpno());
				out.println("</BODY></HTML>");
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
}
