<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Product: Home</title>

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
   <tr><td><h3>Product: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for Product: Home</p>

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
  <li><a href='<%=request.getContextPath()%>/back-end/product/listAllProduct.jsp'>List</a> all Product    <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" >
        <b>輸入商品編號 (如5001):</b>
        <input type="text" name="product_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">  
    </FORM>
  </li>
  
    <jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" >
       <b>選擇商品編號 :</b>
       <select size="1" name="product_no">
         <c:forEach var="productVO" items="${productSvc.all}" > 
          <option value="${productVO.product_no}">${productVO.product_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" >
       <b>選擇商品名稱:</b>
       <select size="1" name="product_no">
         <c:forEach var="productVO" items="${productSvc.all}" > 
          <option value="${productVO.product_no}">${productVO.product_name}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
     </FORM>
  </li>
     <jsp:useBean id="product_typeSvc" scope="page" class="com.product_type.model.Product_TypeService" />
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product_type/product_type.do" >
       <b><font color=orange>選擇商品類別:</font></b>
       <select size="1" name="pdtype_no">
         <c:forEach var="product_typeVO" items="${product_typeSvc.all}" > 
          <option value="${product_typeVO.pdtype_no}">${product_typeVO.pdtype_name}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="getProductsByPdtype">
     </FORM>
  </li>
  
</ul>


<h3>商品管理</h3>

<ul>
  <li><a href='addProduct.jsp'>Add</a> a new Product.</li>
</ul>

<h3><font color=orange>商品類別管理</font></h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/product_type/listAllProduct_Type.jsp'>List</a> all Product_Type. </li>
</ul>

</body>
</html>