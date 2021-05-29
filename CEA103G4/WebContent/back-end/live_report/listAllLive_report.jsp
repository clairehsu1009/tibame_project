<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.live_report.model.*"%>

<%
	Live_reportService live_reportSvc = new Live_reportService();
	List<Live_reportVO> list = live_reportSvc.getAll();
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
<title>所有直播檢舉資料</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Main CSS-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/back-template/docs/css/main.css">
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">


</head>

<body class="app sidebar-mini rtl">
	<jsp:include page="/back-end/backendMenu.jsp" />
	<main class="app-content">
		<div class="app-title">
			<div>
				<h1>
					<i class="fa fa-th-list"></i> 所有直播檢舉
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
		<div class="row backProductList">
			<div class="product-tab col-lg-12">
				<div class="tab-item">
					<ul class="nav" role="tablist">
						<li><a class="active" data-toggle="tab" href="#tab-1"
							role="tab">未處理</a></li>
						<li><a data-toggle="tab" href="#tab-2" role="tab">審核通過</a></li>

						<li><a data-toggle="tab" href="#tab-3" role="tab">審核不通過</a></li>
					</ul>
				</div>
				<div class="tab-item-content">
					<div class="tab-content">
						<div class="tab-pane fade-in active" id="tab-1" role="tabpanel">
							<table class="table">
								<thead class="thead">
									<tr>
										<th scope="col">直播檢舉編號</th>
										<th scope="col">直播檢舉內容</th>
										<th scope="col">直播編號</th>
										<th scope="col">檢舉者帳號</th>
										<th scope="col">員工編號</th>
										<th scope="col">檢舉日期</th>
										<th scope="col">截圖</th>
										<th scope="col">檢舉處理狀態</th>
										<!-- 									<th scope="col">刪除檢舉</th> -->
									</tr>
								</thead>

								<tbody>
									<c:forEach var="live_reportVO" items="${list}" begin="0" end="${list.size()-1}">
										<c:if test="${live_reportVO.live_report_state == 0}">
											<tr>
												<td>${live_reportVO.live_report_no}</td>
												<td>${live_reportVO.live_report_content}</td>
												<td>${live_reportVO.live_no}</td>
												<td>${live_reportVO.user_id}</td>
												<td>${live_reportVO.empno}</td>
												<td><fmt:formatDate
														value="${live_reportVO.report_date}"
														pattern="yyyy-MM-dd HH:mm:ss" /></td>
												<td><img
													src="${pageContext.request.contextPath}/live_report/DBGifReader.do?live_report_no=${live_reportVO.live_report_no}"
													width="250px"></td>
												<td>
													<FORM METHOD="post"
														ACTION="<%=request.getContextPath()%>/live_report/live_report.do"
														name="form1" enctype="multipart/form-data">
														<select class="form-select" name="live_report_state">
															<option value="0"
																${(live_reportVO.live_report_state==0)? 'selected':''}>未處理</option>
															<option value="1"
																${(live_reportVO.live_report_state==1)? 'selected':''}>審核通過</option>
															<option value="2"
																${(live_reportVO.live_report_state==2)? 'selected':''}>審核不通過</option>
														</select> <input type="hidden" name="action" value="update">
														<input type="hidden" name="live_report_no" value="${live_reportVO.live_report_no }">
														<input type="hidden" name="live_no" value="${live_reportVO.live_no}">
														<button type="submit" class="btn btn-warning submitAdd"
															name="action" value="update">修改狀態</button>
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
										<th scope="col">直播檢舉編號</th>
										<th scope="col">直播檢舉內容</th>
										<th scope="col">直播編號</th>
										<th scope="col">檢舉者帳號</th>
										<th scope="col">員工編號</th>
										<th scope="col">檢舉日期</th>
										<th scope="col">截圖</th>
										<th scope="col">檢舉處理狀態</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="live_reportVO" items="${list}" begin="0" end="${list.size()-1}">
										<c:if test="${live_reportVO.live_report_state == 1}">
											<tr>
												<td>${live_reportVO.live_report_no}</td>
												<td>${live_reportVO.live_report_content}</td>
												<td>${live_reportVO.live_no}</td>
												<td>${live_reportVO.user_id}</td>
												<td>${live_reportVO.empno}</td>
												<td><fmt:formatDate
														value="${live_reportVO.report_date}"
														pattern="yyyy-MM-dd HH:mm:ss" /></td>
												<td><img
													src="${pageContext.request.contextPath}/live_report/DBGifReader.do?live_report_no=${live_reportVO.live_report_no}"
													width="250px"></td>
												<td>
												<c:choose>
									    		     <c:when test="${live_reportVO.live_report_state == 0}">
									       			            未處理
									   			     </c:when>
									   			     <c:when test="${live_reportVO.live_report_state == 1}">
									       				審核通過
									    			</c:when>
									    			<c:when test="${live_reportVO.live_report_state == 2}">
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
										<th scope="col">直播檢舉編號</th>
										<th scope="col">直播檢舉內容</th>
										<th scope="col">直播編號</th>
										<th scope="col">檢舉者帳號</th>
										<th scope="col">員工編號</th>
										<th scope="col">檢舉日期</th>
										<th scope="col">截圖</th>
										<th scope="col">檢舉處理狀態</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="live_reportVO" items="${list}" begin="0" end="${list.size()-1}">
										<c:if test="${live_reportVO.live_report_state == 2}">
											<tr>
												<td>${live_reportVO.live_report_no}</td>
												<td>${live_reportVO.live_report_content}</td>
												<td>${live_reportVO.live_no}</td>
												<td>${live_reportVO.user_id}</td>
												<td>${live_reportVO.empno}</td>
												<td><fmt:formatDate
														value="${live_reportVO.report_date}"
														pattern="yyyy-MM-dd HH:mm:ss" /></td>
												<td><img
													src="${pageContext.request.contextPath}/live_report/DBGifReader.do?live_report_no=${live_reportVO.live_report_no}"
													width="250px"></td>
												<td>
												<c:choose>
									    		     <c:when test="${live_reportVO.live_report_state == 0}">
									       			            未處理
									   			     </c:when>
									   			     <c:when test="${live_reportVO.live_report_state == 1}">
									       				審核通過
									    			</c:when>
									    			<c:when test="${live_reportVO.live_report_state == 2}">
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