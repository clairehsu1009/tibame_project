<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.emp.model.*"%>
<%@ page import="com.user.model.*"%>


<!DOCTYPE html>
<html lang="zh-tw">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>客服聊天室</title>
<link rel="icon"
	href="${pageContext.request.contextPath}/front-template/images/favicon.ico"
	type="image/x-icon">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Main CSS-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/back-template/docs/css/main.css">
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- <link rel="stylesheet" -->
<%-- 	href="<%=request.getContextPath()%>/back-end/customer_service/css/friendchat.css" --%>
<!-- 	type="text/css" /> -->

<style type="text/css">
.panel {
	float: right;
	border: 5px solid rgb(0 0 0/ 15%);
	border-radius: 5px;
	width: 50%;
}

.panel1 {
	border: 5px solid rgb(0 0 0/ 15%);
	border-radius: 5px;
	width: 50%;
}

.message-area {
	height: 350px;
	resize: none;
	box-sizing: border-box;
	overflow: auto;
	background-color: #ffffff;
	width: 76%;
}

.input-area {
	background: #007d71;
	/* 	box-shadow: inset#007d71px #00568c; */
	min-width: 60%;
	width: 76%;
}

.input-area input {
	margin: 0.5em 0em 0.5em 0.5em;
}

.text-field {
	border: 1px solid grey;
	padding: 0.2em;
	box-shadow: 0 0 5px #000000;
}

.button {
	/* 	background: yellow; */
	
}

h1 {
	font-size: 1.5em;
	padding: 5px;
	margin: 5px;
}

#message {
	min-width: 62%;
	max-width: 60%;
}

.statusOutput {
	background: #007d71;
	text-align: center;
	color: #ffffff;
	border: 1px solid grey;
	padding: 0.2em;
	box-shadow: 0 0 5px #000000;
	width: 30%;
	margin-top: 1%;
	margin-left: 45%;
	height: 45px;
}

#row {
	float: left;
	width: 24%;
	height: 70%;
	/* 	background-color:lightblue; */
}

.column {
	/*   float: initial; */
	width: 100%;
	padding: 5%;
	margin-bottom: 5px;
	background-color: #ffffff;
}

button.btn.btn-outline-info {
	margin-top: 5px;
	margin-left: 5px;
}

#area {
	list-style: none;
	margin: 0;
	padding: 0;
}

#lis {
	display: inline;
	clear: both;
	padding: 20px;
	border-radius: 30px;
	margin-bottom: 2px;
	font-family: Segoe UI, Microsoft JhengHei, sans-serif;
	font-size: large;
}

#time {
	width: 100%;
	float: right;
	color: black;
	text-align: right;
	font-family: Segoe UI, Microsoft JhengHei, sans-serif;
	font-size: large;
}

#friendtime {
	width: 100%;
	float: left;
	color: black;
}

.friendName {
	font-family: Segoe UI, Microsoft JhengHei, sans-serif;
	font-size: large;
}

.friend {
	background: #eee;
	float: left;
}

.me {
	float: right;
	background: #007d71;
	color: #fff;
}

.friend+.me {
	border-bottom-right-radius: 5px;
}

.me+.me {
	border-top-right-radius: 5px;
	border-bottom-right-radius: 5px;
}

.me:last-of-type {
	border-bottom-right-radius: 30px;
}

.mem-block {
	border: 1px solid rgb(0 0 0/ 15%);
}
</style>
<title>Made Femme 客服聊天室</title>
</head>
<body class="app sidebar-mini rtl  pace-done" onload="connect();"
	onunload="disconnect(); ">
	<jsp:include page="/back-end/backendMenu.jsp" />
	<main class="app-content">
		<div class="app-title">
			<div>
				<h1>
					<i class="fa fa-group"></i> 客服訊息
				</h1>
			</div>

			<ul class="app-breadcrumb breadcrumb">
				<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
				<li class="breadcrumb-item"><a
					href="<%=request.getContextPath()%>/back-end/backendIndex.jsp">回到首頁</a></li>
			</ul>
		</div>

		<!-- 	<div id="showbox"> -->

		<!-- 	</div> -->
		<h3 id="statusOutput" class="statusOutput"></h3>
		<div id="row"></div>

		<div id="messagesArea" class="panel message-area"></div>
		<div class="panel input-area">

			<input id="message"
				class="text-field app sidebar-mini rtl  pace-done" type="text"
				placeholder="Message"
				onkeydown="if (event.keyCode == 13) sendMessage();" /> <input
				type="submit" id="sendMessage" class="btn btn-secondary"
				value="Send" onclick="sendMessage();" /> <input type="button"
				id="connect" class="btn btn-info" value="Connect"
				onclick="connect();" /> <input type="button" id="disconnect"
				class="btn btn-danger" value="Disconnect" onclick="disconnect();" />
			<!-- 					<input type="button" onclick="history.back()" value="回到上一頁"></input> -->
		</div>
	</main>
	<jsp:include page="/back-end/backendfooter.jsp" />
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
				var MyPoint = "/CustomerWS/${empName}";
				var host = window.location.host;
				var path = window.location.pathname;
				var webCtx = path.substring(0, path.indexOf('/', 1));
				var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;

				var statusOutput = document.getElementById("statusOutput");
				var messagesArea = document.getElementById("messagesArea");
				var self = '${empName}';
				var webSocket;

				function connect() {
		// create a websocket
		webSocket = new WebSocket(endPointURL);

		webSocket.onopen = function(event) {
			console.log("Connect Success!");
			document.getElementById('sendMessage').disabled = false;
			document.getElementById('connect').disabled = true;
			document.getElementById('disconnect').disabled = false;
		};

		webSocket.onmessage = function(event) {
			var jsonObj = JSON.parse(event.data);
			if("onMem"===jsonObj.type){
				refreshFriendList(jsonObj);
			}
			if("memAvailable"===jsonObj.type){
				refreshFriendList(jsonObj);
			}
// 			else if("empNotAvailable"===jsonObj.type){
// 				messagesArea.innerHTML = '';
// 				var ul = document.createElement('ul');
// 				ul.id = "area";
// 				messagesArea.appendChild(ul);
// 				var li = document.createElement('li');
// 				li.id = "lis";
// 				li.className = 'me'
// 				li.innerHTML = "目前客服不在線";
// 				ul.appendChild(li);
// 			}
			else if ("history" === jsonObj.type) {

				messagesArea.innerHTML = '';
				var ul = document.createElement('ul');
				ul.id = "area";
				messagesArea.appendChild(ul);
				// 這行的jsonObj.message是從redis撈出跟好友的歷史訊息，再parse成JSON格式處理
				var messages = JSON.parse(jsonObj.message);
				for (var i = 0; i < messages.length; i++) {
					var historyData = JSON.parse(messages[i]);
					var showMsg = historyData.message;
					
					var li = document.createElement('li');
					li.id = "lis";
					var span = document.createElement('span');

					// 根據發送者是自己還是對方來給予不同的class名, 以達到訊息左右區分
					historyData.sender === self ? li.className = 'me' : li.className = 'friend' ;
					historyData.sender === self ? span.id = 'time' : span.id = 'friendtime' ;
					li.innerHTML = showMsg;
					$(span).text(historyData.time);
					ul.appendChild(li);
					ul.appendChild(span);
				}
				messagesArea.scrollTop = messagesArea.scrollHeight;
			} else if ("chat" === jsonObj.type) {
				var li = document.createElement('li');
				li.id = "lis";
				var span = document.createElement('span');

				jsonObj.sender === self ? li.className = 'me' : li.className = 'friend';
				jsonObj.sender === self ? span.id = 'time' : span.id = 'friendtime';
				li.innerHTML = jsonObj.message;
				span.innerHTML = jsonObj.time;
				document.getElementById("area").appendChild(li);
				document.getElementById("area").appendChild(span);
				messagesArea.scrollTop = messagesArea.scrollHeight;
			} else if ("close" === jsonObj.type) {
				refreshFriendList(jsonObj);

			}
			
		};

		webSocket.onclose = function(event) {
			console.log("Disconnected!");
// 			var friends = jsonObj.users;
// 			console.log(friends);
// 			var chatArea = document.getElementsByClassName("friendName");
// 			console.log(chatArea);
// 			chatArea.remove();
		};
	}
	
	function sendMessage() {
		var inputMessage = document.getElementById("message");
		var friend = statusOutput.textContent;
		var message = inputMessage.value.trim();
		var time = new Date();
		var timeStr = time.getFullYear() + "-" + (time.getMonth()+1).toString().padStart(2, "0") + "-" 
		+ time.getDate() + " " + time.getHours().toString().padStart(2, "0") + ":" + time.getMinutes().toString().padStart(2, "0");
		if (message === "") {
// 			alert("Input a message");
			Swal.fire({
  			icon: 'error',
			//   title: 'Oops...',
			timer : 1500,
  			text: '請輸入訊息'
			//   footer: '<a href>Why do I have this issue?</a>',
		  
			});
			inputMessage.focus();
		} 
		else if (friend === "") {
// 			alert("Choose a friend");
			Swal.fire({
				  icon: 'warning',
				  timer : 1500,
				  text: '請選擇會員'
						  
				});
			inputMessage.focus();
		} 
		else {
			var jsonObj = {
				"type" : "chat",
				"sender" : self,
				"receiver" : friend,
				"message" : message,
				"time":timeStr
			};
			webSocket.send(JSON.stringify(jsonObj));
			inputMessage.value = "";
			inputMessage.focus();
		}
	}
	
	// 有好友上線或離線就更新列表
	function refreshFriendList(jsonObj) {
		var friends = jsonObj.users;
		console.log(jsonObj);
		var row = document.getElementById("row");
		
		for (var i = 0; i < friends.length; i++) {
			if (friends[i] === self) { continue; }//從所有好友列表排除自己的帳號
			row.innerHTML +='<div id=' + i + ' class="column" name="friendName" value=' + friends[i] + ' > <img class="rounded-circle" width="50px" height="50px"  src="${pageContext.request.contextPath}/UserShowPhoto?user_id='+friends[i]+'" /> <button class="btn btn-outline-info">' + friends[i] + '</button></div>';
		}
		addListener();
	}
	// 註冊列表點擊事件並抓取好友名字以取得歷史訊息
	function addListener() {
		var container = document.getElementById("row");
		container.addEventListener("click", function(e) {

			var friend = e.srcElement.textContent;
			console.log(friend)
			updateFriendName(friend);
			var jsonObj = {
				"type" : "history",
				"sender" : self,
				"receiver" : friend,
				"message" : "",
				"time":""
			};
			console.log(jsonObj);
			webSocket.send(JSON.stringify(jsonObj));
		});
	}
	
	function disconnect() {
		webSocket.close();
		document.getElementById('sendMessage').disabled = true;
		document.getElementById('connect').disabled = false;
		document.getElementById('disconnect').disabled = true;
	}
	
	function updateFriendName(name) {
		statusOutput.innerHTML = name;
	}
	
// 	function ShowTime(){
// 		　var NowDate=new Date();
// 		　var h=NowDate.getHours();
// 		　var m=NowDate.getMinutes();
// 		　var s=NowDate.getSeconds();　
// 		　document.getElementById('showbox').innerHTML = h+'時'+m+'分'+s+'秒';
// 		　setTimeout('ShowTime()',1000);
// 	}
</script>



</html>