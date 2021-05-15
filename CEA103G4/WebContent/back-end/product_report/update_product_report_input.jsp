</html><%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.product_report.model.*"%>

<%
	Product_ReportVO product_reportVO = (Product_ReportVO) request.getAttribute("product_reportVO"); //EmpServlet.java (Concroller) 存入req的product_reportVO物件 (包括幫忙取出的product_reportVO, 也包括輸入資料錯誤時的product_reportVO物件)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>商品資料修改 - update_product_input.jsp</title>

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
	<tr><td>
		 <h3>商品檢舉資料修改</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/product_report/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product_report/product_report.do" name="form1" >
<table>
	<tr>
		<td>商品檢舉編號:<font color=red><b>*</b></font></td>
		<td><%=product_reportVO.getPro_report_no()%></td>
	</tr>
	<tr>
		<td>商品檢舉內容:</td>
		<td><%=product_reportVO.getPro_report_content()%></td>
	</tr>
	<tr>
		<td>商品編號:</td>
		<td><%=product_reportVO.getProduct_no()%></td>
	</tr>
	<tr>
		<td>檢舉者帳號:</td>
		<td><%=product_reportVO.getUser_id()%></td>
	</tr>
	<tr>
		<td>處理員工編號:</td>
		<td><%=product_reportVO.getEmpno()%></td>
	</tr>
	<tr>
		<td>檢舉處理狀態:</td>
		<td><select name="proreport_state">
					<option value="0" ${(product_reportVO.proreport_state==0)? 'selected':''}>未處理</option>
					<option value="1" ${(product_reportVO.proreport_state==1)? 'selected':''}>審核通過</option>
					<option value="2" ${(product_reportVO.proreport_state==2)? 'selected':''}>審核不通過</option>
			</select></td>	
	</tr>



</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="pro_report_no" value="<%=product_reportVO.getPro_report_no()%>">
<input type="hidden" name="pro_report_content" value="<%=product_reportVO.getPro_report_content()%>">
<input type="hidden" name="product_no" value="<%=product_reportVO.getProduct_no()%>">
<input type="hidden" name="user_id" value="<%=product_reportVO.getUser_id()%>">
<input type="hidden" name="empno" value="<%=product_reportVO.getEmpno()%>">
<input type="submit" value="送出修改"></FORM>
</body>


</html>