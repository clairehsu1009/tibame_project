<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.live_report.model.*"%>

<%
	Live_reportVO live_reportVO = (Live_reportVO) request.getAttribute("live_reportVO");
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>直播檢舉資料新增 - addLive_report.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>

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
				<h3>直播檢舉新增 - addLive_report.jsp</h3>
			</td>
			<td>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/live_report/select_page.jsp"><img src="${pageContext.request.contextPath}/images/tomcat.png"
						width="100" height="100" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>直播檢舉新增:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live_report/live_report.do" name="form1" enctype = "multipart/form-data">
		<table>
			
			<tr>
				<td>直播檢舉內容:</td>
				<td><input type="TEXT" name="live_report_content" size="45"
					value="" /></td>
			</tr>

			<jsp:useBean id="liveSvc" scope="page" class="com.live.model.LiveService" />
			<tr>
				<td>直播編號:<font color=red><b>*</b></font></td>
				<td><select size="1" name="live_no">
					<c:forEach var="liveVO" items="${liveSvc.all}">
						<option value="${liveVO.live_no}" ${(live_reportVO.live_no==liveVO.live_no)? 'selected':'' } >${liveVO.live_no}
					</c:forEach>
				</select></td>
			</tr>

			<jsp:useBean id="userSvc" scope="page" class="com.user.model.UserService" />
			<tr>
				<td>檢舉者帳號:<font color=red><b>*</b></font></td>
				<td><select size="1" name="user_id">
					<c:forEach var="userVO" items="${userSvc.all}">
						<option value="${userVO.user_id}" ${(live_reportVO.user_id==userVO.user_id)? 'selected':'' } >${userVO.user_id}
					</c:forEach>
				</select></td>
			</tr>
			
			<jsp:useBean id="empSvc" scope="page" class="com.emp.model.EmpService" />
			<tr>
				<td>管理員編號:<font color=red><b>*</b></font></td>
				<td><select size="1" name="empno">
					<c:forEach var="empVO" items="${empSvc.all}">
						<option value="${empVO.empno}" ${(liveVO.empno==empVO.empno)? 'selected':'' } >${empVO.empno}
					</c:forEach>
				</select></td>
			</tr>

			<tr>
				<td>檢舉處理狀態:</td>
				<td><select name="live_report_state">
						<option value="0">未處理</option>
						<option value="1">審核處理</option>
						<option value="2">審核不通過</option>
				</select></td>
			</tr>

			<tr>
				<td>圖片上傳:</td>
				<td><input name="photo" type="file" id="imgInp" accept="image/gif, image/jpeg, image/png" / ></td>
				
			</tr>
			
			<tr>
				<td>圖片預覽:</td>
			    <td>
			    <img id="preview_img" src="#" style="display: none;" />
			    </td>
			</tr>

		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>
</body>

<script>
function readURL(input){
	  if(input.files && input.files[0]){
	    var reader = new FileReader();
	    reader.onload = function (e) {
	       $("#preview_img").attr('src', e.target.result);
	       $("#preview_img").attr('width', "250px");
	       $("#preview_img").attr('style', "display:block");
	    }
	    reader.readAsDataURL(input.files[0]);
	  }
	}
$("#imgInp").change(function() {
	  readURL(this);
	});
</script>

</html>