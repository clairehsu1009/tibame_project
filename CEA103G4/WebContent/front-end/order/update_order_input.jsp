<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.order.model.*"%>

<%
  OrderVO orderVO = (OrderVO) request.getAttribute("orderVO"); //OrderServlet.java (Concroller) 存入req的orderVO物件 (包括幫忙取出的orderVO, 也包括輸入資料錯誤時的orderVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>訊息資料修改 - update_order_input.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: auto;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>訂單資料修改 - update_order_input.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>訂單修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="order.do" name="form1">
<table>
<jsp:useBean id="userSvc" scope="page" class="com.user.model.UserService" />
	<tr>
		<td>訂單編號:</td>
		<td>${orderVO.order_no}</td>
		<td><input type="hidden" name="order_no" value="${orderVO.order_no}"></td>
	</tr>
	<tr>
		<td>訂單時間:</td>
		<td><fmt:formatDate value="${orderVO.order_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		<td><input type="hidden" name="order_date" value="${orderVO.order_date}"></td>
	</tr>
	<tr>
		<td>付款截止期限:</td>
		<td><fmt:formatDate value="${orderVO.pay_deadline}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		<td><input type="hidden" name="pay_deadline" value="${orderVO.pay_deadline}"></td>
	</tr> 
	<tr>
		<td>訂單狀態:</td>
		<td><select name="order_state">
						<option value="0" ${(orderVO.order_state==0)? 'selected':''}>未付款</option>
						<option value="1" ${(orderVO.order_state==1)? 'selected':''}>已付款</option>
		</select></td>
	</tr>
	<tr>
		<td>訂單金額:</td>
		<td><input type="TEXT" name="order_price" size="45"	id="order_price" value="${orderVO.order_price}" /></td>
	</tr>
	<tr>
		<td>付款方式:</td>
		<td><select name="pay_method">
						<option value="0" ${(orderVO.pay_method==0)? 'selected':''}>錢包</option>
						<option value="1" ${(orderVO.pay_method==1)? 'selected':''}>信用卡</option>
						<option value="2" ${(orderVO.pay_method==2)? 'selected':''}>轉帳</option>
		</select></td>	
	<tr>
		<td>收件人姓名:</td>
		<td><input type="TEXT" name="rec_name" size="45"	value="${orderVO.rec_name}" /></td>
	</tr>
	
	<tr>
		<td>收件人地址:</td>
		<td><div id="twzipcode"></div>
		<input type="TEXT" name="rec_addr" size="45"	value="${orderVO.rec_addr}" /></td>
	</tr>
	<tr>
		<td>收件人電話:</td>
		<td><input type="TEXT" name="rec_phone" size="45"	value="${orderVO.rec_phone}" /></td>
	</tr>
	<tr>
		<td>收件人手機:</td>
		<td><input type="TEXT" name="rec_cellphone" size="45"	value="${orderVO.rec_cellphone}" /></td>
	</tr>
	<tr>
		<td>物流方式:</td>
		<td><select name="logistics" id="logistics">
						<option value="0" ${(orderVO.logistics==0)? 'selected':''}>超商</option>
						<option value="1" ${(orderVO.logistics==1)? 'selected':''}>宅配</option>
		</select></td>	
	<tr>
	<tr>
		<td>訂單運費:</td>
		<td>
			<div id="showOrder_shipping">100</div>
			<input type="hidden" name="order_shipping" id="order_shipping" size="45" value="100"/>
		</td>
	</tr>
	<tr>
		<td>物流狀態:</td>
		<td><select name="logisticsstate">
						<option value="0" ${(orderVO.logisticsstate==0)? 'selected':''}>未出貨</option>
						<option value="1" ${(orderVO.logisticsstate==1)? 'selected':''}>已出貨</option>
						<option value="2" ${(orderVO.logisticsstate==2)? 'selected':''}>已取貨</option>
		</select></td>	
	<tr>
	<tr>
		<td>使用點數折抵:</td>
		<td>
		<div>可用點數:${userVO.user_point}</div>
		<input type="TEXT" name="discount" size="45" value="0"/>
		</td>
	</tr>
	<tr>
		<td>買家帳號:<font color=red><b>*</b></font></td>
		<td><select size="1" name="user_id">
					<c:forEach var="userVO" items="${userSvc.all}">
						<option value="${userVO.user_id}" ${(orderVO.user_id==userVO.user_id)? 'selected':'' } >${userVO.user_id}
					</c:forEach>
		</select></td>
	</tr>
	<tr>
		<td>賣家帳號:<font color=red><b>*</b></font></td>
		<td><select size="1" name="seller_id">
					<c:forEach var="userVO" items="${userSvc.all}">
						<option value="${userVO.user_id}" ${(orderVO.user_id==userVO.user_id)? 'selected':'' } >${userVO.user_id}
					</c:forEach>
				</select></td>
	</tr>
	<tr>
		<td>評價分數:</td>
		<td>
		<input type="hidden" name="srating" value="${orderVO.srating}" id="con"/>
		<ion-icon name="star" class="star all-star" id="s1"></ion-icon>
		<ion-icon name="star" class="star all-star" id="s2"></ion-icon>
		<ion-icon name="star" class="star all-star" id="s3"></ion-icon>
		<ion-icon name="star" class="star all-star" id="s4"></ion-icon>
		<ion-icon name="star" class="star all-star" id="s5"></ion-icon>
		</td>
	</tr>
	<tr>
		<td>賣家評價內容:</td>
		<td><input type="TEXT" name="srating_content" size="45"	value="${orderVO.srating_content}" /></td>
	</tr>
	<tr>
		<td>點數回饋:</td>
		<td>
		<div id="showOrder_point">${orderVO.point}</div>
		<input type="hidden" name="point" size="45" id="point" value="${orderVO.point}"/>
		</td>
	</tr>
</table>
<br>
		<input type="hidden" name="action" value="update">
		<input type="submit" value="送出修改">
	</FORM>
<script src="https://unpkg.com/ionicons@5.4.0/dist/ionicons.js"></script>
</body>
<script>

$(document).ready(function(){
	switch($("#con").val()){
	case "1":
		$("#s1").css("color","#f6d04d");
		break;
	case "2":
		$("#s1,#s2").css("color","#f6d04d");
		break;
	case "3":
		$("#s1,#s2,#s3").css("color","#f6d04d");
		break;
	case "4":
		$("#s1,#s2,#s3,#s4").css("color","#f6d04d");
		break;
	case "5":
		$(".all-star").css("color","#f6d04d");
		break;
	default:
		$(".all-star").css("color","black");
	}
	$("#s1").click(function(){
		$(".all-star").css("color","black");
		$("#s1").css("color","#f6d04d");
		$("#con").val("1");
	})
	$("#s2").click(function(){
		$(".all-star").css("color","black");
		$("#s1,#s2").css("color","#f6d04d");
		$("#con").val("2");
	})
	$("#s3").click(function(){
		$(".all-star").css("color","black");
		$("#s1,#s2,#s3").css("color","#f6d04d");
		$("#con").val("3");
	})
	$("#s4").click(function(){
		$(".all-star").css("color","black");
		$("#s1,#s2,#s3,#s4").css("color","#f6d04d");
		$("#con").val("4");
	})
	$("#s5").click(function(){
		$(".all-star").css("color","black");
		$(".all-star").css("color","#f6d04d");
		$("#con").val("5");
	})
})
$("#logistics").change(function(e) {
	if($("#logistics").val() == '0'){
		$("#order_shipping").attr('value', '100');
		$("#showOrder_shipping").text("100");
	}else{
		$("#order_shipping").attr('value', '50');
		$("#showOrder_shipping").text("50");
	}
	});
$("#order_price").change(function(e) {
	let point = Math.floor($("#order_price").val()/100);
	$("#point").attr('value', point);
	$("#showOrder_point").text(point);
		}); //尚未修改好
$("#twzipcode").twzipcode({
	zipcodeIntoDistrict: true, // 郵遞區號自動顯示在區別選單中
	css: ["city form-control", "town form-control"], // 自訂 "城市"、"地別" class 名稱 
	countyName: "city", // 自訂城市 select 標籤的 name 值
	districtName: "town", // 自訂區別 select 標籤的 name 值
	countySel: "${orderVO.city}",
	districtSel: "${orderVO.town}",
	zipcodeSel: "${orderVO.zipcode}"
	}); 
	</script>
</html>