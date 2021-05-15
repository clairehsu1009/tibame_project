<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.live.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	
	LiveService liveSvc = new LiveService();
	List<LiveVO> list = liveSvc.getAll();
	pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有直播資料- listAllLive.jsp</title>

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
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有直播資料- listAllLive.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/live/select_page.jsp"><img src="${pageContext.request.contextPath}/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>直播編號</th>
		<th>直播分類</th>
		<th>直播名稱</th>
		<th>直播時間</th>
		<th>直播狀態</th>
		<th>直播使用者ID</th>
		<th>EMPNO</th>
		<th>直播預覽圖</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="liveVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr>
			<td>${liveVO.live_no}</td>
			<td>${liveVO.live_type}</td>
			<td>${liveVO.live_name}</td>

			<td><fmt:formatDate value="${liveVO.live_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>

			<td>
			${(liveVO.live_state==0)? '直播結束':''}
			${(liveVO.live_state==1)? '未直播':''}
			${(liveVO.live_state==2)? '直播中':''}
			</td>
			<td>${liveVO.user_id}</td>
			<td>${liveVO.empno}</td>
			<td><img src="${pageContext.request.contextPath}/live/LiveGifReader.do?live_no=${liveVO.live_no}" width="250px"></td>
			
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live/live.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="live_no"  value="${liveVO.live_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live/live.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="live_no"  value="${liveVO.live_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

<%@ include file="page2.file" %>
</body>
</html>