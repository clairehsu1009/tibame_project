<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.live_report.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    Live_reportService live_reportSvc = new Live_reportService();
    List<Live_reportVO> list = live_reportSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有直播檢舉資料 - listAllLive_report.jsp</title>

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
		 <h3>所有直播檢舉資料 - listAllLive_report.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/live_report/select_page.jsp"><img src="${pageContext.request.contextPath}/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
		<th>直播檢舉編號</th>
		<th>直播檢舉內容</th>
		<th>直播編號</th>
		<th>檢舉者帳號</th>
		<th>員工編號</th>
		<th>檢舉處理狀態</th>
		<th>檢舉日期</th>
		<th>截圖</th>

	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="live_reportVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${live_reportVO.live_report_no}</td>

			<td>${live_reportVO.live_report_content}</td>
			<td>${live_reportVO.live_no}</td>
			<td>${live_reportVO.user_id}</td>
			<td>${live_reportVO.empno}</td> 
			<td>
			${(live_reportVO.live_report_state)==0? '未處理':''}
			${(live_reportVO.live_report_state)==1? '審核通過':''}
			${(live_reportVO.live_report_state)==2? '審核不通過':''}
			
			</td> 
			
			
			<td><fmt:formatDate value="${live_reportVO.report_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<td><img src="${pageContext.request.contextPath}/live_report/DBGifReader.do?live_report_no=${live_reportVO.live_report_no}" width="250px"></td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live_report/live_report.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="live_report_no"  value="${live_reportVO.live_report_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live_report/live_report.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="live_report_no"  value="${live_reportVO.live_report_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>