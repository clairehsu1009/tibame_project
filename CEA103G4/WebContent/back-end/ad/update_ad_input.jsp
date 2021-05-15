<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ad.model.*"%>

<%
	AdVO adVO = (AdVO) request.getAttribute("adVO"); //AdServlet.java (Concroller) 存入req的adVO物件 (包括幫忙取出的adVO, 也包括輸入資料錯誤時的adVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>廣告修改 - update_ad_input.jsp</title>

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
				<h3>廣告資料修改 - update_ad_input.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/ad/select_page.jsp"><img src="${pageContext.request.contextPath}/images/back1.gif"
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

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/ad/ad.do" name="form1" enctype="multipart/form-data">
		<table>
			<tr>
				<td>廣告編號:<font color=red><b>*</b></font></td>
				<td><%=adVO.getAd_no()%></td>
			</tr>
			<tr>
				<td>員工編號:</td>
				<td><input type="TEXT" name="empno" size="45"
					value="<%=adVO.getEmpno()%>" /></td>
			</tr>
			<tr>
				<td>廣告內容:</td>
				<td><input type="TEXT" name="ad_content" size="45"
					value="<%=adVO.getAd_content()%>" /></td>
			</tr>
			<tr>
				<td>廣告圖片:</td>
				<td>
				<input type="file" name="ad_photo" id="myFile" />
				<img width="100px" height="100px" id="oldimg" src="${pageContext.request.contextPath}/AdShowPhoto?ad_no=${adVO.ad_no}">
				<div id="preview"></div></td>
			</tr>			
			<tr>
				<td>廣告狀態:</td>
				<td><select name="ad_state">
						<option value="0" ${(adVO.ad_state==0)? 'selected':''}>待上架</option>
						<option value="1" ${(adVO.ad_state==1)? 'selected':''}>已上架</option>
				</select></td>
			</tr>
			<tr>
				<td>開始日期:</td>
				<td><input type="TEXT" name="ad_start_date" size="45"
					value="<%=adVO.getAd_start_date()%>" /></td>
			</tr>
			<tr>
				<td>結束日期:</td>
				<td><input type="TEXT" name="ad_end_date" size="45"
					value="<%=adVO.getAd_end_date()%>" /></td>
			</tr>
			<tr>
				<td>賣場網址:</td>
				<td><input type="TEXT" name="ad_url" size="45"
					value="<%=adVO.getAd_url()%>" /></td>
			</tr>
	
		</table>
		<br> <input type="hidden" name="action" value="update"> 
		<input type="hidden" name="ad_no" value="<%=adVO.getAd_no()%>">
			 <input type="submit" value="送出修改">
	</FORM>
	
<script>

let myFile = document.getElementById("myFile");
let preview = document.getElementById('preview');
let oldimg = document.getElementById('oldimg');

function init() {
    myFile.addEventListener('change', function(e) {
    	$("#preview").empty();
        let files = e.target.files;     
        if (files !== null) {          
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
                let reader = new FileReader();
                reader.addEventListener('load', function(e) { 
                    let result = e.target.result;
                    let img = document.createElement('img');
                    img.src = result;
                    preview.append(img);
                    oldimg.remove();
                });
                reader.readAsDataURL(file);
            } else {
            	alert('請上傳圖片！');
            }
        }
    });
}

window.onload = init;


</script>

    <script
      src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
      integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
      crossorigin="anonymous"
    ></script>
	
</body>


</html>