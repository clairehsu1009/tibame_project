<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Auth: Home</title>

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
   <tr><td><h3>IBM Auth: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Auth: Home</p>

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
<li><a href='<%=request.getContextPath()%>/back-end/auth/listAllAuth.jsp'>List</a> all Auth.  <br><br></li>
<!--   <li> -->
<%--     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/auth/auth.do" > --%>
<!--         <b>輸入員工編號 (如14001):</b> -->
<!--         <input type="text" name="empno"> -->
<!--         <input type="hidden" name="action" value="getOne_For_Display"> -->
<!--         <input type="submit" value="送出"> -->
<!--     </FORM> -->
<!--   </li> -->

  <jsp:useBean id="authSvc" scope="page" class="com.auth.model.AuthService" />
   
<!--   <li> -->
<%--      <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/auth/auth.do" > --%>
<!--        <b>選擇員工編號:</b> -->
<!--        <select size="1" name="empno"> -->
<%--          <c:forEach var="authVO" items="${authSvc.all}" >  --%>
<%--           <option value="${authVO.empno}">${authVO.empno} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
       
<!--        <input type="hidden" name="action" value="getOne_For_Display"> -->
<!--        <input type="submit" value="送出"> -->
<!--     </FORM> -->
<!--   </li> -->
  
<!--   <li> -->
<%--      <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/auth/auth.do" > --%>
<!--        <b>選擇功能編號:</b> -->
<!--        <select size="1" name="funno"> -->
<%--          <c:forEach var="authVO" items="${authSvc.all}" >  --%>
<%--           <option value="${authVO.funno}">${authVO.funno} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
       
<!--        <input type="hidden" name="action" value="getOne_For_Display"> -->
<!--        <input type="submit" value="送出"> -->
<!--      </FORM> -->
<!--   </li> -->
</ul>

<%--  <jsp:useBean id="deptSvc" scope="page" class="com.dept.model.DeptService" /> --%>
  
<!--   <li> -->
<%--      <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/dept/dept.do" > --%>
<!--        <b><font color=orange>選擇部門:</font></b> -->
<!--        <select size="1" name="deptno"> -->
<%--          <c:forEach var="deptVO" items="${deptSvc.all}" >  --%>
<%--           <option value="${deptVO.deptno}">${deptVO.dname} --%>
<%--          </c:forEach>    --%>
<!--        </select> -->
<!--        <input type="submit" value="送出"> -->
<!--        <input type="hidden" name="action" value="listEmps_ByDeptno_A"> -->
<!--      </FORM> -->
<!--   </li> -->
<!-- </ul> -->

<%-- 萬用複合查詢-以下欄位-可隨意增減 --%>
<!-- <ul>   -->
<!--   <li>    -->
<%--     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" name="form1"> --%>
<!--         <b><font color=blue>萬用複合查詢:</font></b> <br> -->
<!--         <b>輸入員工編號:</b> -->
<!--         <input type="text" name="empno" value="7001"><br> -->
           
<!--        <b>輸入員工姓名:</b> -->
<!--        <input type="text" name="ename" value="KING"><br> -->
       
<!--        <b>輸入員工職位:</b> -->
<!--        <input type="text" name="job" value="PRESIDENT"><br> -->
    
<!--        <b>選擇部門:</b> -->
<!--        <select size="1" name="deptno" > -->
<!--           <option value=""> -->
<%--          <c:forEach var="deptVO" items="${deptSvc.all}" >  --%>
<%--           <option value="${deptVO.deptno}">${deptVO.dname} --%>
<%--          </c:forEach>    --%>
<!--        </select><br> -->
           
<!--        <b>雇用日期:</b> -->
<!-- 	   <input name="hiredate" id="f_date1" type="text"> -->
		        
<!--         <input type="submit" value="送出"> -->
<!--         <input type="hidden" name="action" value="listEmps_ByCompositeQuery"> -->
<!--      </FORM> -->
<!--   </li> -->
<!-- </ul> -->




<h3>權限管理</h3>

<ul> 
 <li><a href='<%=request.getContextPath()%>/back-end/auth/addAuth.jsp'>Add</a> a new Auth.</li>
</ul>
</body>
</html>