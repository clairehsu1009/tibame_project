<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.qa.model.*"%>

<%
	QaService qaSvc = new QaService();
	List<QaVO> list = qaSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html lang="zh-tw">
<head>
<meta name="description"
	content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
<!-- Twitter meta-->
<meta property="twitter:card" content="summary_large_image">
<meta property="twitter:site" content="@pratikborsadiya">
<meta property="twitter:creator" content="@pratikborsadiya">
<!-- Open Graph Meta-->
<meta property="og:type" content="website">
<meta property="og:site_name" content="Vali Admin">
<meta property="og:title" content="Vali - Free Bootstrap 4 admin theme">
<meta property="og:url"
	content="http://pratikborsadiya.in/blog/vali-admin">
<meta property="og:image"
	content="http://pratikborsadiya.in/blog/vali-admin/hero-social.png">
<meta property="og:description"
	content="Vali is a responsive and free admin theme built with Bootstrap 4, SASS and PUG.js. It's fully customizable and modular.">
<title>所有Q&A資料</title>
<link rel="icon"
	href="${pageContext.request.contextPath}/front-template/images/favicon.ico"
	type="image/x-icon">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Main CSS-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/back-template/docs/css/main.css">
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
.form-control {
    border: none;
    background: white !important;
    margin-top: -10px;
    margin-left: -12px;
    resize: none;
    white-space: pre-wrap;
    font-size: 0.875rem;
    font-weight: 400;
    line-height: 1.5;
    color: #212529;
    padding-top: 10px;
    box-sizing: border-box;
}
</style>
</head>
<body class="app sidebar-mini rtl">
	<jsp:include page="/back-end/backendMenu.jsp" />
	<main class="app-content">
		<div class="app-title">
			<div>
				<h1>
					<i class="fa fa-file-text"></i> Q&A管理
				</h1>

			</div>
			<ul class="app-breadcrumb breadcrumb">
				<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
				<li class="breadcrumb-item"><a
					href="<%=request.getContextPath()%>/back-end/backendIndex.jsp">回到首頁</a></li>
			</ul>
		</div>
		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>

		<div class="row">
			<div class="col-md-12">
				<div class="tile">
					<div class="tile-body">
						<table class="table table-hover" id="sampleTable"
							style="font-size: 120%">
							<thead>
								<tr role="row" class="table-info">
									<th class="sorting_asc">Q&A編號</th>
									<th>Q&A類型</th>
									<th>員工編號</th>
									<th>建立日期</th>
									<th>問題</th>
									<th>解答</th>
									<th></th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<%@ include file="page1.file"%>
								<c:forEach var="qaVO" items="${list}" begin="<%=pageIndex%>"
									end="<%=pageIndex+rowsPerPage-1%>">

									<tr>
										<td>${qaVO.qa_no}</td>
										<td>${(qaVO.qa_type==1)? '帳務相關':''}
											${(qaVO.qa_type==2)? '商品相關':''}
											${(qaVO.qa_type==3)? '訂單相關':''}
											${(qaVO.qa_type==4)? '會員相關':''}
										</td>
										<td>${qaVO.empno}</td>
										<td><fmt:formatDate value="${qaVO.qa_date}"
												pattern="yyyy-MM-dd" /></td>
										<td>${qaVO.question}</td>
										<td><textarea class="form-control" maxlength="300" rows="5" readonly>${qaVO.answer}</textarea></td>
										<td>
											<FORM METHOD="post"
												ACTION="<%=request.getContextPath()%>/QaServlet"
												style="margin-bottom: 0px;">
												<input class="btn btn-info" type="submit" value="修改">
												<input type="hidden" name="qa_no" value="${qaVO.qa_no}"> 
												<input type="hidden" name="action" value="getOne_For_Update">
											</FORM>
										</td>
											<td>
												<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/QaServlet" style="margin-bottom: 0px;">
													<input class="btn btn-info" type="submit" value="刪除">
													<input type="hidden" name="qa_no"  value="${qaVO.qa_no}">
													<input type="hidden" name="action" value="delete">
												</FORM>
											</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="page2.file"%>
	</main>
	<jsp:include page="/back-end/backendfooter.jsp" />
</body>
</html>