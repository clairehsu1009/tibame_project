package com.product_report.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.product.model.ProductService;
import com.product.model.ProductVO;
import com.product_report.model.Product_ReportService;
import com.product_report.model.Product_ReportVO;

public class Product_ReportServlet extends HttpServlet{

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
				String str = req.getParameter("pro_report_no");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入商品檢舉編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/product_report/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer pro_report_no = null;
				try {
					pro_report_no = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("商品檢舉編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/product_report/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				Product_ReportService product_reportSvc = new Product_ReportService();
				Product_ReportVO product_reportVO = product_reportSvc.getOneProduct_Report(pro_report_no);
				if (product_reportVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/product_report/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("product_reportVO", product_reportVO); // 資料庫取出的product_reportVO物件,存入req
				String url = "/back-end/product_report/listOneProduct_Report.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneProduct_Report.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/product_report/select_page.jsp");
				failureView.forward(req, res);
			}
		}
				
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllProduct_Report.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer pro_report_no = new Integer(req.getParameter("pro_report_no"));
				
				/***************************2.開始查詢資料****************************************/
				Product_ReportService product_reportSvc = new Product_ReportService();
				Product_ReportVO product_reportVO = product_reportSvc.getOneProduct_Report(pro_report_no);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("product_reportVO", product_reportVO);         // 資料庫取出的product_reportVO物件,存入req
				String url = "/back-end/product_report/update_product_report_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交update_product_report_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/product_report/listAllProduct_Report.jsp");
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
				Product_ReportVO product_reportVO = new Product_ReportVO();
				
				Integer pro_report_no = new Integer(req.getParameter("pro_report_no").trim());
				
//				String pro_report_content = req.getParameter("pro_report_content");
//
//				//*需更改 之後要做點選按鈕 動態抓取商品的商品編號(會員不需自行填寫)
				Integer product_no = new Integer(req.getParameter("product_no").trim());;
//				//*需更改 檢舉者帳號 動態抓取自動帶入
//				String user_id = req.getParameter("user_id");
//				//檢舉時間不用驗證
//				Integer empno = new Integer(req.getParameter("empno").trim());
				
				Integer proreport_state = new Integer(req.getParameter("proreport_state").trim());

			
				product_reportVO.setPro_report_no(pro_report_no);
//				product_reportVO.setPro_report_content(pro_report_content);
				product_reportVO.setProduct_no(product_no);
//				product_reportVO.setUser_id(user_id);
//				product_reportVO.setEmpno(empno);
				product_reportVO.setProreport_state(proreport_state);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("product_reportVO", product_reportVO); // 含有輸入格式錯誤的product_reportVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/product_report/getAllUserReport.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}

				/***************************2.開始修改資料*****************************************/
				Product_ReportService product_reportSvc = new Product_ReportService();
				product_reportVO = product_reportSvc.updateProduct_Report(pro_report_no,product_no,proreport_state);
				
				//當檢舉狀態審核通過,商品狀態自動轉為檢舉下架
				if(proreport_state == 1) {
					
					ProductService productSvc = new ProductService();
					ProductVO productVO = productSvc.getOneProduct(product_no);
				    Integer product_state = 5;

				    productVO.setProduct_no(product_no);
				    productVO.setProduct_state(product_state);
				    productVO = productSvc.updateState(product_no,product_state);
				} 
				

				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("product_reportVO", product_reportVO); // 資料庫update成功後,正確的的product_reportVO物件,存入req
				String url = "/back-end/product_report/getAllUserReport.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneProduct_Report.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/product_report/getAllUserReport.jsp");
				failureView.forward(req, res);
			}
		}
		//product.jsp提交商品檢舉進來,員工預設14002
        if ("insert".equals(action)) { // 來自addProduct_Report.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/


				String pro_report_content = req.getParameter("pro_report_content");
				if (pro_report_content == null || pro_report_content.trim().length() == 0) {
					errorMsgs.add("商品檢舉內容: 請勿空白");
				} 
				//*需更改 之後要做點選按鈕 動態抓取商品的商品編號(會員不需自行填寫)
				Integer product_no = new Integer(req.getParameter("product_no").trim());;
				//*需更改 檢舉者帳號 動態抓取自動帶入
				String user_id = req.getParameter("user_id");
				//empno預設
//				Integer empno = new Integer(req.getParameter("empno").trim());
				
				Product_ReportVO product_reportVO = new Product_ReportVO();
				product_reportVO.setPro_report_content(pro_report_content);
				product_reportVO.setProduct_no(product_no);
				product_reportVO.setUser_id(user_id);
//				product_reportVO.setEmpno(empno);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("product_reportVO", product_reportVO); // 含有輸入格式錯誤的product_reportVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/productsell/shop.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
//				System.out.println("pro_report_content="+pro_report_content);
//				System.out.println("product_no="+product_no);
//				System.out.println("user_id="+user_id);
				/***************************2.開始新增資料*****************************************/
				Product_ReportService product_reportSvc = new Product_ReportService();
				product_reportVO = product_reportSvc.addProduct_Report(pro_report_content, product_no,user_id);
				
				/***************************3.新增完成,準備轉交(Send the Success view)*************/
//				String url = "/back-end/product_report/listAllProduct_Report.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後,轉交listAllProduct_Report.jsp
//				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/productsell/shop.jsp");
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
				Integer pro_report_no = new Integer(req.getParameter("pro_report_no"));
				
				/***************************2.開始刪除資料***************************************/
				Product_ReportService product_reportSvc = new Product_ReportService();
				product_reportSvc.deleteProduct_Report(pro_report_no);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/back-end/product_report/listAllProduct_Report.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/product_report/listAllProduct_Report.jsp");
				failureView.forward(req, res);
			}
		}
	}	
}
