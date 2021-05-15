<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.live.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  LiveVO liveVO = (LiveVO) request.getAttribute("liveVO"); //LiveServlet.java(Concroller), 存入req的liveVO物件
%>

<html>
<head>
<title>員工資料 - listOneLive.jsp</title>

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
	width: 600px;
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

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>員工資料 - ListOneLive.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front-end/live/select_page.jsp"><img src="${pageContext.request.contextPath}/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>直播編號</th>
		<th>直播分類</th>
		<th>直播名稱</th>
		<th>直播日期</th>
		<th>直播狀態</th>
		<th>直播使用者ID</th>
		<th>empno</th>
		<th>直播預覽圖</th>
	</tr>
	<tr>
		<td><%=liveVO.getLive_no()%></td>
		<td><%=liveVO.getLive_type()%></td>
		<td><%=liveVO.getLive_name()%></td>
		<td><%=liveVO.getLive_time()%></td>
		<td><%=liveVO.getLive_state()%></td>
		<td><%=liveVO.getUser_id()%></td>
		<td><%=liveVO.getEmpno()%></td>
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
</table>

</body>
</html>