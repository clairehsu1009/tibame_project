<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.qa.model.*"%>


<%
	QaService qaSvc = new QaService();
	List<QaVO> list = qaSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html lang="zxx">
  <head>
    <meta charset="UTF-8" />
    <meta name="description" content="Fashi Template" />
    <meta name="keywords" content="Fashi, unica, creative, html" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Q&A - Mode Femme</title>
    <!-- Google Font -->
    <link
      href="https://fonts.googleapis.com/css?family=Muli:300,400,500,600,700,800,900&display=swap"
      rel="stylesheet"
    />
    <!-- Css Styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/themify-icons.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/elegant-icons.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/owl.carousel.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/nice-select.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/jquery-ui.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/slicknav.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/front-template/css/style.css" type="text/css" />
    

  </head>

  <body>
	<!-- Header Section Begin -->
    <%@include file="/front-end/header.jsp"%>
	<!-- Header End -->

	<main _ngcontent-sc163="">
		<div class="breacrumb-section">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="breadcrumb-text">
							<a href="<%=request.getContextPath()%>/front-end/index.jsp"><i
								class="fa fa-home"></i> 回首頁</a> <span>Q&A</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<hr _ngcontent-sc209="" class="my-0">
		<div _ngcontent-sc209="" class="card-body" style="padding-top: 0px;">
		
		<div class="row backProductList">
			<div class="container col-lg-12">
				<div class="tab-item">
					<ul class="nav" role="tablist">
						<li><a class="active" data-toggle="tab" href="#tab-1" role="tab">帳務相關</a></li>
						<li><a data-toggle="tab" href="#tab-2" role="tab">商品相關</a></li>
						<li><a data-toggle="tab" href="#tab-3" role="tab">訂單相關</a></li>
						<li><a data-toggle="tab" href="#tab-4" role="tab">會員相關</a></li>
					</ul>
				</div>
				<div class="tab-item-content">
					<div class="tab-content">
						<div class="tab-pane fade-in active" id="tab-1" role="tabpanel">
							<table class="table">
								<thead class="thead">
									<tr>
										<th scope="col">日期</th>
										<th scope="col">問題</th>
										<th scope="col">解答</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach var="qaVO" items="${list}" begin="0" end="${list.size()-1}">
										<c:if test="${qaVO.qa_type == 1}">
											<tr>
												<td>${qaVO.qa_date}</td>
												<td>${qaVO.question}</td>
												<td>${qaVO.answer}</td>
											</tr>
										</c:if>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="tab-pane fade-in" id="tab-2" role="tabpanel">
							<table class="table">
								<thead class="thead">
									<tr>
										<th scope="col">日期</th>
										<th scope="col">問題</th>
										<th scope="col">解答</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach var="qaVO" items="${list}" begin="0" end="${list.size()-1}">
										<c:if test="${qaVO.qa_type == 2}">
											<tr>
												<td>${qaVO.qa_date}</td>
												<td>${qaVO.question}</td>
												<td>${qaVO.answer}</td>
											</tr>
										</c:if>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="tab-pane fade-in" id="tab-3" role="tabpanel">
							<table class="table">
								<thead class="thead">
									<tr>
										<th scope="col">日期</th>
										<th scope="col">問題</th>
										<th scope="col">解答</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach var="qaVO" items="${list}" begin="0" end="${list.size()-1}">
										<c:if test="${qaVO.qa_type == 3}">
											<tr>
												<td>${qaVO.qa_date}</td>
												<td>${qaVO.question}</td>
												<td>${qaVO.answer}</td>
											</tr>
										</c:if>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="tab-pane fade-in" id="tab-4" role="tabpanel">
							<table class="table">
								<thead class="thead">
									<tr>
										<th scope="col">日期</th>
										<th scope="col">問題</th>
										<th scope="col">解答</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach var="qaVO" items="${list}" begin="0" end="${list.size()-1}">
										<c:if test="${qaVO.qa_type == 4}">
											<tr>
												<td>${qaVO.qa_date}</td>
												<td>${qaVO.question}</td>
												<td>${qaVO.answer}</td>
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
		</div>
		<hr _ngcontent-sc209="" class="my-0">
		<div _ngcontent-sc209="" class="card-body px-5 py-4">
		</div>
	</main>
	
	<!-- Footer Section Begin -->
	<%@include file="/front-end/footer.jsp"%>
    <!-- Footer Section End -->
    
    <!-- Js Plugins -->
    <script src="${pageContext.request.contextPath}/front-template/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.countdown.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.nice-select.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.zoom.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.dd.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/jquery.slicknav.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/main.js"></script>
    <script src="${pageContext.request.contextPath}/front-template/js/ajaxSearch.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.7/dist/sweetalert2.all.min.js"></script>
  </body>
</html>
