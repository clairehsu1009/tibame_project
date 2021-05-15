<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.live_order.model.*"%>

<%
	Live_orderVO live_orderVO = (Live_orderVO) request.getAttribute("live_orderVO"); //EmpServlet.java (Concroller) 存入req的live_orderVO物件 (包括幫忙取出的live_orderVO, 也包括輸入資料錯誤時的live_orderVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>直播訂單修改 - update_live_order_input.jsp</title>

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
	width: 450px;
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
		<tr>
			<td>
				<h3>直播訂單資料修改 - update_live_order_input.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/front-end/live_order/select_page.jsp"><img src="<%=request.getContextPath()%>/images/back1.gif"
						width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料修改:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live_order/live_order.do" name="form1">
		<table>
			<tr>
				<td>直播訂單編號:<font color=red><b>*</b></font></td>
				<td><%=live_orderVO.getLive_order_no()%></td>
			
			</tr>
			<tr>
				<td>直播訂單日期:<font color=red><b>*</b></font></td>
				<td><fmt:formatDate value="${live_orderVO.order_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr>
				<td>直播訂單付款到期日:<font color=red><b>*</b></font></td>
				<td><fmt:formatDate value="${live_orderVO.pay_deadline}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr>
				<td>直播訂單狀態:</td>
				<td><select name="order_state">
						<option value="0" ${(live_orderVO.order_state==0)? 'selected':''}>未付款</option>
						<option value="1" ${(live_orderVO.order_state==1)? 'selected':''}>已付款</option>
						<option value="2" ${(live_orderVO.order_state==2)? 'selected':''}>棄單</option>
				</select></td>
			</tr>
			<tr>
				<td>直播訂單價格:<font color=red><b>*</b></font></td>
				<td><%=live_orderVO.getOrder_price()%></td>
			</tr>
			<tr>
				<td>回饋點數:</td>
				<td><input type="TEXT" name="point" size="45"
					value="<%=live_orderVO.getPoint()%>" /></td>
			</tr>
			<tr>
				<td>直播訂單付款方式:</td>
				<td><select name="pay_method">
						<option value="0" ${(live_orderVO.pay_method==0)? 'selected':''}>錢包</option>
						<option value="1" ${(live_orderVO.pay_method==1)? 'selected':''}>信用卡</option>
						<option value="2" ${(live_orderVO.pay_method==2)? 'selected':''}>轉帳</option>
				</select></td>
			</tr>

			<tr>
				<td>收件人姓名:</td>
				<td><input type="TEXT" name="rec_name" size="45"
					value="<%=live_orderVO.getRec_name()%>" /></td>
			</tr>

			<tr>
				<td>收件人地址:</td>

				
				<td>
				<div id="twzipcode"></div>
				<input type="TEXT" name="rec_addr" size="45"
					value="<%=live_orderVO.getRec_addr()%>" /></td>
					
			</tr>

			<tr>
				<td>收件人電話:</td>
				<td><input type="TEXT" name="rec_phone" size="45"
					value="<%=live_orderVO.getRec_phone()%>" /></td>
			</tr>

			<tr>
				<td>收件人手機:</td>
				<td><input type="TEXT" name="rec_cellphone" size="45"
					value="<%=live_orderVO.getRec_cellphone()%>" /></td>
			</tr>

			<tr>
				<td>物流方式:</td>
				<td><select name="logistics" id="logistics">
						<option value="0" ${(live_orderVO.logistics==0)? 'selected':''}>宅配</option>
						<option value="1" ${(live_orderVO.logistics==1)? 'selected':''}>超商</option>
				</select></td>
			</tr>
			<tr>
				<td>運費:</td>
				<td>
				<div id="showOrder_shipping">${live_orderVO.order_shipping}</div>
				<input type="HIDDEN" name="order_shipping" id="order_shipping" size="45" value="<%=live_orderVO.getOrder_shipping()%>" />
				</td>
			</tr>

			<tr>
				<td>物流狀態:</td>
				<td><select name="logistics_state">
						<option value="0"
							${(live_orderVO.logistics_state==0)? 'selected':''}>未出貨</option>
						<option value="1"
							${(live_orderVO.logistics_state==1)? 'selected':''}>已出貨</option>
						<option value="2"
							${(live_orderVO.logistics_state==2)? 'selected':''}>買家已取貨</option>
				</select></td>
			</tr>

			<jsp:useBean id="liveSvc" scope="page" class="com.live.model.LiveService" />
			<tr>
				<td>直播編號:<font color=red><b>*</b></font></td>
				<td><select size="1" name="live_no" id="live_no">
					<c:forEach var="liveVO" items="${liveSvc.all}">
						<option value="${liveVO.live_no}" ${(live_orderVO.live_no==liveVO.live_no)? 'selected':'' } >${liveVO.live_no}
					</c:forEach>
				</select></td>
			</tr>

			<jsp:useBean id="userSvc" scope="page" class="com.user.model.UserService" />
			<tr>
				<td>賣家帳號:<font color=red><b>*</b></font></td>
				<td>
				<div id="showSellerId">${live_orderVO.seller_id}</div>
				<input name="seller_id" id="seller_id" value="<%=live_orderVO.getSeller_id()%>" type="HIDDEN" />
				</td>
			</tr>
			
			<tr>
				<td>買家帳號:<font color=red><b>*</b></font></td>
				<td><select size="1" name="user_id" id="user_id">
					<c:forEach var="userVO" items="${userSvc.all}">
						<option value="${userVO.user_id}" ${(live_orderVO.user_id==userVO.user_id)? 'selected':'' } >${userVO.user_id}
					</c:forEach>
				</select></td>
			</tr>
			
			<tr>
				<td>最大可用點數:</td>
				<td><div id="showPoint">${userVO.user_point}</div></td>
			</tr>
			<tr>
				<td>折扣:</td>
				<td><input type="TEXT" name="discount" size="45"
					value="<%=live_orderVO.getDiscount()%>" /></td>
			</tr>


			<tr>
				<td>評價分數:</td>
				<td><select name="srating">
						<option value="5" ${(live_orderVO.srating==5)? 'selected':''}>5</option>
						<option value="4" ${(live_orderVO.srating==4)? 'selected':''}>4</option>
						<option value="3" ${(live_orderVO.srating==3)? 'selected':''}>3</option>
						<option value="2" ${(live_orderVO.srating==2)? 'selected':''}>2</option>
						<option value="1" ${(live_orderVO.srating==1)? 'selected':''}>1</option>
				</select></td>
			</tr>

			<tr>
				<td>評價內容:</td>
				<td><input type="TEXT" name="srating_content" size="45"
					value="<%=live_orderVO.getSrating_content()%>" /></td>
			</tr>

		</table>

		<br> <input type="hidden" name="action" value="update"> 
			<input  type="hidden" name="live_order_no" value="<%=live_orderVO.getLive_order_no()%>"> 
			<input  type="hidden" name="order_date" value="<%=live_orderVO.getOrder_date()%>"> 
			<input  type="hidden" name="order_price"value="<%=live_orderVO.getOrder_price()%>"> 
			<input  type="hidden" name="pay_deadline" value="<%=live_orderVO.getPay_deadline()%>"> 
			<input  type="submit" value="送出修改">
	</FORM>
</body>
<script>

$("#twzipcode").twzipcode({
	zipcodeIntoDistrict: true, // 郵遞區號自動顯示在區別選單中
	css: ["city form-control", "town form-control"], // 自訂 "城市"、"地別" class 名稱 
	countyName: "city", // 自訂城市 select 標籤的 name 值
	districtName: "town", // 自訂區別 select 標籤的 name 值
	countySel: "<%=live_orderVO.getCity()%>",
	districtSel: "<%=live_orderVO.getTown()%>",
	zipcodeSel: "<%=live_orderVO.getZipcode()%>"
	});
	
$("#logistics").change(function(e) {
	if($("#logistics").val() == '0'){
		$("#order_shipping").attr('value', '100');
		$("#showOrder_shipping").text("100");
	}else{
		$("#order_shipping").attr('value', '50');
		$("#showOrder_shipping").text("50") ;
	}
	});
$("#live_no").change(function(e) {
	<c:forEach var="liveVO" items="${liveSvc.all}">	
	if($("#live_no").val()==${liveVO.live_no}){		
		$("#seller_id").attr('value', '${liveVO.user_id}');
		$("#showSellerId").text('${liveVO.user_id}');
	}	
	</c:forEach>
	});
$()
$("#user_id").change(function(e){
	<c:forEach var="userVO" items="${userSvc.all}">	
	if($("#user_id").val()=='${userVO.user_id}'){
		$("#showPoint").text('${userVO.user_point}');
	}
	</c:forEach>
});
</script>

</html>