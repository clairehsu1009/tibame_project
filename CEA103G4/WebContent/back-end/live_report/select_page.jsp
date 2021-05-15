<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Live_report: Home</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>IBM Live_report: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Live_report: Home</p>

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='<%=request.getContextPath()%>/back-end/live_report/listAllLive_report.jsp'>List</a> all Live_reports.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live_report/live_report.do" >
        <b>輸入直播檢舉編號 (如13001):</b>
        <input type="text" name="live_report_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="live_reportSvc" scope="page" class="com.live_report.model.Live_reportService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live_report/live_report.do" >
       <b>選擇直播檢舉編號:</b>
       <select size="1" name="live_report_no">
         <c:forEach var="live_reportVO" items="${live_reportSvc.all}" > 
          <option value="${live_reportVO.live_report_no}">${live_reportVO.live_report_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
</ul>


<h3>直播檢舉管理</h3>

<ul>
  <li><a href='addLive_report.jsp'>Add</a> a new Live_report.</li>
</ul>

</body>
</html>