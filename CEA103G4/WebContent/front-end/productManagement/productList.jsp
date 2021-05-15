<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.product.model.*"%>
<%@ page import="com.user.model.*"%>


<%
	ProductDAO dao = new ProductDAO();
    List<ProductVO> list = dao.getAll();
    pageContext.setAttribute("list",list);
    
	UserVO userVO = (UserVO) session.getAttribute("account"); 
	session.setAttribute("userVO", userVO);
%>
<jsp:useBean id="product_typeSvc" scope="page" class="com.product_type.model.Product_TypeService" />
<jsp:useBean id="product_reportSvc" scope="page" class="com.product_report.model.Product_ReportService" />
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
  <title>Mode Femme 我的商品</title>
  <link rel="icon" href="${pageContext.request.contextPath}/front-template/images/favicon.ico" type="image/x-icon">
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Main CSS-->
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front-template/css/usermain.css">
  <!-- Font-icon css-->
  <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body class="app sidebar-mini rtl">

  <!-- Navbar_siderbar start-->
  <%@include file="/front-end/user/userSidebar.jsp"%>
  <!-- Navbar_siderbar finish-->


              <main class="app-content">
                <div class="app-title">
                  <div>
                    <h1><i class="fa fa-archive">&nbsp;</i>我的商品</h1>
                  </div>
                  <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
                    <li class="breadcrumb-item"><a href="#">商品管理</a></li>
                  </ul>
                </div>
                <div class="row productList">
             <div class="product-tab col-lg-12">
              <div class="tab-item">
                <ul class="nav" role="tablist">
                  <li>
                    <a class="active" data-toggle="tab" href="#tab-1" role="tab"
                      >未上架商品</a
                    >
                  </li>
                  <li>
                    <a data-toggle="tab" href="#tab-2" role="tab">上架中</a>
                  </li>
                  <li>
                    <a data-toggle="tab" href="#tab-3" role="tab">待直播商品</a>
                  </li>
                  <li>
                    <a data-toggle="tab" href="#tab-4" role="tab">已售出</a>
                  </li>
                  <li>
                    <a data-toggle="tab" href="#tab-5" role="tab"
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
     				 <th scope="col">#</th>
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">商品名稱</th>
     				 <th scope="col">商品描述</th>
     				 <th scope="col">價格</th>
     				 <th scope="col">數量</th>
     				 <th scope="col">商品種類</th>
     				 <th scope="col">編輯</th>
  				  </tr>
 				 </thead>
 				 <tbody>
 				 <c:forEach var="productVO" items="${list}" begin="0" end="${list.size()}" varStatus="i">
   				 	<c:if test="${productVO.user_id == userVO.getUser_id() && productVO.product_state == 0}"> 
   				 <tr>
     				 <th scope="row">${i.index+1}</th>
     				 <td><img width="200px" height="200px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}" class="rounded mx-auto d-block" alt=""></td>
      				 <td>${productVO.product_name}</td>
      				 <td class="productInfo"><textarea class="form-control"  maxlength="300" rows="6" readonly>${productVO.product_info}</textarea></td>
     				 <td>${productVO.product_price}</td>
     				 <td>${productVO.product_remaining}</td>
     				 <td>${product_typeSvc.getOneProduct_Type(productVO.pdtype_no).pdtype_name}</td>
   					 <td>
   					 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" style="margin-bottom: 0px;">
   					   <button type="submit" class="btn btn-info submitAdd"  name="product_no"  value="${productVO.product_no}">修改</button>
			     	   <input type="hidden" name="action"	value="getOne_For_Update">
   					 </FORM>
   					 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" style="margin-bottom: 0px;">
   					 <button type="submit" class="btn btn-danger" name="product_no"value="${productVO.product_no}">刪除</button>
			         <input type="hidden" name="action" value="delete">
			         </FORM>
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
     				 <th scope="col">#</th>
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">商品名稱</th>
     				 <th scope="col">商品描述</th>
     				 <th scope="col">價格</th>
     				 <th scope="col">數量</th>
     				 <th scope="col">商品種類</th>
     				 <th scope="col">編輯</th>
  				  </tr>
 				 </thead>
 				 <tbody>
 				 <c:forEach var="productVO" items="${list}" begin="0" end="${list.size()}" varStatus="i">
   				 	<c:if test="${productVO.user_id == userVO.getUser_id() && productVO.product_state == 1}"> 
   				 <tr>
     				 <th scope="row">${i.index+1}</th>
     				 <td><img width="200px" height="200px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}" class="rounded mx-auto d-block" alt=""></td>
      				 <td>${productVO.product_name}</td>
     				 <td class="productInfo"><textarea class="form-control"  maxlength="300" rows="6" readonly>${productVO.product_info}</textarea></td>
     				 <td>${productVO.product_price}</td>
     				 <td>${productVO.product_remaining}</td>
     				 <td>${product_typeSvc.getOneProduct_Type(productVO.pdtype_no).pdtype_name}</td>
   					 <td>
   					 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" style="margin-bottom: 0px;">
   					   <button type="submit" class="btn btn-info submitAdd"  name="product_no"  value="${productVO.product_no}">修改</button>
			     	   <input type="hidden" name="action"	value="getOne_For_Update">
   					 </FORM>
   					 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" style="margin-bottom: 0px;">
   					 <button type="submit" class="btn btn-danger" name="product_no"value="${productVO.product_no}">刪除</button>
			         <input type="hidden" name="action" value="delete">
			         </FORM>
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
   				  	 <th scope="col">直播間名稱</th>
   				  	 <th scope="col">直播分類</th>
     				 <th scope="col">直播時間</th>
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">商品名稱</th>
     				 <th scope="col">商品描述</th>
     				 <th scope="col">起標價</th>
     				 <th scope="col">數量</th>
  				  </tr>
 				 </thead>
 				 <tbody>
 				 <c:forEach var="productVO" items="${list}" begin="0" end="${list.size()}">
   				 	<c:if test="${productVO.user_id == userVO.getUser_id() && productVO.product_state == 2}"> 
   				 <tr>
   				 	 <th scope="row">${liveSvc.getOneLive(productVO.live_no).live_name}</th>
   				 	 <td>${liveSvc.getOneLive(productVO.live_no).live_type}</td>
     				 <td>${liveSvc.getOneLive(productVO.live_no).live_time}</td>
     				 <td><img width="200px" height="200px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}" class="rounded mx-auto d-block" alt=""></td>
      				 <td>${productVO.product_name}</td>
      				 <td class="productInfo"><textarea class="form-control"  maxlength="300" rows="6" readonly>${productVO.product_info}</textarea></td>
     				 <td>${productVO.start_price}</td>
     				 <td>${productVO.product_remaining}</td>
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
     				 <th scope="col">#</th>
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">商品名稱</th>
     				 <th scope="col">商品描述</th>
     				 <th scope="col">價格</th>
     				 <th scope="col">商品種類</th>
     				 <th scope="col">數量</th>
  				  </tr>
 				 </thead>
 				 <tbody>
 				 <c:forEach var="productVO" items="${list}" begin="0" end="${list.size()}" varStatus="i">
   				 	<c:if test="${productVO.user_id == userVO.getUser_id() && productVO.product_state == 3}"> 
   				 <tr>
     				 <th scope="row">${i.index+1}</th>
     				 <td><img width="200px" height="200px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}" class="rounded mx-auto d-block" alt=""></td>
      				 <td>${productVO.product_name}</td>
     				 <td class="productInfo"><textarea class="form-control"  maxlength="300" rows="6" readonly>${productVO.product_info}</textarea></td>
     				 <td>${productVO.product_price}</td>
     				 <td>${product_typeSvc.getOneProduct_Type(productVO.pdtype_no).pdtype_name}</td>
     				 <td><button type="" class="btn btn-success">已售出</button></td>
   				 </tr>
   				 	</c:if>
   				 </c:forEach>
   				 </tbody>
				</table>
                </div>
                 <div class="tab-pane fade" id="tab-5" role="tabpanel">
                 <table class="table">
  					<thead class="thead">
   					 <tr>
     				 <th scope="col">#</th>
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">商品名稱</th>
     				 <th scope="col">商品描述</th>
     				 <th scope="col">檢舉時間</th>
     				 <th scope="col">違規原因</th>
  				  </tr>
 				 </thead>
 				 <tbody>
 				 <c:forEach var="productVO" items="${list}" begin="0" end="${list.size()}" varStatus="i">
   				 	<c:if test="${productVO.user_id == userVO.getUser_id() && productVO.product_state == 5}"> 
   				 <tr>
     				 <th scope="row">${i.index+1}</th>
     				 <td><img width="200px" height="200px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}" class="rounded mx-auto d-block" alt=""></td>
      				 <td>${productVO.product_name}</td>
     				 <td class="productInfo"><textarea class="form-control"  maxlength="300" rows="6" readonly>${productVO.product_info}</textarea></td>
     				 <td><fmt:formatDate value="${product_reportSvc.userProduct_ReportInfo(productVO.product_no).report_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
     				 <td>${product_reportSvc.userProduct_ReportInfo(productVO.product_no).pro_report_content}</td>
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