<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Product_Type</title>

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
   <tr><td><h3>商品類別查詢</h3></td></tr>
</table>


<h3>商品類別查詢:</h3>
	
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
  <li><a href='listAllProduct_Type.jsp'>List</a> all Product_Type    <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product_type/product_type.do" >
        <b>輸入商品類別編號 (如4001):</b>
        <input type="text" name="pdtype_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">  
    </FORM>
  </li>
  
    <jsp:useBean id="product_typeSvc" scope="page" class="com.product_type.model.Product_TypeService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product_type/product_type.do" >
       <b>選擇商品類別編號 :</b>
       <select size="1" name="pdtype_no">
         <c:forEach var="product_typeVO" items="${product_typeSvc.all}" > 
          <option value="${product_typeVO.pdtype_no}">${product_typeVO.pdtype_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product_type/product_type.do" >
       <b>選擇商品類別名稱:</b>
       <select size="1" name="pdtype_no">
         <c:forEach var="product_typeVO" items="${product_typeSvc.all}" > 
          <option value="${product_typeVO.pdtype_no}">${product_typeVO.pdtype_name}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
</ul>


<h3>商品類別管理</h3>

<ul>
  <li><a href='addProduct_Type.jsp'>Add</a> a new Product.</li>
</ul>

</body>
</html>