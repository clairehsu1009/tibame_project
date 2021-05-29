<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.live_report.model.*"%>

<%
	Live_reportVO live_reportVO = (Live_reportVO) request.getAttribute("live_reportVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>新增直播檢舉</title>
<link rel="icon" href="${pageContext.request.contextPath}/front-template/images/favicon.ico" type="image/x-icon">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
<!-- Main CSS-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/back-template/docs/css/main.css">
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<style>
td {
padding: 15px 20px 5px 0px;
}
.app-title {
margin: -30px -30px 0px;
}
</style>


</head>
<body bgcolor='white' class="app sidebar-mini rtl">
<jsp:include page="/back-end/backendMenu.jsp" />
<main class="app-content">
	<div class="app-title">
		<div>
			<h1>
				<i class="fa fa-th-list"></i> 新增直播檢舉
			</h1>
			
		</div>
		<ul class="app-breadcrumb breadcrumb">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item"><a
				href="<%=request.getContextPath()%>/back-end/backendIndex.jsp">回到首頁</a></li>
		</ul>
	</div>
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
				<td><input type="TEXT" class="form-control" name="live_report_content" size="45"
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
				<td><input name="photo" type="file" id="imgInp" accept="image/gif, image/jpeg, image/png" /></td>
				
			</tr>
			
			<tr>
				<td>圖片預覽:</td>
			    <td>
			    <img id="preview_img" src="#" style="display: none;" />
			    </td>
			</tr>

		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" class="btn btn-primary" value="送出新增">
	</FORM>
	</main>
	<jsp:include page="/back-end/backendfooter.jsp" />
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