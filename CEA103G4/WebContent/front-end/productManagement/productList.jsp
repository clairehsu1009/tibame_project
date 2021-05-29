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
                <div class="row productList" id="productList">
             <div class="product-tab col-lg-12 col-12">
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
                    <a data-toggle="tab" href="#tab-3" role="tab">直播商品</a>
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
                 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" style="margin-bottom: 0px;">
                   <table class="table">
  					<thead class="thead">
   					 <tr>
     				 <th scope="col">
     				   <div class="chose">
              			<label for="choseAll1">
                		 <input type="checkbox"  id="choseAll1"  />
                 		<span class="checkmark"></span>
              		  	</label>
           			  </div>
     				 </th>
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">商品名稱</th>
     				 <th scope="col">商品描述</th>
     				 <th scope="col">價格</th>
     				 <th scope="col">剩餘數量</th>
     				 <th scope="col">已售數量</th>
     				 <th scope="col">商品種類</th>
     				 <th scope="col">編輯</th>
  				  </tr>
 				 </thead>
 				 <tbody id="chose1">

 				 <c:forEach var="productVO" items="${list}" begin="0" end="${list.size()}" >
   				 	<c:if test="${productVO.user_id == userVO.getUser_id() && productVO.product_state == 0}"> 
   				 <tr>
     				 <th scope="row">
     				 	<div class="chose" >
              				<label for="${productVO.product_no}">
                		 <input type="checkbox"  id="${productVO.product_no}" name="product_no" value="${productVO.product_no}" />
                 			<span class="checkmark"></span>
              		  		</label>
           				</div>          					 
     				 </th>
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
   					 <td>
   					   <a href="<%=request.getContextPath()%>/ProductChange?action=getOne_For_Update&product_no=${productVO.product_no}" style="display:block;"><button type="button" class="btn btn-info">修改</button></a>
<%--    					   <button type="button" class="btn btn-danger"  data-id="${productVO.product_no}">刪除</button> --%>
   					 </td>
   				 </tr>
   				 	</c:if>
   				 </c:forEach>
   				 
   				 </tbody>
				</table>
				<div  class="fix-container" style="z-index: 999;">
           		<div class="choseAll">
             	  <label for="choseAll_b">
                 	  全選
                 <input type="checkbox"  id="choseAll_b"  />
                 <span class="checkmark"></span>
                </label>
           		</div>
           		<input type="hidden" name="action" value="updateState">
				<button type="submit" class="btn btn-warning submitAdd" name="product_state" value="1">批次上架</button>
           		</div>
				</FORM>
                  </div>
                  <div class="tab-pane fade" id="tab-2" role="tabpanel">
                 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product/product.do" style="margin-bottom: 0px;">
                   <table class="table">
  					<thead class="thead">
   					 <tr>
     				 <th scope="col">
     				   <div class="chose">
              			<label for="choseAll2">
                		 <input type="checkbox"  id="choseAll2"  />
                 		<span class="checkmark"></span>
              		  	</label>
           			  </div>
     				 </th>
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">商品名稱</th>
     				 <th scope="col">商品描述</th>
     				 <th scope="col">價格</th>
     				 <th scope="col">剩餘數量</th>
     				 <th scope="col">已售數量</th>
     				 <th scope="col">商品種類</th>
     				 <th scope="col">編輯</th>
  				  </tr>
 				 </thead>
 				 <tbody id="chose2">
 				 <c:forEach var="productVO" items="${list}" begin="0" end="${list.size()}" >
   				 	<c:if test="${productVO.user_id == userVO.getUser_id() && productVO.product_state == 1}"> 
   				 <tr>
     				 <th scope="row">
     				 	<div class="chose">
              				<label for="${productVO.product_no}">
                		 <input type="checkbox"  id="${productVO.product_no}" name="product_no" value="${productVO.product_no}" />
                 			<span class="checkmark"></span>
              		  		</label>
           				</div>	 
     				 </th>
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
   					 <td>
   					   <a href="<%=request.getContextPath()%>/ProductChange?action=getOne_For_Update&product_no=${productVO.product_no}" style="display:block;"><button type="button" class="btn btn-info">修改</button></a>
<%--    					   <button type="button" class="btn btn-danger"  data-id="${productVO.product_no}">刪除</button> --%>
   					 </td>   					
   				 </tr>
   				 	</c:if>
   				 </c:forEach>
   				 </tbody>
				</table>
				<div  class="fix-container" style="z-index: 999;">
           		<div class="choseAll">
             	  <label for="choseAll_b2">
                 	  全選
                 <input type="checkbox"  id="choseAll_b2"  />
                 <span class="checkmark"></span>
                </label>
           		</div>
           		<input type="hidden" name="action" value="updateState">
				<button type="submit" class="btn btn-warning" name="product_state" value="0">批次下架</button>
           		</div>
				</FORM>
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
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">商品名稱</th>
     				 <th scope="col">商品描述</th>
     				 <th scope="col">價格</th>
     				 <th scope="col">商品種類</th>
     				 <th scope="col">數量</th>
  				  </tr>
 				 </thead>
 				 <tbody>
 				 <c:forEach var="productVO" items="${list}" begin="0" end="${list.size()}">
   				 	<c:if test="${productVO.user_id == userVO.getUser_id() && productVO.product_state == 3}"> 
   				 <tr>
     				 <td>
     				 <a href="<%=request.getContextPath()%>/product/product.do?product_no=${productVO.product_no}" target="_blank">
     				 <img width="200px" height="200px" src="${pageContext.request.contextPath}/ProductShowPhoto?product_no=${productVO.product_no}" class="rounded mx-auto d-block" alt="">
     				 </a>
     				 </td>
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
     				 <th scope="col">商品圖片</th>
     				 <th scope="col">商品名稱</th>
     				 <th scope="col">商品描述</th>
     				 <th scope="col">檢舉時間</th>
     				 <th scope="col">違規原因</th>
  				  </tr>
 				 </thead>
 				 <tbody>
 				 <c:forEach var="productVO" items="${list}" begin="0" end="${list.size()}" >
   				 	<c:if test="${productVO.user_id == userVO.getUser_id() && productVO.product_state == 5}"> 
   				 <tr>
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
              <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.7/dist/sweetalert2.all.min.js"></script>
              
              <script>
              
//           	const productList = document.getElementById('productList');
//           	productList.addEventListener('click', event => {
// 				if (event.target.matches('.btn.btn-danger')){
//         			ajaxDelete(event.target.dataset.id);
//             	}
//         });

    			  
//     		function ajaxDelete (productNo) {
    			
//   				$.ajax({ 
//   				  type:"POST",
<%--   				  url:"<%=request.getContextPath()%>/product/product.do", --%>
//   				  data:{
//   					  "product_no": productNo,
//   					  "action": "delete"
//   				  },
//   				  success: function() {
//   					window.location.reload();
// 		  			Swal.fire({
// 			  			  icon: 'success',
// 			  			  title: '刪除成功',
// 			  			  showConfirmButton: false,
// 			  			  timer: 1500
// 			  			});
//   			      }, 	  
//   				  error:function () {
//   			  			Swal.fire({
//   				  			  icon: 'error',
//   				  			  title: '很抱歉,請重新點選',
//   				  			  showConfirmButton: false,
//   				  			  timer: 1000
//   				  			});
//   				  },				
//   				 });
//     		}	
  		  
    		var choseAll1 = document.getElementById("choseAll1");
    		var choseAll_b = document.getElementById("choseAll_b");
    		var chose1 = document.getElementById("chose1").getElementsByTagName("input");
    		
    		choseAll1.onclick = function() {
    			choseAll_b.checked = this.checked;
    			for(i = 0; i < chose1.length; i++) {
    				chose1[i].checked = this.checked;
    			}
    		}
    		
    		choseAll_b.onclick = function() {
    			choseAll1.checked = this.checked;
    			for(i = 0; i < chose1.length; i++) {
    				chose1[i].checked = this.checked;
    			}
    		}
    		
    		for (var i = 0; i < chose1.length; i++){
    			chose1[i].onclick = function() {
    				var flag = true;
    			for (var i = 0; i < chose1.length; i++){
    				if (!chose1[i].checked) {
    					flag = false;
    					}
    				}
    			choseAll1.checked = flag;
    			choseAll_b.checked = flag;
    			}
    		}
    		
    		var choseAll2 = document.getElementById("choseAll2");
    		var choseAll_b2 = document.getElementById("choseAll_b2");
    		var chose2 = document.getElementById("chose2").getElementsByTagName("input");
    		
    		choseAll2.onclick = function() {
    			choseAll_b2.checked = this.checked;
    			for(i = 0; i < chose2.length; i++) {
    				chose2[i].checked = this.checked;
    			}
    		}
    		
    		choseAll_b2.onclick = function() {
    			choseAll2.checked = this.checked;
    			for(i = 0; i < chose2.length; i++) {
    				chose2[i].checked = this.checked;
    			}
    		}
            
    		for (var i = 0; i < chose2.length; i++){
    			chose2[i].onclick = function() {
    				var flag = true;
    			for (var i = 0; i < chose2.length; i++){
    				if (!chose2[i].checked) {
    					flag = false;
    					}
    				}
    			choseAll2.checked = flag;
    			choseAll_b2.checked = flag;
    			}
    		}
              
              
              </script>
              
              
         </body>
         </html>