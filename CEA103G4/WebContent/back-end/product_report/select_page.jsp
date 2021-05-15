<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>商品檢舉管理</title>

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
   <tr><td><h3>商品檢舉管理</h3><h4>( MVC )</h4></td></tr>
</table>


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
  <li><a href='<%=request.getContextPath()%>/back-end/product_report/listAllProduct_Report.jsp'>List</a> all Product    <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product_report/product_report.do" >
        <b>輸入商品檢舉編號 (如12001):</b>
        <input type="text" name="pro_report_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">  
    </FORM>
  </li>
  
    <jsp:useBean id="product_reportSvc" scope="page" class="com.product_report.model.Product_ReportService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product_report/product_report.do" >
       <b>選擇商品檢舉編號 :</b>
       <select size="1" name="pro_report_no">
         <c:forEach var="product_reportVO" items="${product_reportSvc.all}" > 
          <option value="${product_reportVO.pro_report_no}">${product_reportVO.pro_report_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product_report/product_report.do" >
       <b>選擇檢舉者帳號:</b>
       <select size="1" name="pro_report_no">
         <c:forEach var="product_reportVO" items="${product_reportSvc.all}" > 
          <option value="${product_reportVO.pro_report_no}">${product_reportVO.user_id}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getAllUser_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>商品檢舉管理</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/back-end/product_report/addProduct_Report.jsp'>Add</a> a new Product_Report.</li>
</ul>

</body>
</html>