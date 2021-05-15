<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ad.model.*"%>

<%
	AdVO adVO = (AdVO) request.getAttribute("adVO");
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>廣告資料新增 - addAd.jsp</title>

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
				<h3>廣告新增 - addAd.jsp</h3>
			</td>
			<td>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/ad/select_page.jsp"><img src="${pageContext.request.contextPath}/images/tomcat.png"
						width="100" height="100" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>廣告新增:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/ad/ad.do" name="form1" enctype = "multipart/form-data">
		<table>
		
			<tr>
				<td>員工編號:</td>
				<td><input type="TEXT" name="empno" size="45"
					value="<%= (adVO==null)? "14001" : adVO.getEmpno()%>" /></td>
			</tr>

			<tr>
				<td>廣告內容:</td>
				<td><input type="TEXT" name="ad_content" size="45"
					value="<%= (adVO==null)? "滿500全店免運費" : adVO.getAd_content()%>" /></td>
			</tr>
			
			<tr>
				<td>廣告圖片上傳:</td>
				<td><input type="file" name="ad_photo" onchange="PreviewImage(this)"/></td>
			</tr>
			<tr>
			     <td><div id="imgPreview" style="width:133px; height:100px;overflow:hidden;"></div></td>
			</tr>		
			<tr>
				<td>廣告狀態:</td>
				<td><select name="ad_state">
						<option value="0">待上架</option>
						<option value="1">已上架</option>
				</select></td>
			</tr>
			
			<tr>
				<td>開始日期:</td>
				<td><input type="TEXT" name="ad_start_date" size="45"
					value="<%= (adVO==null)? "2021-04-20" : adVO.getAd_start_date()%>" /></td>
			</tr>
			
			<tr>
				<td>結束日期:</td>
				<td><input type="TEXT" name="ad_end_date" size="45"
					value="<%= (adVO==null)? "2021-04-25" : adVO.getAd_end_date()%>" /></td>
			</tr>
			
			<tr>
				<td>賣場網址:</td>
				<td><input type="TEXT" name="ad_url" size="45"
					value="<%= (adVO==null)? "https://img.vitomag.com/fb/06/fb0685863e72300fdfdf7996e7602567.jpg" : adVO.getAd_url()%>" /></td>
			</tr>

		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>
<script type="text/javascript">
  function PreviewImage(imgFile) {
	var pattern = /(\.*.jpg$)|(\.*.png$)|(\.*.jpeg$)|(\.*.gif$)|(\.*.bmp$)/;
	if (!pattern.test(imgFile.value)) {
		alert("只支援jpg/jpeg/png/gif/bmp之格式檔案");
		imgFile.focus();
	} else {
		var path;
		if (document.all) { // IE
			imgFile.select();
			imgFile.blur();
			path = document.selection.createRange().text;
			document.getElementById("imgPreview").style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled='true',sizingMethod='scale',src=\""+ path + "\")";// 濾鏡
		} else { // FF 或 Chrome 等
			path = URL.createObjectURL(imgFile.files[0]);
			document.getElementById("imgPreview").innerHTML = "<img src='"+ path +"'  width='143' height='100'/>";
		}
	}
   }
</script>
</body>

</html>