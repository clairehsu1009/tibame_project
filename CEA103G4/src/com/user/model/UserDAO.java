package com.user.model;

import java.util.*;
import java.util.Date;
import java.sql.*;
import java.text.SimpleDateFormat;

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

import com.emp.model.EmpVO;
import com.live_report.model.Live_reportVO;

public class UserDAO implements UserDAO_interface {

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/admin");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	private static final String INSERT_STMT =
//			"INSERT INTO `USER` (`USER_ID`,`USER_PWD`,`USER_NAME`,`ID_CARD`,`USER_GENDER`,`USER_DOB`,`USER_MAIL`,`USER_PHONE`,`USER_MOBILE`,`CITY`,`TOWN`,`ZIPCODE`,`USER_ADDR`,`REGDATE`,`USER_POINT`,`VIOLATION`,`USER_STATE`,`USER_COMMENT`,`COMMENT_TOTAL`,`CASH`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			"INSERT INTO `USER` (`USER_ID`,`USER_PWD`,`USER_NAME`,`ID_CARD`,`USER_GENDER`,`USER_DOB`,`USER_MAIL`,`USER_PHONE`,`USER_MOBILE`,`CITY`,`TOWN`,`ZIPCODE`,`USER_ADDR`,`REGDATE`,`USER_POINT`,`VIOLATION`,`USER_STATE`,`USER_COMMENT`,`COMMENT_TOTAL`,`CASH`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), 0, 0, 1, 0, 0, 0)";
	private static final String GET_ALL_STMT = "SELECT * FROM `USER` ORDER BY `VIOLATION` DESC";
	private static final String GET_ONE_STMT = "SELECT * FROM USER WHERE `USER_ID` = ?";
	private static final String DELETE = "DELETE FROM USER where USER_ID = ?";
	private static final String UPDATE = "UPDATE `USER` SET `USER_NAME`=?, `USER_GENDER`=?, `USER_DOB`=?, `USER_MAIL`=?, `USER_PHONE`=?, `USER_MOBILE`=?, `CITY`=?, `TOWN`=?, `ZIPCODE`=?, `USER_ADDR`=? ,`USER_PIC`=? WHERE `USER_ID` = ?";
	private static final String UPDATE_PSW = "UPDATE `USER` SET USER_PWD=? WHERE `USER_ID`=?";
	private static final String GET_Live_reportByUser_id_STMT = "SELECT LIVE_REPORT_NO,LIVE_REPORT_CONTENT,LIVE_NO,USER_ID,EMPNO,LIVE_REPORT_STATE,REPORT_DATE,PHOTO FROM LIVE_REPORT where USER_ID = ? ORDER BY LIVE_REPORT_NO";
	private static final String SIGN_IN = "SELECT * FROM USER where BINARY USER_ID=? AND BINARY USER_PWD=?";
	private static final String UPDATE_NEWPSW = "UPDATE `USER` SET USER_PWD=? WHERE `USER_ID`=?";
	private static final String UPDATE_USER_REPORT = "UPDATE USER SET USER_STATE =? WHERE USER_ID = ?;";
	private static final String UPDATE_CASH = "UPDATE USER SET CASH=? WHERE USER_ID=?";
	private static final String ADD_CASH = "UPDATE `USER` SET `CASH` = `CASH` + ? WHERE `USER_ID` = ?";

	private static final String UPDATE_USER_RATING = "UPDATE `USER` SET `USER_COMMENT` = `USER_COMMENT` + ?, `COMMENT_TOTAL` = `COMMENT_TOTAL` + ?  WHERE `USER_ID` = ?";
	private static final String UPDATE_USER_VIOLATION = "UPDATE USER SET VIOLATION=? WHERE USER_ID = ?";

	@Override
	public void insert(UserVO userVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, userVO.getUser_id());
			pstmt.setString(2, userVO.getUser_pwd());
			pstmt.setString(3, userVO.getUser_name());
			pstmt.setString(4, userVO.getId_card());
			pstmt.setString(5, userVO.getUser_gender());
			pstmt.setDate(6, userVO.getUser_dob());
			pstmt.setString(7, userVO.getUser_mail());
			pstmt.setString(8, userVO.getUser_phone());
			pstmt.setString(9, userVO.getUser_mobile());
			pstmt.setString(10, userVO.getCity());
			pstmt.setString(11, userVO.getTown());
			pstmt.setInt(12, userVO.getZipcode());
			pstmt.setString(13, userVO.getUser_addr());
//			pstmt.setDate(14, userVO.getRegdate());
//			pstmt.setInt(15, userVO.getUser_point());
//			pstmt.setInt(16, userVO.getViolation());
//			pstmt.setInt(17, userVO.getUser_state());
//			pstmt.setInt(18, userVO.getUser_comment());
//			pstmt.setInt(19, userVO.getComment_total());
//			pstmt.setInt(20, userVO.getCash());
			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
	public void update(UserVO userVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, userVO.getUser_name());
			pstmt.setString(2, userVO.getUser_gender());
			pstmt.setDate(3, userVO.getUser_dob());
			pstmt.setString(4, userVO.getUser_mail());
			pstmt.setString(5, userVO.getUser_phone());
			pstmt.setString(6, userVO.getUser_mobile());
			pstmt.setString(7, userVO.getCity());
			pstmt.setString(8, userVO.getTown());
			pstmt.setInt(9, userVO.getZipcode());
			pstmt.setString(10, userVO.getUser_addr());
			pstmt.setBytes(11, userVO.getUser_pic());
			pstmt.setString(12, userVO.getUser_id());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
	public void delete(String user_id) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, user_id);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
	public UserVO findByPrimaryKey(String user_id) {
		UserVO userVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// userVo 也稱為 Domain objects
				userVO = new UserVO();

				userVO.setUser_id(rs.getString("user_id"));
				userVO.setUser_pwd(rs.getString("user_pwd"));
				userVO.setUser_name(rs.getString("user_name"));
				userVO.setId_card(rs.getString("id_card"));
				userVO.setUser_gender(rs.getString("user_gender"));
				userVO.setUser_dob(rs.getDate("user_dob"));
				userVO.setUser_mail(rs.getString("user_mail"));
				userVO.setUser_phone(rs.getString("user_phone"));
				userVO.setUser_mobile(rs.getString("user_mobile"));
				userVO.setCity(rs.getString("city"));
				userVO.setTown(rs.getString("town"));
				userVO.setZipcode(rs.getInt("zipcode"));
				userVO.setUser_addr(rs.getString("user_addr"));
				userVO.setRegdate(rs.getDate("regdate"));
				userVO.setUser_point(rs.getInt("user_point"));
				userVO.setViolation(rs.getInt("violation"));
				userVO.setUser_state(rs.getInt("user_state"));
				userVO.setUser_comment(rs.getInt("user_comment"));
				userVO.setComment_total(rs.getInt("comment_total"));
				userVO.setCash(rs.getInt("cash"));
				userVO.setUser_pic(rs.getBytes("user_pic"));
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
		return userVO;
	}

	@Override
	public List<UserVO> getAll() {
		List<UserVO> list = new ArrayList<UserVO>();
		UserVO userVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// userVO 也稱為 Domain objects
				userVO = new UserVO();
				userVO.setUser_id(rs.getString("user_id"));
				userVO.setUser_pwd(rs.getString("user_pwd"));
				userVO.setUser_name(rs.getString("user_name"));
				userVO.setId_card(rs.getString("id_card"));
				userVO.setUser_gender(rs.getString("user_gender"));
				userVO.setUser_dob(rs.getDate("user_dob"));
				userVO.setUser_mail(rs.getString("user_mail"));
				userVO.setUser_phone(rs.getString("user_phone"));
				userVO.setUser_mobile(rs.getString("user_mobile"));
				userVO.setCity(rs.getString("city"));
				userVO.setTown(rs.getString("town"));
				userVO.setZipcode(rs.getInt("zipcode"));
				userVO.setUser_addr(rs.getString("user_addr"));
				userVO.setRegdate(rs.getDate("regdate"));
				userVO.setUser_point(rs.getInt("user_point"));
				userVO.setViolation(rs.getInt("violation"));
				userVO.setUser_state(rs.getInt("user_state"));
				userVO.setUser_comment(rs.getInt("user_comment"));
				userVO.setComment_total(rs.getInt("comment_total"));
				userVO.setCash(rs.getInt("cash"));
				list.add(userVO); // Store the row in the list
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
		return list;
	}

	@Override
	public Set<Live_reportVO> getLive_reportByUser_id(String user_id) {
		Set<Live_reportVO> set = new LinkedHashSet<Live_reportVO>();
		Live_reportVO live_reportVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_Live_reportByUser_id_STMT);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				live_reportVO = new Live_reportVO();
				live_reportVO.setLive_report_no(rs.getInt("live_report_no"));
				live_reportVO.setLive_report_content(rs.getString("live_report_content"));
				live_reportVO.setLive_no(rs.getInt("live_no"));
				live_reportVO.setUser_id(rs.getString("user_id"));
				live_reportVO.setEmpno(rs.getInt("empno"));
				live_reportVO.setLive_report_state(rs.getInt("live_report_state"));
				live_reportVO.setReport_date(rs.getTimestamp("report_date"));
				live_reportVO.setPhoto(rs.getBytes("photo"));
				set.add(live_reportVO); // Store the row in the vector
			}

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
		return set;
	}

	@Override
	public UserVO login(String user_id, String user_pwd) {

		UserVO userVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(SIGN_IN);

			pstmt.setString(1, user_id);
			pstmt.setString(2, user_pwd);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				userVO = new UserVO();
				userVO.setUser_id(rs.getString("user_id"));
				userVO.setUser_pwd(rs.getString("user_pwd"));
				userVO.setUser_name(rs.getString("user_name"));
				userVO.setId_card(rs.getString("id_card"));
				userVO.setUser_gender(rs.getString("user_gender"));
				userVO.setUser_dob(rs.getDate("user_dob"));
				userVO.setUser_mail(rs.getString("user_mail"));
				userVO.setUser_phone(rs.getString("user_phone"));
				userVO.setUser_mobile(rs.getString("user_mobile"));
				userVO.setCity(rs.getString("city"));
				userVO.setTown(rs.getString("town"));
				userVO.setZipcode(rs.getInt("zipcode"));
				userVO.setUser_addr(rs.getString("user_addr"));
				userVO.setRegdate(rs.getDate("regdate"));
				userVO.setUser_point(rs.getInt("user_point"));
				userVO.setViolation(rs.getInt("violation"));
				userVO.setUser_state(rs.getInt("user_state"));
				userVO.setUser_comment(rs.getInt("user_comment"));
				userVO.setComment_total(rs.getInt("comment_total"));
				userVO.setCash(rs.getInt("cash"));
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

		return userVO;

	}

	@Override
	public void getPassword_Update(UserVO userVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_PSW);

			pstmt.setString(1, userVO.getUser_pwd());
			pstmt.setString(2, userVO.getUser_id());

			int a = pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
	// 設定傳送郵件:至收信人的Email信箱,Email主旨,Email內容
	public void sendMail(UserVO userVO) {
		List<UserVO> list = new ArrayList<UserVO>();
		String emailto = userVO.getUser_mail();
		String link = userVO.getLink();
		String subject = "Mode Femme新密碼通知";

		String GET_ONE_USER = "SELECT `USER_NAME` FROM USER WHERE `USER_ID` = ?";

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_USER);

			pstmt.setString(1, userVO.getUser_id());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// userVo 也稱為 Domain objects
				userVO.setUser_name(rs.getString("user_name"));
			}

			String ch_name = userVO.getUser_name();
			String passRandom = userVO.getUser_pwd();
			String messageText = "<h1>Hello! " + ch_name + "<br>" + "請改用此密碼登入: " + passRandom + "<br>" + "並於登入後重新修改密碼！"
					+ " ( <a href=\"http://" + link + "/front-end/userLogin.jsp \"> 由此處登入 </a>) <h1>";

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
//			userVO.sendMail(emailto, subject, messageText);

			// 設定信中的主旨
			message.setSubject(subject);
			// 設定信中的內容
//			message.setText(messageText);
			message.setContent(messageText, "text/html ;charset=UTF-8");

			Transport.send(message);

			SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
			Date date = new Date();
			String strDate = sdFormat.format(date);

			System.out.println(strDate + " 傳送成功!");

		} catch (MessagingException e) {
			System.out.println("傳送失敗!");
			e.printStackTrace();
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
	}

	@Override
	public void newPassword_Update(UserVO userVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_NEWPSW);

			pstmt.setString(1, userVO.getUser_pwd());
			pstmt.setString(2, userVO.getUser_id());

			int a = pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
	public void update_user_report(UserVO userVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_USER_REPORT);

			pstmt.setInt(1, userVO.getUser_state());
//			System.out.println("userDao 653 user_state = " + userVO.getUser_state());
			pstmt.setString(2, userVO.getUser_id());
//			System.out.println("userDao 657 userid = " + userVO.getUser_id());
			pstmt.executeUpdate();

			// Handle any driver errors
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
	public void updateUserRating(UserVO userVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_USER_RATING);
			
			pstmt.setInt(1, userVO.getUser_comment());
			pstmt.setInt(2, userVO.getComment_total());
			pstmt.setString(3, userVO.getUser_id());
			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("database發生錯誤." + se.getMessage());
		} finally {
			if (pstmt != null) {
		}
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
	public Optional<UserVO> findUserPic(String user_id) {
		UserVO userVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				userVO = new UserVO();
				userVO.setUser_pic(rs.getBytes("user_pic"));
			}
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

		return Optional.ofNullable(userVO);
	}

	@Override
	public void updateCash(UserVO userVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_CASH);

			pstmt.setInt(1, userVO.getCash());
			pstmt.setString(2, userVO.getUser_id());

			int a = pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
	public void addCash(UserVO userVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(ADD_CASH);

			pstmt.setInt(1, userVO.getCash());
			pstmt.setString(2, userVO.getUser_id());

			pstmt.executeUpdate();
			// Handle any driver errors
					} catch (SQLException se) {
						throw new RuntimeException("A database error occured. " + se.getMessage());
						// Clean up JDBC resources
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
	public void updateUserViolation(String user_id, Integer violation) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_USER_VIOLATION);

			pstmt.setInt(1, violation);
			pstmt.setString(2, user_id);

			int a = pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
