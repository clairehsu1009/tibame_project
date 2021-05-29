<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product_report.model.*"%>

<%
	Product_ReportDAO dao = new Product_ReportDAO();
	List<Product_ReportVO> list = dao.getAll();
	pageContext.setAttribute("list",list);


%>
<jsp:useBean id="productSvc" scope="page" class="com.product.model.ProductService" />


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
  <title>Mode Femme 商品檢舉管理</title>
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

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
              <main class="app-content">
                <div class="app-title">
                  <div>
                    <h1><i class="fa fa-exclamation-circle">&nbsp;</i>直售商品檢舉</h1>
                  </div>
                  <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
                    <li class="breadcrumb-item"><a href="#">直售檢舉管理</a></li>
                  </ul>
                </div>
                <div class="row backProductList">
             <div class="product-tab col-lg-12">
              <div class="tab-item">
                <ul class="nav" role="tablist">
                  <li>
                    <a class="active" data-toggle="tab" href="#tab-1" role="tab"
                      >未處理</a
                    >
                  </li>
                  <li>
                    <a data-toggle="tab" href="#tab-2" role="tab">審核通過</a>
                  </li>

                  <li>
                    <a data-toggle="tab" href="#tab-3" role="tab">審核不通過</a>
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
     				 <th scope="col">商品檢舉編號</th>
     				 <th scope="col">商品檢舉內容</th>
     				 <th scope="col">商品編號</th>
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">賣家帳號</th>
     				 <th scope="col">檢舉人</th>
     				 <th scope="col">檢舉時間</th>
     				 <th scope="col">審核員工</th>
     				 <th scope="col">處理狀態</th>
  				  </tr>
 				 </thead>
 				 <tbody>
 				 <c:forEach var="product_reportVO" items="${list}" begin="0" end="${list.size()}">
   				 	<c:if test="${product_reportVO.proreport_state == 0}"> 
   				 <tr>
     				 <th scope="row">${product_reportVO.pro_report_no}</th>
     				 <td>${product_reportVO.pro_report_content}</td>
     				 <td>${product_reportVO.product_no}</td>
     				 <td>
     				 <a href="<%=request.getContextPath()%>/product/product.do?product_no=${product_reportVO.product_no}" target="_blank">
     				 <img width="100px" height="100px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${product_reportVO.product_no}" class="rounded mx-auto d-block" alt="">
     				 </a>
     				 </td>
      				 <td>${productSvc.getOneProduct(product_reportVO.product_no).user_id}</td>
      				 <td>${product_reportVO.user_id}</td>
      				 <td>${product_reportVO.report_date}</td>
     				 <td>${product_reportVO.empno}</td>
<%--      				 <td>${product_reportVO.proreport_state}</td> --%>
					 <td>
				  <form METHOD="post" ACTION="<%=request.getContextPath()%>/product_report/product_report.do" name="form1" >	 
             	  <select class="form-select"  name="proreport_state" id="ReportProreport_state">
             	  	<option value="0" ${(product_reportVO.proreport_state==0)? 'selected':'' }>未處理</option>
					<option value="1" ${(product_reportVO.proreport_state==1)? 'selected':'' }>審核通過</option>
					<option value="2" ${(product_reportVO.proreport_state==2)? 'selected':'' }>審核不通過</option>
                 </select>
                 	<input type="hidden" name="pro_report_no" value="${product_reportVO.pro_report_no}">
                 	<input type="hidden" name="product_no" value="${product_reportVO.product_no}">
                 	<button type="submit" class="btn btn-warning submitAdd" name="action" value="update">修改狀態</button>
                   </form>	
					</td>
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
     				 <th scope="col">商品檢舉編號</th>
     				 <th scope="col">商品檢舉內容</th>
     				 <th scope="col">商品編號</th>
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">賣家帳號</th>
     				 <th scope="col">檢舉人</th>
     				 <th scope="col">檢舉時間</th>
     				 <th scope="col">審核員工</th>
     				 <th scope="col">處理狀態</th>
  				  </tr>
 				 </thead>
 				 <tbody>
 				 <c:forEach var="product_reportVO" items="${list}" begin="0" end="${list.size()}">
   				 	<c:if test="${product_reportVO.proreport_state == 1}"> 
   				 <tr>
     				 <th scope="row">${product_reportVO.pro_report_no}</th>
     				 <td>${product_reportVO.pro_report_content}</td>
     				 <td>${product_reportVO.product_no}</td>
     				 <td>
     				 <a href="<%=request.getContextPath()%>/product/product.do?product_no=${product_reportVO.product_no}" target="_blank">
     				 <img width="100px" height="100px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${product_reportVO.product_no}" class="rounded mx-auto d-block" alt="">
     				 </a>
     				 </td>
      				 <td>${productSvc.getOneProduct(product_reportVO.product_no).user_id}</td>
      				 <td>${product_reportVO.user_id}</td>
      				 <td>${product_reportVO.report_date}</td>
     				 <td>${product_reportVO.empno}</td>
					 <td>
				<c:choose>
    		     <c:when test="${product_reportVO.proreport_state == 0}">
       			            未處理
   			     </c:when>
   			     <c:when test="${product_reportVO.proreport_state == 1}">
       				審核通過
    			</c:when>
    			<c:when test="${product_reportVO.proreport_state == 2}">
       				審核不通過
    			</c:when>
		      </c:choose>
		      		</td>
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
     				 <th scope="col">商品檢舉編號</th>
     				 <th scope="col">商品檢舉內容</th>
     				 <th scope="col">商品編號</th>
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">賣家帳號</th>
     				 <th scope="col">檢舉人</th>
     				 <th scope="col">檢舉時間</th>
     				 <th scope="col">審核員工</th>
     				 <th scope="col">處理狀態</th>
  				  </tr>
 				 </thead>
 				 <tbody>
 				 <c:forEach var="product_reportVO" items="${list}" begin="0" end="${list.size()}">
   				 	<c:if test="${product_reportVO.proreport_state == 2}"> 
   				 <tr>
     				 <th scope="row">${product_reportVO.pro_report_no}</th>
     				 <td>${product_reportVO.pro_report_content}</td>
     				 <td>${product_reportVO.product_no}</td>
     				 <td>
     				 <a href="<%=request.getContextPath()%>/product/product.do?product_no=${product_reportVO.product_no}" target="_blank">
     				 <img width="100px" height="100px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${product_reportVO.product_no}" class="rounded mx-auto d-block" alt="">
     				 </a>
     				 </td>
      				 <td>${productSvc.getOneProduct(product_reportVO.product_no).user_id}</td>
      				 <td>${product_reportVO.user_id}</td>
      				 <td>${product_reportVO.report_date}</td>
     				 <td>${product_reportVO.empno}</td>
					 <td>
				<c:choose>
    		     <c:when test="${product_reportVO.proreport_state == 0}">
       			            未處理
   			     </c:when>
   			     <c:when test="${product_reportVO.proreport_state == 1}">
       				審核通過
    			</c:when>
    			<c:when test="${product_reportVO.proreport_state == 2}">
       				審核不通過
    			</c:when>
		      </c:choose>
		      		</td>
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

         </body>
         </html>