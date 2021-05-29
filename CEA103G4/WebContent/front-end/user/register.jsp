<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.user.model.*"%>

<%
	UserVO userVO = (UserVO) request.getAttribute("userVO");
	request.setAttribute("userVO", userVO);
%>

<!DOCTYPE html>
<html lang="zh-Hant">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Modefemme</title>
    <link rel="icon" href="${pageContext.request.contextPath}/front-template/images/favicon.ico" type="image/x-icon">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>

    <!-- Google Font -->
    <link
      href="https://fonts.googleapis.com/css?family=Muli:300,400,500,600,700,800,900&display=swap"
      rel="stylesheet"
    />

    <!-- Css Styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/themify-icons.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/elegant-icons.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/owl.carousel.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/nice-select.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/jquery-ui.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/slicknav.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/style.css" type="text/css" />
    <style type="text/css">
  	.register-login-section {
    padding-top: 0px;
	}
	.register-form h2 {
    margin-bottom: 10px;
    margin-top: 10px;
	}
	td {
    padding-right: 5px;
    padding-bottom: 5px;
}
  	</style>
  </head>

  <body>
<!-- Header Section Begin -->
<header class="header-section">
	<div class="container">
		<div class="inner-header">
			<div class="row">
				<div class="col-lg-2 col-md-2">
					<div class="logo" id="topLogo">
						<a href="${pageContext.request.contextPath}/front-end/index.jsp">
							<h2>
								Mode femme <br /> <small>Second&nbsp;Hand </small>
							</h2>
						</a>
					</div>
				</div>
				<div class="col-lg-7 col-md-7">
					<div class="advanced-search">
						<form class="input-group" id="search">
							<input type="text" id="product_name" name="product_name" value=""
								placeholder="What do you need?" />
							<button type="button" id="sendQuery" onclick="sendQuery">
								<i class="ti-search"></i>
							</button>
						</form>
					</div>
				</div>
				<div class="col-lg-3 text-right col-md-3">
					<div class="header-right">
						<a
							href="<%=request.getContextPath()%>/front-end/user/register.jsp"><button
								type="button" class="btn">註冊</button></a> <a
							href="<%=request.getContextPath()%>/front-end/userLogin.jsp" ><button
								type="button" class="btn">登入</button></a>
					</div>
					<!-- 鈴鐺/購物車顯示的數字+購物車預覽圖要改 -->
					<ul class="nav-right">
						<li class="bell-icon"><a href="#"> <svg
									xmlns="http://www.w3.org/2000/svg" width="20" height="20"
									fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
                      <path
										d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z" />
                    </svg> 
                    <span>0</span>
						</a></li>
						<li class="cart-icon"><a
							href="${pageContext.request.contextPath}/front-end/productsell/shoppingCart.jsp">
								<i class="icon_bag_alt"></i> <c:if test="${buylist != null}">
									<span id="iba">${buylist.size()}</span>
								</c:if> <c:if test="${buylist == null}">
									<span id="iba">0</span>
								</c:if>
						</a> 
							<div class="cart-hover">
								<div class="select-items">
									<table>
										<tbody id="carts">
											<c:set var="sum" value="0">
											</c:set>
											<c:forEach var="order" items="${buylist}"
												varStatus="cartstatus">
												<tr>
													<td class="si-pic"><img
														src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${order.product_no}"
														alt="${order.product_name}"
														style="width: 100px; height: 100px; border-radius: 10px;" /></td>
													<td class="si-text">
														<div class="product-selected">
															<p>$${order.product_price } x
																${order.product_quantity}</p>
															<h6>${order.product_name }</h6>
														</div>
													</td>
												</tr>
												<c:set var="sum"
													value="${sum + order.product_price*order.product_quantity}"></c:set>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="select-total">
									<span>total:</span>
									<h5 id="cartHoverTotal">$${sum}</h5>
								</div>
								<div class="select-button">
									<a
										href="${pageContext.request.contextPath}/front-end/productsell/shoppingCart.jsp"
										class="primary-btn view-card">購物車清單</a> <a
										href="${pageContext.request.contextPath}/front-end/protected/check-out.jsp"
										class="primary-btn checkout-btn">結帳</a>
								</div>
							</div>
							</li>
						<c:if test="${buylist.size() > 0 }">
							<li class="cart-price" id="totalprice">$${sum}</li>
						</c:if>
						<c:if test="${buylist == null}">
							<li class="cart-price">$0</li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="nav-item">
		<div class="container">
			<div class="nav-depart">
				<div class="depart-btn">
					<i class="ti-menu"></i> <span>商品分類</span>
					<ul class="depart-hover">
						<c:forEach var="product_typeVO" items="${list2}" begin="0"
							end="${list2.size()}">
							<a
								href="<%=request.getContextPath()%>/product_type/product_type.do?action=getProductsByPdtype&pdtype_no=${product_typeVO.pdtype_no}"><li><div>${product_typeVO.pdtype_name}</div></li></a>
						</c:forEach>
					</ul>
				</div>
			</div>
			<nav class="nav-menu mobile-menu">
				<ul>
					<li class="active" id="nav-index"><a
						href="${pageContext.request.contextPath}/front-end/index.jsp">首頁</a></li>
					<li><a
						href="<%=request.getContextPath()%>/front-end/productsell/shop.jsp">商品專區</a></li>
					<li><a
						href="<%=request.getContextPath()%>/front-end/live/liveWall.jsp">直播專區</a>
						<ul class="dropdown">
							<li><a
								href="<%=request.getContextPath()%>/front-end/live/liveWall.jsp">直播牆</a></li>
							<li><a
								href="<%=request.getContextPath()%>/front-end/live/livePreview.jsp">直播預告</a></li>
				
						</ul></li>
					<li><a
						href="<%=request.getContextPath()%>/front-end/protected/userIndex.jsp">會員專區<i
							class="icon_profile"></i></a></li>
<!-- 					<li> -->
<%-- 						<form id="myForm" action="<%=request.getContextPath()%>/chat.do" --%>
<!-- 							method="POST"> -->
<%-- 							<input value="${userVO.user_name}" name="userName" type="hidden" /> --%>
<!-- 							<a href="#" onclick="document.getElementById('myForm').submit();">線上客服&nbsp;<i -->
<!-- 								class="fa fa-comment-o"></i></a> -->
<!-- 						</form> -->
<!-- 					</li> -->
					<li><a href="<%=request.getContextPath()%>/front-end/qa/qna.jsp">常見問題</a></li>
				</ul>
			</nav>
			<div id="mobile-menu-wrap"></div>
		</div>
	</div>
	<div id="goTop" style="position: fixed; right: 0px; bottom: 45px; z-index: 99999;">
		<a href="#topLogo"><img style="height:75px;" src="<%=request.getContextPath()%>/front-template/images/top.gif" title="回上方"></a>
	</div>
</header>
<!-- Header End -->
	
    <!-- Breadcrumb Section Begin -->
    <div class="breacrumb-section">
      <div class="container">
        <div class="row">
          <div class="col-lg-12">
            <div class="breadcrumb-text">
              <a href="<%=request.getContextPath()%>/front-end/index.jsp"><i class="fa fa-home"></i> Home</a>
              <span>註冊</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Breadcrumb Form Section Begin -->

    <!-- Register Section Begin -->
    <div class="register-login-section spad">
      <div class="container">
        <div class="row">
          <div class="col-lg-6 offset-lg-3">
            <div class="register-form">
              <h2>會員註冊</h2>
              <FORM form METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/user/user.do" name="form1">
<!--                 <div class="group-input"> -->
<!--                   <label for="user_id">帳號 *</label> -->
<%--                   <input type="text" name="user_id" value="<%= (userVO==null)? "" : userVO.getUser_id()%>"/> --%>
<!--                 </div> -->
<table>
	<tr>
		<td>帳號 </td>
		<td><input type="TEXT" class="form-control" name="user_id" size="45" 
			 value="<%= (userVO==null)? "" : userVO.getUser_id()%>" /></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.user_id}</b></td></tr>
	<tr>
		<td>密碼 </td>
		<td><input type="password" class="form-control" name="user_pwd" size="45" 
			 value="<%= (userVO==null)? "" : userVO.getUser_pwd()%>" /></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.user_pwd}</b></td></tr>
	<tr>
		<td>姓名 </td>
		<td><input type="TEXT" class="form-control" name="user_name" size="45" 
			 value="<%= (userVO==null)? "" : userVO.getUser_name()%>" /></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.user_name}</b></td></tr>
	<tr>
		<td>身分證字號 </td>
		<td><input type="TEXT" class="form-control" name="id_card" size="45"
			 value="<%= (userVO==null)? "" : userVO.getId_card()%>" /></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.id_card}</b></td></tr>
	<tr>
	<td>性別 </td>
	<td><input type="radio" name="user_gender" value="1" ${(userVO.user_gender==1)? 'checked':'' }>
	<label for="male">男</label>
	<input type="radio" name="user_gender" value="0" ${(userVO.user_gender==0)? 'checked':'' }>
	<label for="female">女</label><font color=red><b>${errorMsgs.user_gender}</b></td>
	</tr>
	
	<tr>
		<td>生日 </td>
		<td><input name="user_dob" class="form-control" size="45" id="f_date1" type="text"></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.user_dob}</b></td></tr>
	<tr>
		<td>Email</td>
		<td><input type="TEXT" class="form-control" name="user_mail" size="45"
			 value="<%= (userVO==null)? "" : userVO.getUser_mail()%>" /></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.user_mail}</b></td></tr>
	<tr>
		<td>電話</td>
		<td><input type="TEXT" class="form-control" name="user_phone" size="45"
			 value="<%= (userVO==null)? "" : userVO.getUser_phone()%>" /></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.user_phone}</b></td></tr>
	<tr>
		<td>手機號碼</td>
		<td><input type="TEXT" class="form-control" name="user_mobile" size="45"
			 value="<%= (userVO==null)? "" : userVO.getUser_mobile()%>" /></td>
	</tr><tr><td></td><td><font color=red><b>${errorMsgs.user_mobile}</b></td></tr>
	<tr>
		<td>地址</td>
		<td>
		<div id="twzipcode"></div><font color=red><b>${errorMsgs.city}</b>
		<input type="TEXT" class="form-control" name="user_addr" size="45" value="<%= (userVO==null)? "" : userVO.getUser_addr()%>"></td>
		</td><tr><td></td><td><font color=red><b>${errorMsgs.user_addr}</b></td></tr>
	</tr>
<%-- 	<jsp:useBean id="userSvc" scope="page" class="com.user.model.UserService" /> --%>
</table>
				<input type="hidden" name="action" value="insert">
                <button type="submit" class="site-btn register-btn">
                  	加入會員
                </button>
              </FORM>
            <div _ngcontent-sc209="" class="card-body px-5 py-4">
				<div _ngcontent-sc209="" class="small text-center">
					已經有帳號了嗎?&nbsp; <a style="color:pink; font-weight:700;" href="<%=request.getContextPath()%>/front-end/protected/userIndex.jsp">請直接登入 !</a>
				</div>
			</div>
<!--               <div class="switch-login"> -->
<%--                 <a href="<%=request.getContextPath()%>/front-end/protected/userIndex.jsp" class="or-login">已經有帳號了嗎?請直接登入</a> --%>
<!--               </div> -->
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Register Form Section End -->

	<!-- Footer Section Begin -->
	<%@include file="/front-end/footer.jsp"%>
    <!-- Footer Section End -->

    <!-- Js Plugins -->
<%--     <script src="${pageContext.request.contextPath}/front-template/js/jquery-3.3.1.min.js"></script> --%>
    <script src="${pageContext.request.contextPath}/front-template/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.countdown.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.nice-select.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.zoom.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.dd.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.slicknav.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/main.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/ajaxSearch.js"></script>
  </body>
<script>
$("#twzipcode").twzipcode({
	zipcodeIntoDistrict: true, // 郵遞區號自動顯示在區別選單中
	css: ["city form-control", "town form-control"], // 自訂 "城市"、"地別" class 名稱 
	countyName: "city", // 自訂城市 select 標籤的 name 值
	districtName: "town", // 自訂區別 select 標籤的 name 值
	countySel: "<%=(userVO==null)? "" :userVO.getCity()%>",
	districtSel: "<%=(userVO==null)? "" :userVO.getTown()%>",
	zipcodeSel: "<%=(userVO==null)? "" :userVO.getZipcode()%>"
	});

</script>

<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
  java.sql.Date user_dob = null;
  try {
	  user_dob = userVO.getUser_dob();
   } catch (Exception e) {
	   user_dob = new java.sql.Date(System.currentTimeMillis());
   }
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=user_dob%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
</script>
</html>
