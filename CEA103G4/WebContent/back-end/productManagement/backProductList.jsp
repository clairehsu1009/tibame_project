<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.emp.model.*"%>

<%
	ProductDAO dao = new ProductDAO();
    List<ProductVO> list = dao.getAll();
    pageContext.setAttribute("list",list);


%>
<jsp:useBean id="product_typeSvc" scope="page" class="com.product_type.model.Product_TypeService" />
<jsp:useBean id="liveSvc" scope="page" class="com.live.model.LiveService" />


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
  <title>Mode Femme 直售商品管理</title>
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
                    <h1><i class="fa fa-archive">&nbsp;</i>所有直售商品</h1>
                  </div>
                  <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
                    <li class="breadcrumb-item"><a href="#">直售商品管理</a></li>
                  </ul>
                </div>
                <div class="row backProductList">
             <div class="product-tab col-lg-12">
              <div class="tab-item">
                <ul class="nav" role="tablist">
                  <li>
                    <a class="active" data-toggle="tab" href="#tab-1" role="tab"
                      >未上架商品</a
                    >
                  </li>
                  <li>
                    <a data-toggle="tab" href="#tab-2" role="tab">直售商品</a>
                  </li>

                  <li>
                    <a data-toggle="tab" href="#tab-3" role="tab">已售出</a>
                  </li>
                  <li>
                    <a data-toggle="tab" href="#tab-4" role="tab"
                      >違規下架</a
                    >
                  </li>
                </ul>
              </div>
              <div class="tab-item-content">
                <div class="tab-content">
                  <div
                    class="tab-pane fade-in active"
                    id="tab-1"
                    role="tabpanel">
                   <table class="table">
  					<thead class="thead">
   					 <tr>
     				 <th scope="col">商品編號</th>
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">商品名稱</th>
     				 <th scope="col">商品描述</th>
     				 <th scope="col">價格</th>
     				 <th scope="col">剩餘數量</th>
     				 <th scope="col">已售數量</th>
     				 <th scope="col">商品種類</th>
     				 <th scope="col">賣家帳號</th>
  				  </tr>
 				 </thead>
 				 <tbody>
 				 <c:forEach var="productVO" items="${list}" begin="0" end="${list.size()-1}">
   				 	<c:if test="${productVO.product_state == 0}"> 
   				 <tr>
     				 <th scope="row">${productVO.product_no}</th>
     				 <td>
     				 <a href="<%=request.getContextPath()%>/product/product.do?product_no=${productVO.product_no}" target="_blank">
     				 <img width="200px" height="200px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}" class="rounded mx-auto d-block" alt="">
     				 </a>
     				 </td>
      				 <td>${productVO.product_name}</td>
      				 <td class="productInfo"><textarea class="form-control"  maxlength="300" rows="6" readonly>${productVO.product_info}</textarea></td>
     				 <td>${productVO.product_price}</td>
     				 <td>${productVO.product_remaining}</td>
     				 <td>${productVO.product_sold}</td>
     				 <td>${product_typeSvc.getOneProduct_Type(productVO.pdtype_no).pdtype_name}</td>
     				 <td>${productVO.user_id}</td>
   				 </tr>
   				 	</c:if>
   				 </c:forEach>
   				 </tbody>
				</table>
                  </div>
                  <div class="tab-pane fade" id="tab-2" role="tabpanel">
                   <table class="table">
  					<thead class="thead">
   				  <tr>
     				 <th scope="col">商品編號</th>
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">商品名稱</th>
     				 <th scope="col">商品描述</th>
     				 <th scope="col">價格</th>
     				 <th scope="col">剩餘數量</th>
     				 <th scope="col">已售數量</th>
     				 <th scope="col">商品種類</th>
     				 <th scope="col">賣家帳號</th>
  				  </tr>
 				 </thead>
 				 <tbody>
 				 <c:forEach var="productVO" items="${list}" begin="0" end="${list.size()-1}">
   				 	<c:if test="${productVO.product_state == 1}"> 
   				 <tr>
     				 <th scope="row">${productVO.product_no}</th>
     				 <td>
     				 <a href="<%=request.getContextPath()%>/product/product.do?product_no=${productVO.product_no}" target="_blank">
     				 <img width="200px" height="200px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}" class="rounded mx-auto d-block" alt="">
     				 </a>
     				 </td>
      				 <td>${productVO.product_name}</td>
      				 <td class="productInfo"><textarea class="form-control"  maxlength="300" rows="6" readonly>${productVO.product_info}</textarea></td>
     				 <td>${productVO.product_price}</td>
     				 <td>${productVO.product_remaining}</td>
     				 <td>${productVO.product_sold}</td>
     				 <td>${product_typeSvc.getOneProduct_Type(productVO.pdtype_no).pdtype_name}</td>
     				 <td>${productVO.user_id}</td>
   				 </tr>
   				 	</c:if>
   				 </c:forEach>
   				 </tbody>
				</table>
                  </div>

                  <div class="tab-pane fade" id="tab-3" role="tabpanel">
				 <table class="table">
  					<thead class="thead">
   					 <tr>
     				 <th scope="col">商品編號</th>
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">商品名稱</th>
     				 <th scope="col">商品描述</th>
     				 <th scope="col">價格</th>
     				 <th scope="col">數量</th>
     				 <th scope="col">商品種類</th>
     				 <th scope="col">賣家帳號</th>
  				  </tr>
 				 </thead>
 				 <tbody>
 				 <c:forEach var="productVO" items="${list}" begin="0" end="${list.size()-1}" varStatus="i">
   				 	<c:if test="${productVO.product_state == 3}"> 
   				 <tr>
     				 <th scope="row">${productVO.product_no}</th>
     				 <td>
     				 <a href="<%=request.getContextPath()%>/product/product.do?product_no=${productVO.product_no}" target="_blank">
     				 <img width="200px" height="200px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}" class="rounded mx-auto d-block" alt="">
     				 </a>
     				 </td>
      				 <td>${productVO.product_name}</td>
      				 <td class="productInfo"><textarea class="form-control"  maxlength="300" rows="6" readonly>${productVO.product_info}</textarea></td>
     				 <td>${productVO.product_price}</td>
     				 <td><button type="" class="btn btn-success">已售出</button></td>
     				 <td>${product_typeSvc.getOneProduct_Type(productVO.pdtype_no).pdtype_name}</td>
     				 <td>${productVO.user_id}</td>
   				 </tr>
   				 	</c:if>
   				 </c:forEach>
   				 </tbody>
				</table>
                </div>
                 <div class="tab-pane fade" id="tab-4" role="tabpanel">
                 <table class="table">
  					<thead class="thead">
   					 <tr>
     				 <th scope="col">商品編號</th>
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">商品名稱</th>
     				 <th scope="col">商品描述</th>
     				 <th scope="col">檢舉時間</th>
     				 <th scope="col">違規原因</th>
     				 <th scope="col">賣家帳號</th>
  				  </tr>
 				 </thead>
 				 <tbody>
 				 <c:forEach var="productVO" items="${list}" begin="0" end="${list.size()-1}" varStatus="i">
   				 	<c:if test="${productVO.product_state == 5}"> 
   				 <tr>
     				 <th scope="row">${productVO.product_no}</th>
     				 <td>
     				 <a href="<%=request.getContextPath()%>/product/product.do?product_no=${productVO.product_no}" target="_blank">
     				 <img width="200px" height="200px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}" class="rounded mx-auto d-block" alt="">
     				 </a>
     				 </td>
      				 <td>${productVO.product_name}</td>
     				 <td class="productInfo"><textarea class="form-control"  maxlength="300" rows="6" readonly>${productVO.product_info}</textarea></td>
     				 <td></td>
     				 <td></td>
     				 <td>${productVO.user_id}</td>
   				 </tr>
   				 	</c:if>
   				 </c:forEach>
   				 </tbody>
				</table>
                 </div>
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
              <!-- Page specific javascripts-->
              <script type="text/javascript" src="<%=request.getContextPath()%>/back-template/docs/js/plugins/chart.js"></script>
              <script type="text/javascript">
                var data = {
                 labels: ["January", "February", "March", "April", "May"],
                 datasets: [
                 {
                   label: "My First dataset",
                   fillColor: "rgba(220,220,220,0.2)",
                   strokeColor: "rgba(220,220,220,1)",
                   pointColor: "rgba(220,220,220,1)",
                   pointStrokeColor: "#fff",
                   pointHighlightFill: "#fff",
                   pointHighlightStroke: "rgba(220,220,220,1)",
                   data: [65, 59, 80, 81, 56]
                 },
                 {
                   label: "My Second dataset",
                   fillColor: "rgba(151,187,205,0.2)",
                   strokeColor: "rgba(151,187,205,1)",
                   pointColor: "rgba(151,187,205,1)",
                   pointStrokeColor: "#fff",
                   pointHighlightFill: "#fff",
                   pointHighlightStroke: "rgba(151,187,205,1)",
                   data: [28, 48, 40, 19, 86]
                 }
                 ]
               };
               var pdata = [
               {
                value: 300,
                color: "#46BFBD",
                highlight: "#5AD3D1",
                label: "Complete"
              },
              {
                value: 50,
                color:"#F7464A",
                highlight: "#FF5A5E",
                label: "In-Progress"
              }
              ]
              
              var ctxl = $("#lineChartDemo").get(0).getContext("2d");
              var lineChart = new Chart(ctxl).Line(data);
              
              var ctxp = $("#pieChartDemo").get(0).getContext("2d");
              var pieChart = new Chart(ctxp).Pie(pdata);
            </script>
            <!-- Google analytics script-->
            <script type="text/javascript">
              if(document.location.hostname == 'pratikborsadiya.in') {
               (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                 (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                 m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
               })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
               ga('create', 'UA-72504830-1', 'auto');
               ga('send', 'pageview');
             }
           </script>
         </body>
         </html>