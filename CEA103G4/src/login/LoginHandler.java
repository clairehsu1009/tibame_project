package login;

import java.io.*;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.*;
import javax.servlet.http.*;

import com.auth.model.AuthService;
import com.auth.model.AuthVO;
import com.emp.model.EmpService;
import com.emp.model.EmpVO;
import javax.servlet.annotation.WebServlet;

@WebServlet("/loginhandler")
public class LoginHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html; charset=utf-8");
		String action = req.getParameter("action");

		if ("signIn".equals(action))
			// 【取得使用者 帳號(empAccount) 密碼(password)】
			try {
				Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				String str = req.getParameter("empAccount");
				String str2 = req.getParameter("password");
				if (str == null || (str.trim().length() == 0)) {
					errorMsgs.put("empno", "請輸入員工帳號");
				}
				if (str2 == null || (str2.trim().length() == 0)) {
					errorMsgs.put("empPwd", "請輸入密碼");
				}
				// 錯誤發生時將內容發送回表單
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/backendLogin.jsp");
					failureView.forward(req, res);
					return;
				} // 程式中斷，回傳當傳頁面

				Integer empno = null;

				try {
					empno = new Integer(str);
				} catch (Exception e) {
					errorMsgs.put("empno", "員工帳號格式不正確");
				}

				empno = new Integer(req.getParameter("empAccount").trim());

				String empPwd = req.getParameter("password");

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/backendLogin.jsp");
					failureView.forward(req, res);
					return;
				}

				EmpService empSvc = new EmpService();
				EmpVO empVO = empSvc.selectEmp(empno, empPwd);// 查詢資料庫是否有此員工

				if (empVO == null) {
					errorMsgs.put("empno", "帳號密碼不正確，請重新輸入");
					String url = "/back-end/backendLogin.jsp";
					RequestDispatcher failureView = req.getRequestDispatcher(url);
					failureView.forward(req, res);
				} else if(empVO.getState()==0) {
						String quit = "quit";
						req.setAttribute("quit", quit);
						errorMsgs.put("empno", "此員工已離職");
						RequestDispatcher failureView = req.getRequestDispatcher("back-end/backendLogin.jsp");
						failureView.forward(req, res);
				
				}else {
					AuthService authSvc = new AuthService();	// 取得員工帳號的權限
					List<AuthVO> authList = authSvc.getAuthNOs(empno);
//					for(AuthVO auth:list) {
//						System.out.println(auth.getFunno()+",");
//					}

					HttpSession session = req.getSession();
					session.setAttribute("empAccount", empVO); // *工作1: 才在session內做已經登入過的標識
					session.setAttribute("authList", authList);

					try {
						String location = (String) session.getAttribute("location");
						if (location != null) {
							session.removeAttribute("location"); // *工作2: 看看有無來源網頁 (-->如有來源網頁:則重導至來源網頁)
							res.sendRedirect(location);
							return;
						}
					} catch (Exception ignored) {

					}
					res.sendRedirect(req.getContextPath() + "/back-end/backendIndex.jsp"); // *工作3:
					// (-->如無來源網頁:則重導至login_success.jsp)

				}
					
			} catch (Exception e) {
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/backendLogin.jsp");
				failureView.forward(req, res);
			}


		if ("signOut".equals(action)) {
			HttpSession session = req.getSession();
			if (!session.isNew()) {
				// 使用者登出
				session.invalidate();

				String url = "/back-end/backendLogin.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 登出後轉至首頁
				successView.forward(req, res);
			}
		}

		if ("forgotPassword".equals(action)) {
				Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
				req.setAttribute("errorMsgs", errorMsgs);
			try {			
				String email = req.getParameter("email");
				String emailReg = "^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$";
				if (email == null || email.trim().length() == 0) {
					errorMsgs.put("email", "email請勿空白");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/backendLogin.jsp");
					failureView.forward(req, res);
					return;
				} 	
				if (!email.trim().matches(emailReg)) {
					errorMsgs.put("email", "email格式不正確");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/backendLogin.jsp");
					failureView.forward(req, res);
					return;
				}
				//尋找是否有符合的Email
				EmpVO empVO = new EmpVO();
				empVO.setEmail(email);
				EmpService empSvc = new EmpService();
				empVO = empSvc.selectEmail(email);
				
				if (empVO == null) {
					errorMsgs.put("email", "沒有Email資料，請重新輸入");	
				}if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/backendLogin.jsp");
					failureView.forward(req, res);
					return;
				} else {
					req.setAttribute("empVO", empVO); // 資料庫取出的empVO物件,存入req
					String url = "/back-end/update_pswd.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);
				}

			} catch (Exception e) {
				errorMsgs.put("email", "沒有Email資料，請重新輸入");
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/backendLogin.jsp");
				failureView.forward(req, res);
				return;
			}
		}

		if ("update_pswd".equals(action)) {
			
			Map<String, String> errorMsgs = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				Integer empno = new Integer(req.getParameter("empno"));
				String pswd = req.getParameter("pswd").trim();
				String pswd_again = req.getParameter("pswd_again").trim();
				String empPwd = null;

				if (pswd == null || pswd.trim().length() == 0 || pswd_again == null
						|| pswd_again.trim().length() == 0) {
					errorMsgs.put("pswd", "密碼:不得空白");
				} 
				
				if (!pswd.trim().equals(pswd_again)) {
					errorMsgs.put("pswd_again", "兩次輸入修改密碼不一樣");
				} 
				
					empPwd = pswd_again;

				
				EmpVO empVO = new EmpVO();
				empVO.setEmp_pwd(empPwd);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("empVO", empVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/back-end/update_pswd.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				// 開始修改
				EmpService empSvc = new EmpService();
				empVO = empSvc.updatePswd(empno, empPwd);

				/*************************** 3.新增完成，準備轉交(Send the Success view) ***********/
				req.setAttribute("empVO", empVO);
//				res.sendRedirect(req.getContextPath() + "/back-end/backendLogin.jsp");
				String url = "/back-end/backendLogin.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
				req.getSession().invalidate();

			} catch (Exception e) {
				errorMsgs.put("修改密碼失敗:", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back-end/update_pswd.jsp");
				failureView.forward(req, res);
			}
		}

	}
}
