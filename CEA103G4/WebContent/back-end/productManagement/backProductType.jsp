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
  <title>Mode Femme 商品類別管理</title>
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
                    <h1><i class="fa fa-folder-open-o">&nbsp;</i>所有商品類別</h1>
                  </div>
                 
                  <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
                    <li class="breadcrumb-item"><a href=""<%=request.getContextPath()%>/back-end/productManagement/backProductType.jsp"">商品類別管理</a></li>
                  </ul>
                </div>
                <div class="row backProductList">
             <div class="product-tab col-lg-12">

              <div class="tab-item-content">
                <div class="tab-content">
                 <table class="table">
  					<thead class="thead">
   					 <tr>
     				 <th scope="col">商品類別編號</th>
     				 <th scope="col">商品類別名稱</th>
     				 <th scope="col">編輯</th>
     				 <th scope="col"><a href="javascript:;"><button type="button" class="btn btn-warning"  name="pdtype_no" id="pdtype_noLink"  value="">新增商品類別</button></a></th>
  				  </tr>
 				 </thead>
 				 <tbody>
 				 <c:forEach var="product_typeVO" items="${list}" begin="0" end="${list.size()-1}">
   				 <tr class="changePdtype">
					<td>${product_typeVO.pdtype_no}</td>
					<td>${product_typeVO.pdtype_name}</td>
					<td>
   					 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product_type/product_type.do" style="margin-bottom: 0px;">
   					   <input type="hidden" name="pdtype_no"  value="${product_typeVO.pdtype_no}" />
   					   <input type="hidden" name="pdtype_name"  value="${product_typeVO.pdtype_name}" />
   					   <button type="submit" class="btn btn-info submitAdd">修改</button>
			     	   <input type="hidden" name="action" value="getOne_For_Update">
   					 </FORM>
   					 </td>
   					 </tr>
   				 </c:forEach>
   				 </tbody>
   			<%-- 新增錯誤表列 --%>
				<c:if test="${not empty errorMsgs}">
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
					<li style="color:red; list-style-type:none;">${message}</li>
					</c:forEach>
				</ul>
			  </c:if>
				</table>
              </div>
            </div>
               				                      <!--燈箱 -->
<div  class="backProductType-bg">
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/product_type/product_type.do" name="form1">
 <div class="productType">
      <div class="productType-title">
    	新增商品類別
        <span><a href="javascript:;" id="closeBtn">關閉</a></span>
      </div>
      <div class="productType-input-content">
        <div class="productType-input">
          <label for="pdtype_name">商品類別</label>
          <input
            type="text"
            placeholder="請輸入商品類別名稱"
            name="pdtype_name"
            id="pdtype_name"
            size="50"
            value="<%= (product_typeVO==null)? "" : product_typeVO.getPdtype_name()%>"
          required>
        </div>
      </div>
       <input type="hidden" name="action" value="insert">
       <button type="submit" class="productType-button" id="productType-submit">送出新增</button>
    </div>
    </FORM>
    </div>
    <!--遮蓋層-->
<!--     燈箱結束 -->
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

		<script>
		
		//檢舉燈箱js 

		 var pdtype_noLink = document.querySelector("#pdtype_noLink");
		  var closeBtn = document.querySelector("#closeBtn");
		  var productType = document.querySelector(".productType");
		  var backProductType_bg = document.querySelector(".backProductType-bg");

		  //1,燈箱顯示/隱藏

		  pdtype_noLink.addEventListener('click', () => {
			productType.style.display = "block";
		    backProductType_bg.style.display = "block";
		  });
		  closeBtn.addEventListener("click", function () {
		    productType.style.display = "none";
		    backProductType_bg.style.display = "none";
		  });

		  //2，拖曳
		  var productType_title = document.querySelector(".productType-title");
		  productType_title.addEventListener("mousedown", function (e) {
		    //鼠標按下的時候,得到鼠標在框裡的座標
		    var x = e.pageX - productType.offsetLeft;
		    var y = e.pageY - productType.offsetTop;
		    document.addEventListener("mousemove", move); //鼠標移動的時候，得到狀態框座標
		    function move(e) {
		      productType.style.left = e.pageX - x + "px";
		      productType.style.top = e.pageY - y + "px";
		    }
		    document.addEventListener("mouseup", function () {
		      //鼠標彈起,解除移動事件
		      document.removeEventListener("mousemove", move);
		    });
		  });


		
		
		</script>



         </body>
         </html>