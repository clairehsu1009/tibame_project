<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ad.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    AdService adSvc = new AdService();
    List<AdVO> list = adSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有廣告資料 - listAllAd.jsp</title>

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
		 <h3>所有廣告資料 - listAllAd.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/ad/select_page.jsp"><img src="${pageContext.request.contextPath}/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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
		<th>廣告編號</th>
		<th>員工編號</th>
		<th>廣告內容</th>
		<th>廣告圖片</th>
		<th>開始日期</th>
		<th>結束日期</th>
		<th>賣場網址</th>
		<th>廣告狀態</th>
		<th>修改</th>
		<th>刪除</th>
		
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="adVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${adVO.ad_no}</td>
			<td>${adVO.empno}</td>
			<td>${adVO.ad_content}</td>
			<td><img width="100px" height="100px" src="${pageContext.request.contextPath}/AdShowPhoto?ad_no=${adVO.ad_no}"></td>
			<td><fmt:formatDate value="${adVO.ad_start_date}" pattern="yyyy-MM-dd"/></td>
			<td><fmt:formatDate value="${adVO.ad_end_date}" pattern="yyyy-MM-dd"/></td>
			<td>${adVO.ad_url}</td> 
			<td>
			${(adVO.ad_state)==0? '待上架':''}
			${(adVO.ad_state)==1? '已上架':''}
			</td> 
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/ad/ad.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="ad_no"  value="${adVO.ad_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/ad/ad.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="ad_no"  value="${adVO.ad_no}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>