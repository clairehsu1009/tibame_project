<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM User: Home</title>

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
   <tr><td><h3>IBM User: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM User: Home</p>

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
  <li><a href='<%=request.getContextPath() %>/front-end/user/listAllUser.jsp'>List</a> all Users.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/user/user.do" >
        <b>輸入會員帳號 (如abcdXXX):</b>
        <input type="text" name="user_id">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="userSvc" scope="page" class="com.user.model.UserService" />
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/user/user.do" >
       <b>選擇會員帳號:</b>
       <select size="1" name="user_id">
         <c:forEach var="userVO" items="${userSvc.all}" > 
          <option value="${userVO.user_id}">${userVO.user_id}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front-end/user/user.do" >
       <b>選擇會員姓名:</b>
       <select size="1" name="user_id">
         <c:forEach var="userVO" items="${userSvc.all}" > 
          <option value="${userVO.user_id}">${userVO.user_name}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>會員管理</h3>

<ul>
  <li><a href='<%=request.getContextPath() %>/front-end/user/addUser.jsp'>Add</a> a new User.</li>
</ul>

</body>
</html>