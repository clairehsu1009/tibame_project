<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Live: Home</title>

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
   <tr><td><h3>IBM Live: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Live: Home</p>

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
  <li><a href='<%=request.getContextPath()%>/front-end/live/listAllLive.jsp'>List</a> all Live_orders.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live/live.do" >
        <b>輸入直播編號 (如8001):</b>
        <input type="text" name="live_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="liveSvc" scope="page" class="com.live.model.LiveService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/live/live.do" >
       <b>選擇直播編號:</b>
       <select size="1" name="live_no">
         <c:forEach var="liveVO" items="${liveSvc.all}" > 
          <option value="${liveVO.live_no}">${liveVO.live_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
</ul>


<h3>直播管理</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/front-end/live/addLive.jsp'>Add</a> a new Live_order.</li>
</ul>

</body>


</html>