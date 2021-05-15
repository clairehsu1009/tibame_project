<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Message: Home</title>

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
   <tr><td><h3>IBM Message: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Message: Home</p>

<h3>訊息查詢:</h3>
	
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
  <li><a href='listAllMessage.jsp'>List</a> all Messages.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="message.do" >
        <b>輸入訊息編號 (如2001):</b>
        <input type="text" name="message_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="messageSvc" scope="page" class="com.message.model.MessageService" />

  <li>
     <FORM METHOD="post" ACTION="message.do" >
       <b>選擇訊息編號:</b>
       <select size="1" name="message_no">
         <c:forEach var="messageVO" items="${messageSvc.all}" > 
          <option value="${messageVO.message_no}">${messageVO.message_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="message.do" >
       <b>選擇買家帳號:</b>
       <select size="1" name="message_no">
         <c:forEach var="messageVO" items="${messageSvc.all}" > 
          <option value="${messageVO.message_no}">${messageVO.user_id}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>訊息管理</h3>

<ul>
  <li><a href='addMessage.jsp'>Add</a> a new Message.</li>
</ul>

</body>
</html>