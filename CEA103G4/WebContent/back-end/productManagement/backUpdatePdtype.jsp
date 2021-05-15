<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product_type.model.*"%>

<%

Product_TypeDAO dao = new Product_TypeDAO();
List<Product_TypeVO> list = dao.getAll();
pageContext.setAttribute("list",list);


Product_TypeVO product_typeVO = (Product_TypeVO) request.getAttribute("product_typeVO"); 


%>

<!DOCTYPE html>
<html lang="zh-tw">
<head>
  <meta name="description" content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
  <!-- Twitter meta-->
  <meta property="twitter:card" content="summary_large_image">
  <meta property="twitter:site" content="@pratikborsadiya">
  <meta property="twitter:creator" content="@pratikborsadiya">
  <!-- Open Graph Meta-->
  <meta property="og:type" content="website">
  <meta property="og:site_name" content="Vali Admin">
  <meta property="og:title" content="Vali - Free Bootstrap 4 admin theme">
  <meta property="og:url" content="http://pratikborsadiya.in/blog/vali-admin">
  <meta property="og:image" content="http://pratikborsadiya.in/blog/vali-admin/hero-social.png">
  <meta property="og:description" content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
  <title>Mode Femme 商品類別修改</title>
  <link rel="icon" href="${pageContext.request.contextPath}/front-template/images/favicon.ico" type="image/x-icon">
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Main CSS-->
 <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/back-template/docs/css/main.css">
  <!-- Font-icon css-->
  <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body class="app sidebar-mini rtl">
<jsp:include page="/back-end/backendMenu.jsp" />

              <main class="app-content">
                <div class="app-title">
                  <div>
                    <h1><i class="fa fa-wrench">&nbsp;</i>修改商品類別</h1>
                  </div>
                 
                  <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
                    <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/back-end/productManagement/backProductType.jsp">商品類別管理</a></li>
                  </ul>
                </div>
                <div class="row backProductList">
             <div class="product-tab col-lg-12">

              <div class="tab-item-content">
                <div class="tab-content">
                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product_type/product_type.do" name="form1">
                 <table class="table">
  					<thead class="thead">
   					 <tr>
     				 <th scope="col">商品類別編號</th>
     				 <th scope="col">商品類別名稱</th>
  				  </tr>
 				 </thead>
 				 <tbody>
   				 <tr>
					<td><%=product_typeVO.getPdtype_no()%></td>
					<td><input type="TEXT" class="updatePdtype" name="pdtype_name" size="45" value="<%=product_typeVO.getPdtype_name()%>" required></td>
					<td>
   					   <button type="submit" class="btn btn-info submitAdd" name="pdtype_no" value="<%=product_typeVO.getPdtype_no()%>">提交修改</button>
			     	   <input type="hidden" name="action" value="update">
   					 </td>
   					 </tr>
   				 </tbody>
				</table>
				</FORM>
              </div>
            </div>
           </div>
          </div>       
          
    <!-- Product Shop Section End -->
              </main>
              <!-- Essential javascripts for application to work-->
              <script src="<%=request.getContextPath()%>/back-template/docs/js/jquery-3.2.1.min.js"></script>
              <script src="<%=request.getContextPath()%>/back-template/docs/js/popper.min.js"></script>
              <script src="<%=request.getContextPath()%>/back-template/docs/js/bootstrap.min.js"></script>
              <script src="<%=request.getContextPath()%>/back-template/docs/js/main.js"></script>
              <!-- The javascript plugin to display page loading on top-->
              <script src="<%=request.getContextPath()%>/back-template/docs/js/plugins/pace.min.js"></script>
         </body>
         </html>