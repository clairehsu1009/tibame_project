<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.live.model.*"%>
<%@ page import="com.user.model.*"%>
<%@ page import="com.product_type.model.*"%>
<%@ page import="com.product.model.*"%>
<%

	Product_TypeDAO dao2 = new Product_TypeDAO();
     List<Product_TypeVO> list2 = dao2.getAll();
    pageContext.setAttribute("list2",list2);
    
    Vector<ProductVO> buylist = (Vector<ProductVO>) session.getAttribute("shoppingcart");
	pageContext.setAttribute("buylist", buylist);

	UserVO userVO2 = (UserVO) session.getAttribute("account"); 
	session.setAttribute("userVO", userVO2);
 %>


<jsp:useBean id="liveSvc" scope="page"
	class="com.live.model.LiveService" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>Modefemme</title>
<link rel="icon"
	href="${pageContext.request.contextPath}/front-template/images/favicon.ico"
	type="image/x-icon">

<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css?family=Muli:300,400,500,600,700,800,900&display=swap"
	rel="stylesheet" />

<!-- Css Styles -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/bootstrap.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/font-awesome.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/themify-icons.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/elegant-icons.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/owl.carousel.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/nice-select.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/jquery-ui.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/slicknav.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/front-template/css/style.css"
	type="text/css" />
<style>
#messagesArea {
	height: 500px;
	width: 100%;
	border: 1px solid #bbbbbb;
	overflow-y: scroll;
	display: inline-block;
	right: 30px;
}

#stream {
	height: 500px;
	width: 100%;
	padding: 5px;
	border: 1px solid #bbbbbb;
	display: inline-block;
}

#messagesArea>p {
	margin: 0;
	color: #bbbbbb;
	font-size: 1rem;
}

input {
	width: 100%;
	border: 1px solid #bbbbbb;
	border-top-width: 0;
	box-sizing: border-box;
	color: #bbbbbb;
	background-color: #222222;
	outline: none;
	font-family: Monospace;
	font-size: 1rem;
	right: 0px;
}

@media ( min-width : 768px) {
	.col-md-3 {
		padding: 0;
		max-width: 100%;
	}
	@media ( min-width : 768px) {
		.col-md-9 {
			padding: 0;
			max-width: 100%;
		}
	}
}
</style>
</head>

<body onload="connect();" onunload="disconnect();">

	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>
	<!-- Header Section Begin -->
	<header class="header-section">
		<div class="container">
			<div class="inner-header">
				<div class="row">
					<div class="col-lg-2 col-md-2">
						<div class="logo">
							<a href="${pageContext.request.contextPath}/front-end/index.jsp">
								<h2>
									Mode femme <br /> <small>Second&nbsp;Hand </small>
								</h2>
							</a>
						</div>
					</div>
					<div class="col-lg-7 col-md-7"></div>
					<div class="col-lg-3 text-right col-md-3">
						<c:if test="${ not empty userVO.user_name}">
							<div class="header-right">
								<FORM id="userLogOut" METHOD="post" class="logout-form"
									action="<%=request.getContextPath()%>/User_LogoutHandler">
									<a
										href="<%=request.getContextPath()%>/front-end/protected/userIndex.jsp">
										<span class="userLogin" style="cursor: pointer"><img
											class="rounded-circle" width="45px" height="40px" src="" />&nbsp;
											${userVO.user_name} </span>
									</a> <input type="hidden" name="action" value="signOut"> <a
										href="#"
										onclick="document.getElementById('userLogOut').submit();"><button
											type="button" class="btn">登出</button></a>
								</FORM>
							</div>
						</c:if>
						<c:if test="${empty userVO.user_name}">
							<div class="header-right">
								<a
									href="<%=request.getContextPath()%>/front-end/user/register.jsp"><button
										type="button" class="btn">註冊</button></a> <a
									href="<%=request.getContextPath()%>/front-end/protected/userIndex.jsp"><button
										type="button" class="btn">登入</button></a>
							</div>
						</c:if>
						<!-- 鈴鐺/購物車顯示的數字+購物車預覽圖要改 -->
					<ul class="nav-right">
						<li class="bell-icon"><a href="#"> <svg
									xmlns="http://www.w3.org/2000/svg" width="20" height="20"
									fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
                      <path
										d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z" />
                    </svg> <span>1</span>
						</a></li>
						<li class="cart-icon"><a
							href="${pageContext.request.contextPath}/front-end/productsell/shoppingCart.jsp">
								<i class="icon_bag_alt"></i>
								<c:if test="${buylist != null}">
								<span id="iba">${buylist.size()}</span>
								</c:if> 
								<c:if test="${buylist == null}"> 
								<span id="iba">0</span>
								</c:if>
						</a>
<%-- 						<c:if test="${buylist != null && buylist.size() > 0}"> --%>
							<div class="cart-hover">
								<div class="select-items">
									<table>  
										<tbody id="carts">
									<c:set var="sum" value="0"> </c:set>
									<c:forEach var="order" items="${buylist}" varStatus="cartstatus">
											<tr>
												<td class="si-pic"><img
													src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${order.product_no}"
													alt="${order.product_name}" style="width:100px; height:100px;" /></td>
												<td class="si-text">
													<div class="product-selected">
														<p>$${order.product_price } x ${order.product_quantity}</p>
														<h6>${order.product_name }</h6>
													</div>
												</td>
											</tr>
									<c:set var="sum" value="${sum + order.product_price*order.product_quantity}"></c:set>
                                   </c:forEach>
										</tbody>
									</table>
								</div>
								<div class="select-total">
									<span>total:</span>
									<h5>${sum}</h5>
								</div>
								<div class="select-button">
									<a
										href="${pageContext.request.contextPath}/front-end/productsell/shoppingCart.jsp"
										class="primary-btn view-card">購物車清單</a>
									<a
										href="${pageContext.request.contextPath}/front-end/protected/check-out.html"
										class="primary-btn checkout-btn">結帳</a>
								</div>
							</div>
<%-- 							</c:if> --%>
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
						<li><a href="#">線上客服&nbsp;<i class="fa fa-comment-o"></i></a></li>		
					</ul>
				</nav>
				<div id="mobile-menu-wrap"></div>
			</div>
		</div>

	</header>
	<!-- Header End -->
	<!-- Breadcrumb Section Begin -->
	<div class="breacrumb-section">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb-text live-more">
						<a href="${pageContext.request.contextPath}/front-end/index.jsp"><i
							class="fa fa-home"></i> 首頁</a> <a
							href="<%=request.getContextPath()%>/front-end/live/liveWall.jsp">直播</a>
						<span>直播室</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Breadcrumb Section Begin -->
<body>
	<div class="row">
		<div class="col-md-12">
			<h2>${liveVO.live_name}
				#<span class="badge badge-primary">${liveVO.live_type}</span>
			</h2>
			<h2>
				<span id="iflive"> ${(liveVO.live_state==2)? '直播中':''}
					${(liveVO.live_state==1)? '未直播':''} ${(liveVO.live_state==0)? '已結束':''}
				</span>
			</h2>
		</div>
		<script>
			
		</script>
	</div>
	<div class="row">
		<div class="col-md-9">
			<div id="player"></div>
		</div>

		<div class="col-md-3">
			<textarea id="messagesArea" class="form-control" readonly></textarea>
			<div class="input">
				<input id="userName" name="userName" value="" class="text-field" type="hidden"  /> 
				<input id="message" class="form-control" type="text" placeholder="Message"
					onkeydown="if (event.keyCode == 13) sendMessage(event);" />
			</div>
		</div>

	</div>


	<div class="row">
		<div class="col-xl-9">
			<div class="tile">
				<h3 class="tile-title">直播拍賣商品</h3>
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col">直播編號</th>
							<!-- 									<th scope="col">直播分類</th> -->
							<th scope="col">商品編號</th>
							<!-- 							<th scope="col">商品圖片</th> -->
							<th scope="col">商品名稱</th>
							<th scope="col">商品描述</th>
							<th scope="col">起標價</th>
							<th scope="col">數量</th>
							<th scope="col"></th>
							<!-- 								<th scope="col">賣家帳號</th> -->
						</tr>
					</thead>

					<tbody id="showProduct">


					</tbody>
				</table>
			</div>
		</div>


		<div class="col-xl-3">
			<br>現在最高價: <span id="current_price"></span>
			<br>現在出價人: <span id="current_id"></span>
			
		</div>

	</div>



</body>


<!-- Footer Section Begin -->
<%@include file="/front-end/footer.jsp"%>
<!-- Footer Section End -->



<!-- Js Plugins -->


<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous">
<!--
	
</script>
-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"
	integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ"
	crossorigin="anonymous">
<!--
	
</script>
-->


<script
	src="${pageContext.request.contextPath}/front-template/js/jquery-3.3.1.min.js"></script>
<script
	src="${pageContext.request.contextPath}/front-template/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/front-template/js/jquery-ui.min.js"></script>
<script
	src="${pageContext.request.contextPath}/front-template/js/jquery.countdown.min.js"></script>
<script
	src="${pageContext.request.contextPath}/front-template/js/jquery.nice-select.min.js"></script>
<script
	src="${pageContext.request.contextPath}/front-template/js/jquery.zoom.min.js"></script>
<script
	src="${pageContext.request.contextPath}/front-template/js/jquery.dd.min.js"></script>
<script
	src="${pageContext.request.contextPath}/front-template/js/jquery.slicknav.js"></script>
<script
	src="${pageContext.request.contextPath}/front-template/js/owl.carousel.min.js"></script>
<script
	src="${pageContext.request.contextPath}/front-template/js/main.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.7/dist/sweetalert2.all.min.js"></script>


<script>


refresh();

function refresh(){
	$.ajax({
		url:"<%=request.getContextPath()%>/product/product.do",
		type:'post',
		data:{
			action:"getGson",
		},
		
		success:function(str){
			
			for(let i of str){
				if(i.product_state == 2 && i.user_id == '${liveVO.user_id}' && i.live_no == ${liveVO.live_no}){
					let str = "<tr>";
					str+="<td>"+i.live_no+"</td>";
					str+="<td>"+i.product_no+"</td>";
// 					str+="<td>"+i.product_photo+"</td>";
					str+="<td>"+i.product_name+"</td>";
					str+="<td>"+i.product_info+"</td>";
					str+="<td>"+i.start_price+"</td>";
					str+="<td>"+i.product_remaining+"</td>";
					str+="</tr>";
					$("#showProduct").append(str);
				}
			}
		}
	})
}

// alert($("#showProduct").find("td").eq(1).html());

</script>
<script>
	let self = '${userVO.user_id}';
	var MyPoint = "/TogetherWS/${param.live_no}/"+self;
	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;

	var statusOutput = document.getElementById("statusOutput");
	var webSocket;

	function connect() {
		// create a websocket
		
		webSocket = new WebSocket(endPointURL);

		webSocket.onopen = function(event) {

// 			updateStatus("WebSocket Connected");
// 			document.getElementById('sendMessage').disabled = false;
// 			document.getElementById('connect').disabled = true;
// 			document.getElementById('disconnect').disabled = false;
		};

		webSocket.onmessage = function(event) {
			var messagesArea = document.getElementById("messagesArea");
			var jsonObj = JSON.parse(event.data);
			
			if ("open" === jsonObj.type) {
				addListener();
			}else if("history" === jsonObj.type){
				//進來的時候
				
				$("#current_price").text(JSON.parse(jsonObj.message).maxPrice);
				$("#current_id").text(JSON.parse(jsonObj.message).user_id);
				
			}else if("chat" === jsonObj.type && ${param.live_no} == jsonObj.live_no){

				
				//聊天//競標中
				if(/^\d*$/.test(jsonObj.message)){
					let maxObj = {//type要改  因為他對到MaxVO 但這樣取會混淆
							'type' : 'max',
							'sender' : jsonObj.sender,
							'live_no' : '${param.live_no}',
							'user_id' : jsonObj.sender,
							'maxPrice' : jsonObj.message,
							'product_no' : $("#showProduct").find("td").eq(1).html(),
							'timeStart': '1',//0:開始競標 1:競標中 2:結束競標
							'lastTime': ''
					};
					let json = {
							"type" : "getMax",
							"sender" : jsonObj.sender,
							"live_no" : '${param.live_no}',
							"product_no":  $("#showProduct").find("td").eq(1).html(),
							"message" : JSON.stringify(maxObj)
					};
					console.log('GGGGGG');
					console.log(json);
					webSocket.send(JSON.stringify(json));
					
				}else if("start"==jsonObj.message && '${liveVO.user_id}'==jsonObj.sender){//直播主才可以start
					//&& ${liveVO.user_id==userVO.user_id}
					//開始競標
					alert("開始競標#"+$("#showProduct").find("td").eq(1).html());
					
					
					let maxObj = {//type要改  因為他對到MaxVO 但這樣取會混淆
						//0給初始直
							'type' : 'max',
							'sender' : self,
							'live_no' : '${param.live_no}',
							'user_id' : '${userVO.user_id}',
							'maxPrice' : '0',//這之後可以存設定起標價
							'product_no' : $("#showProduct").find("td").eq(1).html(),
							'timeStart': '0',
							'lastTime': ''
					};
					//
					let json = {
							"type" : "getMax",
							"sender" : self,
							"live_no" : '${param.live_no}',
							"product_no":  $("#showProduct").find("td").eq(1).html(),
							"message" : JSON.stringify(maxObj)
					};
	
					webSocket.send(JSON.stringify(json));	
				
				
				}else if("over"==jsonObj.message && '${liveVO.user_id}'==jsonObj.sender){//直播主才可以end
					//&& ${liveVO.user_id==userVO.user_id}
					//結束競標
					alert("結束競標#"+$("#showProduct").find("td").eq(1).html());
					let maxObj = {//type要改  因為他對到MaxVO 但這樣取會混淆
							'type' : 'max',
							'sender' : self,
							'live_no' : '${param.live_no}',
							'user_id' : '${userVO.user_id}',
							'maxPrice' : '0',//不應該用到
							'product_no' : $("#showProduct").find("td").eq(1).html(),
							'timeStart': '2',
							'lastTime': ''
							//送這包裹過去  你應該在後台 判斷結束
							//傳回最終 最高價 回來的時候順便呼叫ajax存到mySQL
					};
					let json = {
							"type" : "getMax",
							"sender" : self,
							"live_no" : '${param.live_no}',
							"product_no":  $("#showProduct").find("td").eq(1).html(),
							"message" : JSON.stringify(maxObj)
					};
					
					webSocket.send(JSON.stringify(json));
				}
				
				var message = jsonObj.sender + ": " + jsonObj.message + "\r\n";
				messagesArea.value = messagesArea.value + message;
				messagesArea.scrollTop = messagesArea.scrollHeight;
			}else if("max" ==jsonObj.type){
				if(jsonObj.timeStart =="0"){
					$("#current_price").text(jsonObj.maxPrice);
					$("#current_id").text("無人出價");
				}else if(jsonObj.timeStart== "1"){
					addListener();
				}else if(jsonObj.timeStart== "2"){
					//ajax  更改狀態
					//refresh();
					//注意元素可以抓到
				if(jsonObj.sender == '${userVO.user_id}'){
					
					$.ajax({ 
						  type:"POST",
						  url:"<%=request.getContextPath()%>/live_order/live_order.do",
						 	 data:{
					  		  	 "user_id":$("#current_id").html(),
							 	 "bidPrice":$("#current_price").html(),
							 	 "live_no":'${liveVO.live_no}',
							 	 "seller_id":'${liveVO.user_id}',
							 	 "product_no":$("#showProduct").find("td").eq(1).html(),
								 "action": "order_ajax"
						  },
						  success: function(res) {
								alert("已產生訂單");
								refresh();
					      }, 	  
					
					 });
				}
					
				$("#showProduct").empty();

// 				setTimeout(function(){
// 					$("#showProduct").empty();
// 					refresh();
// 				}, 10);

				$("#current_price").text(jsonObj.maxPrice);
				$("#current_id").text("結束囉");

				
				}else if(jsonObj.timeStart== "3"){
					
				}
				//開始競標後包裹   alert()開始競標
				//競標中
				//競標結束
				
			}
			

		}
	

		webSocket.onclose = function(event) {
			console.log(event.data);
		 	connect();
			
		};
		
	}
	
	
	function addListener() {
	//進來的時候 取道最新競標價格	
		let jsonObj = {
				"type" : "history",
				"sender" : '',
				"live_no" : '${param.live_no}',
				"product_no":  $("#showProduct").find("td").eq(1).html(),
				"message" : ""
			};
		webSocket.send(JSON.stringify(jsonObj));
	}
	
	
	
	var inputUserName = document.getElementById("userName");
	inputUserName.focus();

	function sendMessage(e) {
		var userName = inputUserName.value.trim();
		if (${userVO == null}) {
// 			e.stopPropagation();
			setTimeout(function(){
				login();
			}, 1);
			return;
		}
		
		var inputMessage = document.getElementById("message");
		var message = inputMessage.value.trim();

		if (message === "") {
			alert("請輸入訊息");
			inputMessage.focus();
		} else {
			
			var jsonObj = {
				"type":'chat',
				"sender" : self,
				"live_no": '${param.live_no}',
				"product_no":  '',
				"message" : message
			};
			webSocket.send(JSON.stringify(jsonObj));
			inputMessage.value = "";
			inputMessage.focus();
		}
		
	}

	function disconnect() {
		webSocket.close();
// 		document.getElementById('sendMessage').disabled = true;
// 		document.getElementById('connect').disabled = false;
// 		document.getElementById('disconnect').disabled = true;
	}



  	function login(){

		Swal.fire({
  			title: '請先登入會員',
  			html:
    		"帳號"+'<input id="userID" class="swal2-input">' +
    		"密碼"+'<input id="PWD" class="swal2-input"  type="password">',
    		showCloseButton: true,
    		confirmButtonText: `登入`,
  }).then(function(result){
			if($("#userID").val().trim().length != 0 && $("#PWD").val().trim().length != 0){				
  			$.ajax({ 
	  			  url:"<%=request.getContextPath()%>/FrondEnd_LoginHandler",
	  			  type:"POST", 
	  			  data:{
	  				  "user_id":$("#userID").val(),
	  				  "user_pwd":$("#PWD").val(),
	  				  "action": "signIn_ajax"
	  			  },
	  			  success: function(result) {

	  				if (result.length === 0 || result === ""){
			  			Swal.fire({
				  			  icon: 'error',
				  			  title: '帳號或密碼有誤,請重新輸入',
				  			  showConfirmButton: false,
				  			  timer: 1500
				  			});
	  				} else {
	  					window.location.reload();
			  			Swal.fire({
				  			  icon: 'success',
				  			  title: '登入成功',
				  			  showConfirmButton: false,
				  			  timer: 1500
				  			});
	  				}
	  		            }, 	  
	  			  error:function () {
			  			Swal.fire({
				  			  icon: 'error',
				  			  title: '登入失敗,請重新登入',
				  			  showConfirmButton: false,
				  			  timer: 1500
				  			});
	  			  },
  			});
			} else {
				Swal.fire({
					 icon: 'error',
					 title: '帳號或密碼請勿空白',
					 showConfirmButton: false,
					 timer: 1500
			});
			}
			});
	  	};
</script>
<script>
	// 2. This code loads the IFrame Player API code asynchronously.
	var tag = document.createElement('script');

	tag.src = "https://www.youtube.com/iframe_api";
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

	// 3. This function creates an <iframe> (and YouTube player)
	//    after the API code downloads.
	var player;
	function onYouTubeIframeAPIReady() {
		player = new YT.Player('player', {
			height : "100%",
			width : '100%',
			videoId : "${liveVO.live_id}",
			playerVars : {
				'playsinline' : 1
			},
			events : {
				'onReady' : onPlayerReady,
				'onStateChange' : onPlayerStateChange
			}
		});
	}

	// 4. The API will call this function when the video player is ready.
	function onPlayerReady(event) {
		event.target.playVideo();
	}

	// 5. The API calls this function when the player's state changes.
	//    The function indicates that when playing a video (state=1),
	//    the player should play for six seconds and then stop.
	var done = false;
	function onPlayerStateChange(event) {
		if (event.data == YT.PlayerState.PLAYING && !done) {
			// 			setTimeout(stopVideo, 6000);
			done = true;
		}
	}
	function stopVideo() {
		player.stopVideo();
	}
	
  	
	
</script>



</html>