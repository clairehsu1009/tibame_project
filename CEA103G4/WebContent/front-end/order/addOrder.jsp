<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.order.model.*"%>
<%@ page import="com.product.model.*"%>




<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>訂單資料新增 - addOrder.jsp</title>
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
  .fa-star {
  	font-size:65px
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
  .star {
  	width: 20px;
  	height: 20px;
  }
  textarea{
  resize : none
  }
</style>
</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>訂單資料新增 - addOrder.jsp</h3></td><td>
		 <h4><a href="select_page.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

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
<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" />

	<tr>
		<td>商品編號：</td>
		<td>${param.product_no}</td>
		<td><input type="hidden" name="product_no" value="${param.product_no}"></td>
	</tr>
	<tr>
		<td>商品庫存：</td>
		<td>${productVO.product_remaining}</td>
		<td><input type="hidden" name="product_remaining" value="${productVO.product_remaining}"></td>
	</tr>
	<tr>
		<td>商品狀態：</td>
		<td>${(productVO.product_state==0)? '待售':''}
			${(productVO.product_state==1)? '直售':''}
			${(productVO.product_state==2)? '直播':''}
			${(productVO.product_state==3)? '已售出':''}
			${(productVO.product_state==4)? '下架':''}
			${(productVO.product_state==5)? '檢舉下架':''}
		</td>
		<td><input type="hidden" name="product_state" value="${productVO.product_state}"></td>
	</tr>
	<tr>
		<td>商品售價：</td>
		<td>${productVO.product_price}</td>
		<td><input type="hidden" name="product_price" value="${productVO.product_price}"></td>
	</tr>
	<tr>
		<td>購買數量：</td>
		<td>
		<input type="button" value="-" class="remove">
		<input type="TEXT" name="product_num" size="2" id="product_num" value="0"  style="text-align:center">
		<input type="button" value="+" class="add">
		</td>
	</tr>
	
	
	<tr>
		<td>訂單狀態:</td>
		<td><select name="order_state"> 
			<option value="0">未付款</option>
			<option value="1">已付款</option>
		</select>
		</td>
	</tr>
	
	<tr>
		<td>結帳金額:</td>
		<td><input type="TEXT" name="order_price" size="45" id="order_price" value="${param.order_price}"/></td>
	</tr>
	<tr>
		<td>付款方式:</td>
		<td><select name="pay_method">
	
			<option value="0">錢包</option>
			<option value="1">信用卡</option>
			<option value="2">轉帳</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>收件人姓名:</td>
		<td><input type="TEXT" name="rec_name" size="45" value="${param.rec_name}"/></td>
	</tr>
	<tr>
		<td>收件人地址:</td>
		<td>
		<div id="twzipcode"></div>
		<input type="TEXT" name="rec_addr" size="45"  value="${param.rec_addr}"/>
		</td>
	</tr>
	<tr>
		<td>收件人電話:</td>
		<td><input type="TEXT" name="rec_phone" size="45" value="${param.rec_phone}"/></td>
	</tr>
	<tr>
		<td>收件人手機:</td>
		<td><input type="TEXT" name="rec_cellphone" size="45" value="${param.rec_cellphone}"/></td>
	</tr>
	<tr>
		<td>物流方式:</td>
		<td><select name="logistics" id="logistics">
			<option value="0">超商</option>
			<option value="1">宅配</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>訂單運費:</td>
		<td>
			<div id="showOrder_shipping">100</div>
			<input type="hidden" name="order_shipping" id="order_shipping" size="45" value="100"/>
		</td>
	</tr>
	<tr>
		<td>物流狀態:</td>
		<td><select name="logisticsstate" >
			<option value="0">未出貨</option>
			<option value="1">已出貨</option>
			<option value="2">已取貨</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>可用點數:</td>
		<td><div id="showPoint">0</div></td>
	</tr>
	<tr>
		<td>使用點數折抵:</td>
		<td><input type="TEXT" name="discount" size="45" value="0"/></td>
	</tr>
	<tr>
		<td>買家帳號:<font color=red><b>*</b></font></td>
		<td><select size="1" name="user_id" id="user_id">
					<c:forEach var="userVO" items="${userSvc.all}">
						<option value="${userVO.user_id}" ${(orderVO.user_id==userVO.user_id)? 'selected':'' } >${userVO.user_id}
					</c:forEach>
		</select></td>
	</tr>
	<tr>
		<td>賣家帳號:<font color=red><b>*</b></font></td>
		<td><select size="1" name="seller_id" id="seller_id">
					<c:forEach var="userVO" items="${userSvc.all}">
						<option value="${userVO.user_id}" ${(orderVO.user_id==userVO.user_id)? 'selected':'' } >${userVO.user_id}
					</c:forEach>
				</select></td>
	</tr>
	<tr>
		<td>評價分數:</td>
		<td>
		<input type="hidden" name="srating" value="0" id="con"/>
		<ion-icon name="star" class="star all-star" id="s1"></ion-icon>
		<ion-icon name="star" class="star all-star" id="s2"></ion-icon>
		<ion-icon name="star" class="star all-star" id="s3"></ion-icon>
		<ion-icon name="star" class="star all-star" id="s4"></ion-icon>
		<ion-icon name="star" class="star all-star" id="s5"></ion-icon>
		</td>
	</tr>
	<tr>
		<td>評價內容:</td>
		<td><textarea name="srating_content" rows="10" cols="43" >${param.srating_content}</textarea></td>
	</tr>
	<tr>
		<td>點數回饋:</td>
		<td>
		<div id="showOrder_point"></div>
		<input type="hidden" name="point" size="45" id="point" value="${param.point}"/>
		</td>
	</tr>
	
</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
<script src="https://unpkg.com/ionicons@5.4.0/dist/ionicons.js"></script>
</body>
<script>
	$(document).ready(function(){
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
	})
	$("#product_num").change(function(e){
		if($("#product_num").val() > ${productVO.product_remaining}){ //數字以外未篩
			window.alert('請勿超過庫存數量');
			$("#product_num").val(${productVO.product_remaining});
			let point = (Math.floor(${productVO.product_price}/100))*$("#product_num").val();
			$("#point").attr('value', point);
			$("#showOrder_point").text(point);
		}else {
			let point = (Math.floor(${productVO.product_price}/100))*$("#product_num").val();
			$("#point").attr('value', point);
			$("#showOrder_point").text(point);
		}
		
	})
	$(".remove").click(function(e){
		if($("#product_num").val()>0){
			$("#product_num").val(parseInt($("#product_num").val())-1);
			let point = (Math.floor(${productVO.product_price}/100))*$("#product_num").val();
			$("#point").attr('value', point);
			$("#showOrder_point").text(point);
		}
	})
	$(".add").click(function(e){
		if($("#product_num").val()<${productVO.product_remaining}){
			$("#product_num").val(parseInt($("#product_num").val())+1);
			let point = (Math.floor(${productVO.product_price}/100))*$("#product_num").val();
			$("#point").attr('value', point);
			$("#showOrder_point").text(point);
		}
	})
	
	$("#twzipcode").twzipcode({
		zipcodeIntoDistrict: true, // 郵遞區號自動顯示在區別選單中
		css: ["city form-control", "town form-control"], // 自訂 "城市"、"地別" class 名稱 
		countyName: "city", // 自訂城市 select 標籤的 name 值
		districtName: "town" // 自訂區別 select 標籤的 name 值
		})
	$("#user_id").change(function(e){
		<c:forEach var="userVO" items="${userSvc.all}">	
		if($("#user_id").val()=='${userVO.user_id}'){
			$("#showPoint").text(${userVO.user_point});
		}
		</c:forEach>
	});
		
</script>
</html>