</html><%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.product.model.*"%>

<%
  ProductVO productVO = (ProductVO) request.getAttribute("productVO"); //EmpServlet.java (Concroller) 存入req的productVO物件 (包括幫忙取出的productVO, 也包括輸入資料錯誤時的productVO物件)
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
  
  #preview img{
  	width: 100px;
  	height: 100px;
  
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>商品資料修改</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/product/select_page.jsp">回首頁</a></h4>
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>商品編號:<font color=red><b>*</b></font></td>
		<td><%=productVO.getProduct_no()%></td>
	</tr>
	<tr>
		<td>商品名稱:</td>
		<td><input type="TEXT" name="product_name" size="45" value="<%=productVO.getProduct_name()%>" /></td>
	</tr>
	<tr>
		<td>商品說明:</td>
		<td><input type="TEXT" name="product_info" size="45" value="<%=productVO.getProduct_info()%>" /></td>
	</tr>
	<tr>
		<td>商品價格:</td>
		<td><input type="text" name="product_price" size="45" value="<%=productVO.getProduct_price()%>"  /></td>
	</tr>
	<tr>
		<td>商品原數量:</td>
		<td><input type="TEXT" name="product_quantity" size="45" value="<%=productVO.getProduct_quantity()%>" /></td>
	</tr>
	<tr>
		<td>商品剩餘數量:</td>	
		<td><input type="TEXT" name="product_remaining" size="45" value="<%=productVO.getProduct_remaining()%>" /></td>
	</tr>
	<tr>
		<td>選擇商品狀態:</td>
		<td><input type="TEXT" name="product_state" size="45" value="<%=productVO.getProduct_state()%>" /></td>
	</tr>
	<tr>
		<td>商品照片:</td>
		<td>
		<input type="file" name="product_photo" id="myFile" />
		<img width="100px" height="100px" id="oldimg" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}">
		<div id="preview"></div></td>
	</tr>
	<tr>
		<td>會員帳號:</td>
		<td><input type="TEXT" name="user_id" size="45" value="<%=productVO.getUser_id()%>" /></td>
	</tr>
	<tr>
		<td>商品類別編號:</td>
		<td><input type="TEXT" name="pdtype_no" size="45" value="<%=productVO.getPdtype_no()%>" /></td>
	</tr>
<!-- 	<tr> -->
<!-- 		<td>商品起標價:</td> -->
<%-- 		<td><input type="TEXT" name="start_price" size="45" value="<%=productVO.getStart_price()%>" /></td> --%>
<!-- 	</tr> -->
<!-- 	<tr> -->
<!-- 		<td>直播編號:</td> -->
<%-- 		<td><input type="TEXT" name="live_no" size="45" value="<%=productVO.getLive_no()%>" /></td> --%>
<!-- 	</tr> -->
	

</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="product_no" value="<%=productVO.getProduct_no()%>">
<input type="submit" value="送出修改"></FORM>

<script>

let myFile = document.getElementById("myFile");
let preview = document.getElementById('preview');
let oldimg = document.getElementById('oldimg');

function init() {
    myFile.addEventListener('change', function(e) {
    	$("#preview").empty();
        let files = e.target.files;     
        if (files !== null) {          
            let file = files[0];
            if (file.type.indexOf('image') > -1) {
                let reader = new FileReader();
                reader.addEventListener('load', function(e) { 
                    let result = e.target.result;
                    let img = document.createElement('img');
                    img.src = result;
                    preview.append(img);
                    oldimg.remove();
                });
                reader.readAsDataURL(file);
            } else {
            	alert('請上傳圖片！');
            }
        }
    });
}

window.onload = init;


</script>

    <script
      src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
      integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
      crossorigin="anonymous"
    ></script>

</body>


</html>