package login;

import java.io.*;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.*;
import javax.servlet.http.*;

import org.json.JSONException;
import org.json.JSONObject;

import com.product.model.ProductService;
import com.product.model.ProductVO;
import com.user.model.*;


import javax.servlet.annotation.WebServlet;

@WebServlet("/FrondEnd_LoginHandler")
public class FrondEnd_LoginHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html; charset=utf-8");
		String action = req.getParameter("action");
		PrintWriter out = res.getWriter();
		
		Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
		req.setAttribute("errorMsgs", errorMsgs);
		
		if ("signIn".equals(action)) {
		// 【取得使用者 帳號(user_id) 密碼(user_pwd)】
		try {
			String str = req.getParameter("user_id");
			String str2 = req.getParameter("user_pwd");
			if (str == null || (str.trim().length() == 0)) {
				errorMsgs.put("user_id","請輸入會員帳號");
			}if(str2 == null || (str2.trim().length() == 0)) {
				errorMsgs.put("user_pwd","請輸入會員密碼");
			}
			UserVO userVO = new UserVO();
			userVO.setUser_id(str);
			userVO.setUser_pwd(str2);
			
			// 錯誤發生時將內容發送回表單
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("userVO", userVO); // 含有輸入格式錯誤的userVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/userLogin.jsp");
				failureView.forward(req, res);
				return;
			} // 程式中斷，回傳當前頁面
			
			//會員帳號密碼已是String不需此步驟
//			Integer empno = null;
//			try {
//				empno = new Integer(str);
//			} catch (Exception e) {
//				errorMsgs.put("empno","員工帳號格式不正確");
//			}
//			empno = new Integer(req.getParameter("account").trim());
			
			String user_id = str;
			
			String user_pwd = str2;
			
			UserService userSvc = new UserService();
			userVO = userSvc.selectUser(user_id, user_pwd);
			if(userVO == null) {
				errorMsgs.put("user_id","帳號或密碼不正確，請重新輸入！");
				String url = "/front-end/userLogin.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
			}else if(userVO.getUser_state() == 0) {
				errorMsgs.put("user_id","很抱歉，此帳號永久停權已無法使用！");
				String url = "/front-end/userLogin.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
			}else if(userVO != null) {
				HttpSession session = req.getSession();
				session.setAttribute("account", userVO); // *工作1: 才在session內做已經登入過的標識
				try {
					String location = (String) session.getAttribute("location");
																  // account == null才有
					if (location != null) {
						session.removeAttribute("location"); // *工作2: 看看有無來源網頁 (-->如有來源網頁:則重導至來源網頁)
						res.sendRedirect(location);
						return;
					}
				} catch (Exception ignored) {
				}
				res.sendRedirect(req.getContextPath() + "/front-end/index.jsp"); // *工作3:
				// (-->如無來源網頁:則重導至首頁)
			}if(!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/userLogin.jsp");
				failureView.forward(req, res);
				return;
			}
			}catch (Exception e) {
				
			}
		}
		
		
		if (("signIn_ajax".equals(action)))  {

			try {
				String user_id = req.getParameter("user_id");
				String user_pwd = req.getParameter("user_pwd");

				UserVO userVO = new UserVO();

				UserService userSvc = new UserService();
				userVO = userSvc.selectUser(user_id, user_pwd);
				if(userVO == null) {
					errorMsgs.put("user_id","帳號或密碼不正確，請重新輸入！");

				}else if(userVO != null) {
					HttpSession session = req.getSession();
					session.setAttribute("account", userVO); 
					
					res.setContentType("text/html; charset=utf-8");
					PrintWriter out1 = res.getWriter();
					
					JSONObject jsonObj = new JSONObject();
					
					try {
						jsonObj.put("results", userVO);
					} catch (JSONException e) {
						e.printStackTrace();
					}
					
					out1.println(jsonObj.toString());
					out1.flush();
					out1.close();
				}
				}catch (Exception e) {
					return;
				}
			}
}
}