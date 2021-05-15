package com.emp.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class EmpDAO implements EmpDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/admin");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private static final String INSERT_STMT = "INSERT INTO EMP (EMPNO,ENAME,JOB,ID,GENDER,DOB,CITY,DIST,ADDR,EMAIL,SAL,STATE,HIREDATE,EMP_PWD) VALUES (null, ? , ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT EMPNO,ENAME,JOB,ID,GENDER,DOB,CITY,DIST,ADDR,EMAIL,SAL,STATE,HIREDATE,EMP_PWD FROM EMP ORDER BY EMPNO";
	private static final String GET_ONE_STMT = "SELECT EMPNO,ENAME,JOB,ID,GENDER,DOB,CITY,DIST,ADDR,EMAIL,SAL,STATE,HIREDATE,EMP_PWD FROM EMP WHERE EMPNO = ?";
	private static final String DELETE = "DELETE FROM EMP WHERE EMPNO = ?";
	private static final String UPDATE = "UPDATE EMP SET ENAME=?, JOB=?, ID=?, GENDER=?, DOB=?, CITY=?, DIST=?, ADDR=?,EMAIL=?, SAL=?, STATE=?, HIREDATE=?, EMP_PWD=? WHERE EMPNO = ?";
	private static final String SIGN_IN = "SELECT EMPNO,EMP_PWD,ENAME,STATE FROM EMP WHERE BINARY EMPNO=? AND BINARY EMP_PWD=?";
	private static final String UPDATE_EMP_PWD = "UPDATE EMP SET EMP_PWD=? WHERE EMPNO = ?";
	private static final String GET_EMP_BY_EMAIL = "SELECT EMPNO,ENAME,EMAIL FROM EMP WHERE EMAIL=?";
	
	
	@Override
	public void insert(EmpVO empVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT, PreparedStatement.RETURN_GENERATED_KEYS);

			pstmt.setString(1, empVO.getEname());
			pstmt.setString(2, empVO.getJob());
			pstmt.setString(3, empVO.getId());
			pstmt.setInt(4, empVO.getGender());
			pstmt.setDate(5, empVO.getDob());
			pstmt.setString(6, empVO.getCity());
			pstmt.setString(7, empVO.getDist());
			pstmt.setString(8, empVO.getAddr());
			pstmt.setString(9, empVO.getEmail());
			pstmt.setDouble(10, empVO.getSal());
			pstmt.setInt(11, empVO.getState());
			pstmt.setDate(12, empVO.getHiredate());
			pstmt.setString(13, empVO.getEmp_pwd());

			pstmt.executeUpdate();

			ResultSet rs = pstmt.getGeneratedKeys();
			rs.next();
			Integer empno = rs.getInt(1);
			empVO.setEmpno(empno);
//System.out.println("EmpDAO新增成功"+empno);

		} catch (SQLException se) {
			throw new RuntimeException("database發生錯誤." + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public void update(EmpVO empVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, empVO.getEname());
			pstmt.setString(2, empVO.getJob());
			pstmt.setString(3, empVO.getId());
			pstmt.setInt(4, empVO.getGender());
			pstmt.setDate(5, empVO.getDob());
			pstmt.setString(6, empVO.getCity());
			pstmt.setString(7, empVO.getDist());
			pstmt.setString(8, empVO.getAddr());
			pstmt.setString(9, empVO.getEmail());
			pstmt.setDouble(10, empVO.getSal());
			pstmt.setInt(11, empVO.getState());
			pstmt.setDate(12, empVO.getHiredate());
			pstmt.setString(13, empVO.getEmp_pwd());
			pstmt.setInt(14, empVO.getEmpno());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("database發生錯誤." + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void delete(Integer empno) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, empno);

			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("database發生錯誤." + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public EmpVO findByPrimaryKey(Integer empno) {
		EmpVO empVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, empno);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				empVO = new EmpVO();
				empVO.setEmpno(rs.getInt("empno"));
				empVO.setEname(rs.getString("ename"));
				empVO.setJob(rs.getString("job"));
				empVO.setId(rs.getString("id"));
				empVO.setGender(rs.getInt("gender"));
				empVO.setDob(rs.getDate("dob"));
				empVO.setCity(rs.getString("city"));
				empVO.setDist(rs.getString("dist"));
				empVO.setAddr(rs.getString("addr"));
				empVO.setEmail(rs.getString("email"));
				empVO.setSal(rs.getDouble("sal"));
				empVO.setState(rs.getInt("state"));
				empVO.setHiredate(rs.getDate("hiredate"));
				empVO.setEmp_pwd(rs.getString("emp_pwd"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("database發生錯誤." + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return empVO;
	}

	@Override
	public List<EmpVO> getAll() {
		List<EmpVO> list = new ArrayList<EmpVO>();
		EmpVO empVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				empVO = new EmpVO();
				empVO.setEmpno(rs.getInt("empno"));
				empVO.setEname(rs.getString("ename"));
				empVO.setJob(rs.getString("job"));
				empVO.setId(rs.getString("id"));
				empVO.setGender(rs.getInt("gender"));
				empVO.setDob(rs.getDate("dob"));
				empVO.setCity(rs.getString("city"));
				empVO.setDist(rs.getString("dist"));
				empVO.setAddr(rs.getString("addr"));
				empVO.setEmail(rs.getString("email"));
				empVO.setSal(rs.getDouble("sal"));
				empVO.setState(rs.getInt("state"));
				empVO.setHiredate(rs.getDate("hiredate"));
				empVO.setEmp_pwd(rs.getString("emp_pwd"));
				list.add(empVO); // Store the row in the list
			}
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("database發生錯誤." + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	@Override
	public String genAuthCode() {
		String empPwd = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";// 儲存數字0-9 和 大小寫字母
		StringBuffer sb = new StringBuffer(); // 宣告一個StringBuffer物件sb 儲存 驗證碼
		for (int i = 0; i < 8; i++) {
			Random random = new Random();// 建立一個新的隨機數生成器
			int index = random.nextInt(empPwd.length());// 返回[0,string.length)範圍的int值 作用：儲存下標
			char ch = empPwd.charAt(index);// charAt() : 返回指定索引處的 char 值 ==》賦值給char字元物件ch
			sb.append(ch);// append(char c) :將 char 引數的字串表示形式追加到此序列 ==》即將每次獲取的ch值作拼接
		}
		return sb.toString();
	}

	@Override
	// 設定傳送郵件:至收信人的Email信箱,Email主旨,Email內容
	public void sendMail(EmpVO empVO) {

		String emailto = empVO.getEmail();
		String link = empVO.getLink();
		String subject = "Mode Femme密碼通知";
		Integer empno = empVO.getEmpno();
		String ch_name = empVO.getEname();
		String passRandom = empVO.getEmp_pwd();
		String messageText = "<h1>Hello! " + "<br>" + ch_name + "你的員編" + empno + " 首次登入密碼: " + passRandom + "<br>" + " (已經啟用)"
				+ "<br>" + " ( <a href=\"http://" + link + "/back-end/backendLogin.jsp \"> 登入首頁 </a>) <h1>";

		try {

			// 設定使用SSL連線至 Gmail smtp Server
			Properties props = new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", "465");

			// ●設定 gmail 的帳號 & 密碼 (將藉由你的Gmail來傳送Email)
			// ●須將myGmail的【安全性較低的應用程式存取權】打開
			final String myGmail = "gea103g4@gmail.com";
			final String myGmail_password = "gea103g4gea103g4";
			Session session = Session.getInstance(props, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(myGmail, myGmail_password);
				}
			});

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(myGmail));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailto));

//			MailService mailService = new MailService();
//			empVO.sendMail(emailto, subject, messageText);

			// 設定信中的主旨
			message.setSubject(subject);
			
			// 設定信中的內容
//			message.setText(messageText);
			message.setContent(messageText, "text/html ;charset=UTF-8");

			Transport.send(message);

			SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
			Date date = new Date();
			String strDate = sdFormat.format(date);

			System.out.println(strDate + " 員工mail傳送成功!");

		} catch (MessagingException e) {
			System.out.println("員工mail傳送失敗!");
			e.printStackTrace();
		}
	}


	@Override
	public EmpVO getEmail(String email) {
		EmpVO empVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_EMP_BY_EMAIL);
			
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				empVO = new EmpVO();
				empVO.setEmpno(rs.getInt("empno"));
				empVO.setEmail(rs.getString("ename"));
				empVO.setEmail(rs.getString("email"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return empVO;

	}

	@Override
	public EmpVO login(Integer empno, String empPwd) {
		EmpVO empVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(SIGN_IN);

			pstmt.setInt(1, empno);
			pstmt.setString(2, empPwd);

			rs = pstmt.executeQuery();
			while (rs.next()) {

				empVO = new EmpVO();
				empVO.setEmpno(rs.getInt("empno"));
				empVO.setEname(rs.getString("ename"));
				empVO.setEmp_pwd(rs.getString("emp_pwd"));
				empVO.setState(rs.getInt("state"));
			}

		} catch (SQLException se) {
			throw new RuntimeException("database發生錯誤." + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return empVO;
	}

	@Override
	public void updatePswd(EmpVO empVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_EMP_PWD);

			pstmt.setString(1, empVO.getEmp_pwd());
			pstmt.setInt(2, empVO.getEmpno());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("database發生錯誤." + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

}
