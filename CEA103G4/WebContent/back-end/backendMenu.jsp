<%@page import="com.auth.model.AuthVO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.emp.model.*"%>
<%@ page import="com.fun.model.*"%>
<%@ page import="com.auth.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*" %>


<%
    EmpVO empVO = (EmpVO) session.getAttribute("empAccount");
    session.setAttribute("empVO", empVO);
    FunVO funVO = (FunVO) request.getAttribute("funVO");
    List<AuthVO> authList = (List<AuthVO>) session.getAttribute("authList");
	session.setAttribute("authList", authList);
%>

<!-- Navbar-->
<header class="app-header">
    <a class="app-header__logo"
        href="<%=request.getContextPath()%>/back-end/backendIndex.jsp">Mode Femme</a>
    <!-- Sidebar toggle button-->
    <a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
        aria-label="Hide Sidebar"></a>
    <!-- Navbar Right Menu-->
     <ul class="app-nav">
<!--         <li class="app-search"> -->
<%--          <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" > --%>
<!--         <input class="app-search__input" name="empno"  type="search" placeholder="Search"> -->
<!--         <input type="hidden" name="action" value="getOne_For_Display"> -->
<!--             <button class="app-search__button"> -->
<!--                 <i class="fa fa-search"></i> -->
<!--             </button> -->
<!--         </FORM> -->
<!--             </li> -->
        <!--Notification Menu-->
<!--         <li class="dropdown"><a class="app-nav__item" href="#" -->
<!--             data-toggle="dropdown" aria-label="Show notifications"><i -->
<!--                 class="fa fa-bell-o fa-lg"></i></a> -->
            <ul class="app-notification dropdown-menu dropdown-menu-right">
                <li class="app-notification__title">You have 4 new
                    notifications.</li>
                <div class="app-notification__content">
                    <li><a class="app-notification__item" href="javascript:;"><span
                            class="app-notification__icon"><span
                                class="fa-stack fa-lg"><i
                                    class="fa fa-circle fa-stack-2x text-primary"></i><i
                                    class="fa fa-envelope fa-stack-1x fa-inverse"></i></span></span>
                            <div>
                                <p class="app-notification__message">Lisa sent you a mail</p>
                                <p class="app-notification__meta">2 min ago</p>
                            </div></a></li>
                    <li><a class="app-notification__item" href="javascript:;"><span
                            class="app-notification__icon"><span
                                class="fa-stack fa-lg"><i
                                    class="fa fa-circle fa-stack-2x text-danger"></i><i
                                    class="fa fa-hdd-o fa-stack-1x fa-inverse"></i></span></span>
                            <div>
                                <p class="app-notification__message">Mail server not working</p>
                                <p class="app-notification__meta">5 min ago</p>
                            </div></a></li>
                    <li><a class="app-notification__item" href="javascript:;"><span
                            class="app-notification__icon"><span
                                class="fa-stack fa-lg"><i
                                    class="fa fa-circle fa-stack-2x text-success"></i><i
                                    class="fa fa-money fa-stack-1x fa-inverse"></i></span></span>
                            <div>
                                <p class="app-notification__message">Transaction complete</p>
                                <p class="app-notification__meta">2 days ago</p>
                            </div></a></li>
                    <div class="app-notification__content">
                        <li><a class="app-notification__item" href="javascript:;"><span
                                class="app-notification__icon"><span
                                    class="fa-stack fa-lg"><i
                                        class="fa fa-circle fa-stack-2x text-primary"></i><i
                                        class="fa fa-envelope fa-stack-1x fa-inverse"></i></span></span>
                                <div>
                                    <p class="app-notification__message">Lisa sent you a mail</p>
                                    <p class="app-notification__meta">2 min ago</p>
                                </div></a></li>
                        <li><a class="app-notification__item" href="javascript:;"><span
                                class="app-notification__icon"><span
                                    class="fa-stack fa-lg"><i
                                        class="fa fa-circle fa-stack-2x text-danger"></i><i
                                        class="fa fa-hdd-o fa-stack-1x fa-inverse"></i></span></span>
                                <div>
                                    <p class="app-notification__message">Mail server not
                                        working</p>
                                    <p class="app-notification__meta">5 min ago</p>
                                </div></a></li>
                        <li><a class="app-notification__item" href="javascript:;"><span
                                class="app-notification__icon"><span
                                    class="fa-stack fa-lg"><i
                                        class="fa fa-circle fa-stack-2x text-success"></i><i
                                        class="fa fa-money fa-stack-1x fa-inverse"></i></span></span>
                                <div>
                                    <p class="app-notification__message">Transaction complete</p>
                                    <p class="app-notification__meta">2 days ago</p>
                                </div></a></li>
                    </div>
                </div>
                <li class="app-notification__footer"><a href="#">See all
                        notifications.</a></li>
            </ul></li>
        <!-- User Menu-->
        <li class="dropdown"><a class="app-nav__item" href="#"
            data-toggle="dropdown" aria-label="Open Profile Menu"><i
                class="fa fa-user fa-lg"></i></a>
            <ul class="dropdown-menu settings-menu dropdown-menu-right">
<!--                 <li><a class="dropdown-item" href="page-user.html"><i -->
<!--                         class="fa fa-cog fa-lg"></i> Settings</a></li> -->
                <li><a class="dropdown-item"
                    href="<%=request.getContextPath()%>/emp/emp.do?empno=${empVO.empno}&action=getOne_For_Display"><i
                        class="fa fa-user fa-lg"></i> Profile ${empVO.ename} </a></li>
                <li><FORM id="userLogOut" METHOD="post" class="logout-form"
                        action="<%=request.getContextPath()%>/loginhandler">
                        <input type="hidden" name="action" value="signOut"> <a
                            class="dropdown-item" href="#"
                            onclick="document.getElementById('userLogOut').submit();"><i
                            class="fa fa-sign-out fa-lg"></i> Logout</a>
                    </FORM></li>
            </ul></li>
    </ul>
</header>
<!-- Sidebar menu-->
<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
<aside class="app-sidebar">
    <div class="app-sidebar__user">
        <img class="app-sidebar__user-avatar" width="45px" height="40px" src="<%=request.getContextPath()%>/back-end/emp/img/empImg.png" alt="User Image">
        <div>
            <p class="app-sidebar__user-name">${empVO.ename}</p>
            <p class="app-sidebar__user-designation"></p>
        </div>
    </div>
    <ul class="app-menu">
        <li class="treeview disabled"><a class="app-menu__item active" href="#"
            data-toggle="treeview"><i class="app-menu__icon fa fa-group"></i><span
                class="app-menu__label" >員工管理</span><i
                class="treeview-indicator fa fa-angle-right"></i></a>
            <ul class="treeview-menu">
                <li><a class="treeview-item"
                    href="<%=request.getContextPath()%>/back-end/emp/listAllEmp.jsp"><i
                        class="icon fa fa-group"></i>所有員工</a></li>
                <li><a class="treeview-item"
                    href="<%=request.getContextPath()%>/back-end/emp/addEmp.jsp">
                    <i class="icon 	fa fa-handshake-o"></i>新增員工</a></li>
            </ul></li>

        <li class="treeview disabled"><a class="app-menu__item" href="#"
            data-toggle="treeview"><i class="app-menu__icon fa fa-laptop"></i><span
                class="app-menu__label">權限管理</span><i
                class="treeview-indicator fa fa-angle-right"></i></a>
            <ul class="treeview-menu">

                <li><a class="treeview-item"
                    href="<%=request.getContextPath()%>/back-end/fun/listAllFun.jsp"><i
                        class="icon fa fa-laptop"></i>員工權限管理</a></li>
                <!--                <li><a class="treeview-item" -->
                <%--                    href="<%=request.getContextPath()%>/back-end/fun/listAllFun.jsp"><i --%>
                <!--                        class="icon fa fa-circle-o"></i>功能管理</a></li> -->
            </ul></li>

        <li class="treeview"><a class="app-menu__item active" href="#"
            data-toggle="treeview"><i class="app-menu__icon fa fa-dashboard"></i><span
                class="app-menu__label">會員管理</span><i
                class="treeview-indicator fa fa-angle-right"></i></a>
            <ul class="treeview-menu">
                <li><a class="treeview-item" href="<%=request.getContextPath()%>/back-end/user/listAllUser.jsp"><i
                        class="icon fa fa-circle-o"></i>所有會員</a></li>
            </ul></li>

        <li class="treeview"><a class="app-menu__item" href="#"
            data-toggle="treeview"><i class="app-menu__icon fa fa-edit"></i><span
                class="app-menu__label">直播管理</span><i
                class="treeview-indicator fa fa-angle-right"></i></a>
            <ul class="treeview-menu">
                <li><a class="treeview-item"
                    href="<%=request.getContextPath()%>/back-end/liveManagement/listAllLive.jsp"><i
                        class="icon fa fa-circle-o"></i>所有直播專案</a></li>
                <li><a class="treeview-item"
                    href="<%=request.getContextPath()%>/back-end/liveManagement/listAllLiveProduct.jsp"><i
                        class="icon fa fa-circle-o"></i> 所有直播商品</a></li>
            </ul></li>
		<li class="treeview"><a class="app-menu__item" href="#"
			data-toggle="treeview"><i class="app-menu__icon fa fa-shopping-bag"></i><span
				class="app-menu__label">直售商品管理</span><i
				class="treeview-indicator fa fa-angle-right"></i></a>
			<ul class="treeview-menu">
				<li><a class="treeview-item"
					href="<%=request.getContextPath()%>/back-end/productManagement/backProductType.jsp"><i
						class="icon fa fa-folder-open-o"></i>商品類別管理</a></li>
				<li><a class="treeview-item"
					href="<%=request.getContextPath()%>/back-end/productManagement/backProductList.jsp"><i class="fa fa-archive">&nbsp;</i>所有直售商品</a></li>
			</ul></li>
		<li class="treeview"><a class="app-menu__item" href="#"
			data-toggle="treeview"><i class="app-menu__icon fa fa-exclamation-circle"></i><span
				class="app-menu__label">直售檢舉管理</span><i
				class="treeview-indicator fa fa-angle-right"></i></a>
			<ul class="treeview-menu">
				<li><a class="treeview-item"
					href="<%=request.getContextPath()%>/back-end/product_report/getAllUserReport.jsp"><i
						class="icon fa fa-exclamation-circle"></i> 直售商品檢舉</a></li>
			</ul></li>
        <li class="treeview"><a class="app-menu__item" href="#"
            data-toggle="treeview"><i class="app-menu__icon fa fa-th-list"></i><span
                class="app-menu__label">直播檢舉管理</span><i
                class="treeview-indicator fa fa-angle-right"></i></a>
            <ul class="treeview-menu">
                <li><a class="treeview-item"
                    href="<%=request.getContextPath()%>/back-end/live_report/listAllLive_report.jsp"><i
                        class="icon fa fa-circle-o"></i> 所有直播檢舉</a></li>
                <li><a class="treeview-item"
                    href="<%=request.getContextPath()%>/back-end/live_report/addLive_report.jsp"><i
                        class="icon fa fa-circle-o"></i> 新增直播檢舉</a></li>
            </ul></li>
        <li class="treeview"><a class="app-menu__item" href="#"
            data-toggle="treeview"><i class="app-menu__icon fa fa-file-text"></i><span
                class="app-menu__label">Q&A管理</span><i
                class="treeview-indicator fa fa-angle-right"></i></a>
            <ul class="treeview-menu">
                <li><a class="treeview-item" href="<%=request.getContextPath()%>/back-end/qa/listAllQa.jsp"><i
                        class="icon fa fa-circle-o"></i> 所有Q&A</a></li>
                <li><a class="treeview-item" href="<%=request.getContextPath()%>/back-end/qa/addQa.jsp"><i
                        class="icon fa fa-circle-o"></i> 新增Q&A</a></li>
            </ul></li>
        <li class="treeview"><a class="app-menu__item" href="#"
            data-toggle="treeview"><i class="app-menu__icon fa fa-pie-chart"></i><span
                class="app-menu__label">客服管理</span><i
                class="treeview-indicator fa fa-angle-right"></i></a>
            <ul class="treeview-menu">
                <li>		
                <form  id="myForm" action="<%=request.getContextPath() %>/chat.do" method="POST"	>
				<input value="${empVO.empno}" name="empName" type="hidden"/> 
<%-- 				<a  class="treeview-item" href="<%=request.getContextPath()%>/back-end/customer_service/chat.jsp"> --%>
				<a  class="treeview-item" href="#" onclick="document.getElementById('myForm').submit();">
				<i  class="icon fa fa-circle-o">
				</i> 客服訊息</a>
				</form>
				</li>

            </ul></li>
<!--         <li class="treeview"><a class="app-menu__item" href="#" -->
<!--             data-toggle="treeview"><i class="app-menu__icon fa fa-file-text"></i><span -->
<!--                 class="app-menu__label">廣告管理</span><i -->
<!--                 class="treeview-indicator fa fa-angle-right"></i></a> -->
<!--             <ul class="treeview-menu"> -->
<!--                 <li><a class="treeview-item" -->
<%--                     href="<%=request.getContextPath()%>/back-end/ad/listAllAd.jsp"><i --%>
<!--                         class="icon fa fa-circle-o"></i> 所有廣告</a></li> -->
<!--                 <li><a class="treeview-item" -->
<%--                     href="<%=request.getContextPath()%>/back-end/ad/addAd.jsp"><i --%>
<!--                         class="icon fa fa-circle-o"></i> 新增廣告</a></li> -->
<!--             </ul></li> -->
        <!--        <li><a class="app-menu__item" href="charts.html"><i
                class="app-menu__icon fa fa-pie-chart"></i><span
                class="app-menu__label">Charts</span></a></li> -->
    </ul>
</aside>

<script>
<c:forEach var="authList" items="${authList}">
var index = parseInt('${authList.getFunno()}')-15001;
var tree = document.getElementsByClassName("treeview")[index]
	if(`${authList.getAuth_no()}`=='0'){
		tree.style.display="none";
//		tree.classList.add("disabled");
	}
	
// arr1.push(`${authList.getFunno()}`);

</c:forEach>
</script>