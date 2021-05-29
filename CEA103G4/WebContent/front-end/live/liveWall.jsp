<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.live.model.*"%>
<%@ page import="com.product_type.model.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.user.model.*"%>
<%
	LiveJNDIDAO dao = new LiveJNDIDAO();
	Object lives = request.getAttribute("lives") == null ? dao.getAll2() : request.getAttribute("lives");
	pageContext.setAttribute("lives", lives);
%>
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
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
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
.nav-item .nav-menu {
margin-left: 85px;
}


</style>

</head>

<body>
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

					</div>
				</div>
				<div class="col-lg-3 text-right col-md-3">
					<c:if test="${not empty userVO.user_id}">
						<div class="header-right">
							<FORM id="userLogOut" METHOD="post" class="logout-form"
								action="<%=request.getContextPath()%>/User_LogoutHandler">
								<a
									href="<%=request.getContextPath()%>/front-end/protected/userIndex.jsp">
									<span class="userLogin" style="cursor: pointer"><img
										class="rounded-circle" width="45px" height="40px"
										src="${pageContext.request.contextPath}/UserShowPhoto?user_id=${userVO.user_id}" />&nbsp;
										${userVO.user_name} </span>
								</a> <input type="hidden" name="action" value="signOut"> <a
									href="#"
									onclick="document.getElementById('userLogOut').submit();"><button
										type="button" class="btn">登出</button></a>
							</FORM>
						</div>
    				</c:if>
       			 <c:if test="${empty userVO.user_id}">
					<div class="header-right">
						<a
							href="<%=request.getContextPath()%>/front-end/user/register.jsp"><button
								type="button" class="btn">註冊</button></a> <a
							href="<%=request.getContextPath()%>/front-end/userLogin.jsp" ><button
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
		<img style="height:75px;" src="<%=request.getContextPath()%>/front-template/images/top.gif" title="回上方">
	</div>
	
<c:if test="${not empty userVO.user_id}">	
	<div id="chatBtn">
		<!-- <div class="chat-notice">1</div> -->
		<div class="chat-btn">
			私訊&nbsp;<i class="fa fa-commenting-o"></i>
		</div>
	</div>

	<div class="mini-chat">
		<div class="content">
			<div class="top-bar">
				<i class="ti-angle-left" onclick="listFriend();"></i>
				<div id="statusOutput"></div>
				<div class="cancel">
					<i class="fa fa-close" style="font-size:20px;"></i>
				</div>
			</div>
		<div class="middle" id="messagesArea" style="height: 240px"></div>
			<div class="bottom-bar">
				<div class="chat">
					<input id="message" class="chat-input" type="text"
						placeholder="Type a message..." size="21"
						onkeydown="if (event.keyCode == 13) sendMessage();"> <i
						id="sendMessage" class="fa fa-paper-plane"
						onclick="sendMessage();"></i>
				</div>
			</div>
		</div>
	</div>
	
	<div class="friendlist" id="friendlist">
		<div class="content">
			<div class="top-bar">
				<div class="list">聊天室</div>
				<div class="cancel">
				<i class="fa fa-close" onclick="closefriendlist();" style="font-size:20px;"></i>
				</div>
			</div>
			<div class="friendArea" id="friendArea">
			</div>
		</div>
	</div>
	
</c:if>

</header>
<!-- Header End -->
<!-- heade搜尋 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.7/dist/sweetalert2.all.min.js"></script>
<script>


const goTop = document.querySelector("#goTop");
goTop.addEventListener("click", function() {
	$("html,body").animate({scrollTop:0},1000);
});



	const closelist = document.querySelector(".friendlist");
	const openlist = document.querySelector(".friendlist");
	const chatBtn = document.querySelector(".chat-btn");
	const miniChat = document.querySelector(".mini-chat");
	const closeChatBtn = document.querySelector(".fa.fa-close");
	
	function closefriendlist(){
		closelist.style.visibility="hidden";
		miniChat.style.visibility="hidden";
	}
	function listFriend(){
		disconnect();
		connect();
		openlist.style.visibility="visible";
		
	}

	chatBtn.addEventListener("click", function() {
		 miniChat.style.visibility = "visible";
		 listFriend();
		 addListener();
	});
	closeChatBtn.addEventListener("click", function() {
		 closefriendlist();
	     miniChat.style.visibility = "hidden";
	});
	//WebSocket開始
	var MyPoint = "/FriendChatWS/${userVO.user_id}";
	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
	                
	const statusOutput = document.getElementById("statusOutput");
	const messagesArea = document.getElementById("messagesArea");
	var self = '${userVO.user_id}';
	
	var webSocket;
        connect(); //websocket直接啟動
        function connect() {
            // create a websocket
            webSocket = new WebSocket(endPointURL);
            webSocket.onopen = function(event) {
                console.log("Connect Success!");
            };
			// OnMessaage
            webSocket.onmessage = function(event) {
                var jsonObj = JSON.parse(event.data);

                if ("open" === jsonObj.type) {
                    refreshFriendList(jsonObj);
                } else if ("history" === jsonObj.type) {
					messagesArea.innerHTML = "";
                    var ul = document.createElement('ul');
                    ul.id = "area";
                    messagesArea.appendChild(ul);
                    // 這行的jsonObj.message是從redis撈出跟好友的歷史訊息，再parse成JSON格式處理
                    var messages = JSON.parse(jsonObj.message);
                    for (var i = 0; i < messages.length; i++) {
                        var historyData = JSON.parse(messages[i]);
                        var showMsg = historyData.message;
                        var li = document.createElement('li');
                        // 根據發送者是自己還是對方來給予不同的class名, 以達到訊息左右區分
                        historyData.sender === self ? li.className += 'me' : li.className += 'friend';
                        li.innerHTML = showMsg;
                        ul.appendChild(li);
                    }
                    messagesArea.scrollTop = messagesArea.scrollHeight;
                } else if ("chat" === jsonObj.type) {
                    var li = document.createElement('li');
					if(jsonObj.sender === statusOutput.textContent || jsonObj.sender ===self){ //完善版本 不會看到別人訊息
                    jsonObj.sender === self ? li.className += 'me' : li.className += 'friend'; 
					}
					li.innerHTML = jsonObj.message;
                    document.getElementById("area").appendChild(li);
                    messagesArea.scrollTop = messagesArea.scrollHeight;
                } else if ("close" === jsonObj.type) {
                    refreshFriendList(jsonObj);
                }

            };
			//OnClose
            webSocket.onclose = function(event) {
                console.log("Disconnected!");
            };
        }
		
        function sendMessage() {
            var inputMessage = document.getElementById("message");
            var friend = statusOutput.textContent;
            var message = inputMessage.value.trim();
            if (message === "") {
				Swal.fire({
			  		icon: 'error',
			 		 title: '請輸入訊息',
			 		 showConfirmButton: false,
			 		 timer: 1000
				});
                inputMessage.focus();
            } else {
                var jsonObj = {
                    "type" : "chat",
                    "sender" : self,
                    "receiver" : friend,
                    "message" : message
                };
                webSocket.send(JSON.stringify(jsonObj));
                inputMessage.value = "";
                inputMessage.focus();
            }
        }
        // 有好友上線或離線就更新列表
         function refreshFriendList(jsonObj) {
            var friends = jsonObj.users;
			console.log("this is user "+jsonObj.user);
			
			if(self == jsonObj.user){
				var friendArea = document.getElementById("friendArea");
	            friendArea.innerHTML = '';
				if(friends != ""){
		            for (var i = 0; i < friends.length; i++) {
		                if (friends[i] === self) { continue; }
		                friendArea.innerHTML +='<div id=' + friends[i] + ' class="column" name="friendName" value=' + friends[i] + '><img class="rounded-circle" width="45px" height="40px" src="${pageContext.request.contextPath}/UserShowPhoto?user_id='+friends[i]+'" /><h2>' + friends[i] + '</h2></div>';
						}
				}else{
					friendArea.innerHTML +='<h3>請選擇聊天對象<h3>'
				}
			}else if(jsonObj.type == 'open'){
				var onlineUser = jsonObj.user
				console.log("onlineUser: "+onlineUser);
				document.getElementById(onlineUser).style.border= "2px solid lightgreen";
			}else if(jsonObj.type == 'close'){
				var offlineUser = jsonObj.user
				console.log("offlineUser: "+offlineUser);
				document.getElementById(offlineUser).style.border= "2px solid pink";
			}
//             addListener(); //註解掉好像沒差
        } 
        // 註冊列表點擊事件並抓取好友名字以取得歷史訊息
       function addListener(friend) {
			var container = document.getElementById("friendArea");
			container.addEventListener("click",function(e){
			closefriendlist();
			miniChat.style.visibility = "visible";
			var friend = e.srcElement.textContent;
             updateFriendName(friend);
            var jsonObj = {
                "type" : "history",
                "sender" : self,
                "receiver" : friend,
                "message" : ""
            };
            webSocket.send(JSON.stringify(jsonObj));
			})
        }
		function addListener2(friend) { //給私訊賣家用
		             updateFriendName(friend);
		            var jsonObj = {
		                "type" : "history",
		                "sender" : self,
		                "receiver" : friend,
		                "message" : ""
		            };
					webSocket.send(JSON.stringify(jsonObj));
					
					var jsonObj = {
				                    "type" : "chat",
				                    "sender" : self,
				                    "receiver" : friend,
				                    "message" : '<img class="product-big-img" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}" alt="${productVO.product_name}" />'
				                };
					webSocket.send(JSON.stringify(jsonObj));
		
					var jsonObj = {
				                    "type" : "chat",
				                    "sender" : self,
				                    "receiver" : friend,
				                    "message" : "${productVO.product_name}"
				                };
					 webSocket.send(JSON.stringify(jsonObj));
					
					
					
        }
        function disconnect() {
            webSocket.close();
        };

        function updateFriendName(name) {
            statusOutput.innerHTML = name;
        };

	
</script>

	<!-- Breadcrumb Section Begin -->
	<div class="breacrumb-section">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb-text">
						<a href="${pageContext.request.contextPath}/front-end/index.jsp"><i
							class="fa fa-home"></i> 首頁</a> <span>直播牆</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Breadcrumb Section Begin -->
<body>

	<!-- Product Shop Section Begin -->
	<section class="product-shop spad">
		<div class="container">
			<div class="row">
				<div class="product-list">
					<div class="row" id="products">
						<c:forEach var="liveVO" items="${lives}" begin="0"
							end="${lives.size()}">
							<c:if test="${liveVO.live_state==2}">
								<div class="col-lg-3 col-md-4 col-sm-6">
									<div class="card mb-2 productcard">
										<div class="product-item">
											<div class="pi-pic">
												<div class="pi-img">
													<a
														href="<%=request.getContextPath()%>/live/live.do?live_no=${liveVO.live_no}">
														<img class="card-img-top"
														src="${pageContext.request.contextPath}/live/LiveGifReader.do?live_no=${liveVO.live_no}"
														alt="${liveVO.live_name}">
													</a>
												</div>
											</div>
											<div class="pi-text">
												<a
													href="<%=request.getContextPath()%>/live/live.do?live_no=${liveVO.live_no}">
													<h5>${liveVO.live_name}</h5>
													<div class="product-price">
														<span></span> ${(liveVO.live_state==0)? '直播結束':''}
														${(liveVO.live_state==1)? '未直播':''}
														${(liveVO.live_state==2)? '直播中':''} <br> <span>-${liveVO.live_type}-</span>
													</div>
													<div>
														<fmt:formatDate value="${liveVO.live_time}"
															pattern="yyyy-MM-dd HH:mm:ss" />
													</div>

												</a>

											</div>

										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
</div>
</section>
<!-- Product Shop Section End -->








</body>


<!-- Footer Section Begin -->
<%@include file="/front-end/footer.jsp"%>
<!-- Footer Section End -->



<!-- Js Plugins -->


<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous">
	
</script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"
	integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ"
	crossorigin="anonymous">
	
</script>


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
</html>