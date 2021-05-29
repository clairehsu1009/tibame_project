 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
  <header class="header-section">
					<div class="logo">
					<div class="logoName">
						<a href="${pageContext.request.contextPath}/front-end/index.jsp">
							<h2>
								Mode femme <br />
								<small>Second&nbsp;Hand </small>
							</h2>
						</a>
						</div>
					</div>
    <!-- Sidebar toggle button-->
    <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
	<div class="nav-item">
		<div class="headerBtn"><a href="<%=request.getContextPath()%>/front-end/productsell/shop.jsp">商品專區</a></div>
		<div class="headerBtn"><a href="<%=request.getContextPath()%>/front-end/live/liveWall.jsp">直播專區</a></div>
	</div>
    <!-- Navbar Right Menu-->
    <ul class="app-nav">
      <!--Notification Menu-->
      <li class="dropdown"><a class="app-nav__item" href="#" data-toggle="dropdown" aria-label="Show notifications"><i class="fa fa-bell-o fa-lg"></i></a>
        <ul class="app-notification dropdown-menu dropdown-menu-right">
          <li class="app-notification__title">You have 4 new notifications.</li>
          <div class="app-notification__content">
            <li><a class="app-notification__item" href="javascript:;"><span class="app-notification__icon"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x text-primary"></i><i class="fa fa-envelope fa-stack-1x fa-inverse"></i></span></span>
              <div>
                <p class="app-notification__message">Lisa sent you a mail</p>
                <p class="app-notification__meta">2 min ago</p>
              </div></a></li>
              <li><a class="app-notification__item" href="javascript:;"><span class="app-notification__icon"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x text-danger"></i><i class="fa fa-hdd-o fa-stack-1x fa-inverse"></i></span></span>
                <div>
                  <p class="app-notification__message">Mail server not working</p>
                  <p class="app-notification__meta">5 min ago</p>
                </div></a></li>
                <li><a class="app-notification__item" href="javascript:;"><span class="app-notification__icon"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x text-success"></i><i class="fa fa-money fa-stack-1x fa-inverse"></i></span></span>
                  <div>
                    <p class="app-notification__message">Transaction complete</p>
                    <p class="app-notification__meta">2 days ago</p>
                  </div></a></li>
                  <div class="app-notification__content">
                    <li><a class="app-notification__item" href="javascript:;"><span class="app-notification__icon"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x text-primary"></i><i class="fa fa-envelope fa-stack-1x fa-inverse"></i></span></span>
                      <div>
                        <p class="app-notification__message">Lisa sent you a mail</p>
                        <p class="app-notification__meta">2 min ago</p>
                      </div></a></li>
                      <li><a class="app-notification__item" href="javascript:;"><span class="app-notification__icon"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x text-danger"></i><i class="fa fa-hdd-o fa-stack-1x fa-inverse"></i></span></span>
                        <div>
                          <p class="app-notification__message">Mail server not working</p>
                          <p class="app-notification__meta">5 min ago</p>
                        </div></a></li>
                        <li><a class="app-notification__item" href="javascript:;"><span class="app-notification__icon"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x text-success"></i><i class="fa fa-money fa-stack-1x fa-inverse"></i></span></span>
                          <div>
                            <p class="app-notification__message">Transaction complete</p>
                            <p class="app-notification__meta">2 days ago</p>
                          </div></a></li>
                        </div>
                      </div>
                      <li class="app-notification__footer"><a href="#">See all notifications.</a></li>
                    </ul>
                  </li>
                  <!-- User Menu-->
                  <li class="dropdown"><a class="app-nav__item" href="#" data-toggle="dropdown" aria-label="Open Profile Menu"><i class="fa fa-user fa-lg"></i></a>
                    <ul class="dropdown-menu settings-menu dropdown-menu-right">
<!--                       <li><a class="dropdown-item" href="page-user.html"><i class="fa fa-cog fa-lg"></i> Settings</a></li> -->
                      <FORM id="getOneUser2" METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/user/user.do">
				      <input type="hidden" name="user_id"  value="${userVO.user_id}">
				      <input type="hidden" name="action"	value="getOne_For_Display">
				      <li><a class="dropdown-item" href="#" onclick="document.getElementById('getOneUser2').submit();"><i class="fa fa-user fa-lg"></i> Profile</a></li>
				     </FORM>
				     <FORM id="userLogOut" METHOD="post" class="logout-form" action="<%=request.getContextPath()%>/User_LogoutHandler">
				     <input type="hidden" name="action" value="signOut">
                      <li><a class="dropdown-item" href="#" onclick="document.getElementById('userLogOut').submit();"><i class="fa fa-sign-out fa-lg"></i> Logout</a></li>
                      </FORM>
                    </ul>
                  </li>
                </ul>
              </header>
              
              
              <!-- Sidebar menu-->
              <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
              <aside class="app-sidebar">
                <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" style="width:100px;height:100px;" src="${pageContext.request.contextPath}/UserShowPhoto?user_id=${userVO.user_id}" alt="User Image">
                  <div>
                    <p class="app-sidebar__user-designation" style="font-size:20px;">Welcome</p>
                    <p class="app-sidebar__user-name">${userVO.user_name}</p>
                  </div>
                </div>
                <ul class="app-menu">
                  <li><a class="app-menu__item" href="<%=request.getContextPath()%>/front-end/protected/userIndex.jsp"><i class="app-menu__icon fa fa-user fa-lg"></i><span class="app-menu__label">會員首頁</span></a></li>
                  <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-address-book-o"></i><span class="app-menu__label">會員資料管理</span><i class="treeview-indicator fa fa-angle-right"></i></a>  
                    <ul class="treeview-menu">
                    <FORM id="getOneUser" METHOD="post" ACTION="<%=request.getContextPath()%>/front-end/user/user.do" style="margin-bottom: 0px;">
				     <input type="hidden" name="user_id"  value="${userVO.user_id}">
				     <input type="hidden" name="action"	value="getOne_For_Display">
				     <li><a class="treeview-item" href="#" onclick="document.getElementById('getOneUser').submit();"><i class="icon fa fa-file-text-o"></i> 個人檔案</a></li>
				     </FORM>
                     <li><a class="treeview-item" href="<%=request.getContextPath()%>/front-end/user/updateUserPwd.jsp"><i class="icon fa fa-edit"></i> 更改密碼</a></li>        
                     <li><a class="treeview-item" href="<%=request.getContextPath()%>/front-end/user/addUserCash.jsp"><i class="icon fa fa-dollar"></i>我的錢包</a></li>        
                    </ul>     
                  </li>       
                  <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-shopping-bag"></i><span class="app-menu__label">商品管理</span><i class="treeview-indicator fa fa-angle-right"></i></a>
                    <ul class="treeview-menu">
                      <li><a class="treeview-item" href="<%=request.getContextPath()%>/front-end/productManagement/productList.jsp"><i class="icon fa fa-archive"></i>我的商品</a></li>
                      <li><a class="treeview-item" href="<%=request.getContextPath()%>/front-end/productManagement/productAdd.jsp"><i class="icon fa fa-edit"></i>新增商品</a></li>
                    </ul>
                  </li>
                  
                  <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-cogs"></i><span class="app-menu__label">直售訂單管理</span><i class="treeview-indicator fa fa-angle-right"></i></a>
                    <ul class="treeview-menu">
                      <li><a class="treeview-item" href="<%=request.getContextPath()%>/front-end/orderManagement/OrderListA.jsp"><i class="icon fa fa-th-list"></i>我的購買訂單</a></li>
                      <li><a class="treeview-item" href="<%=request.getContextPath()%>/front-end/orderManagement/OrderListB.jsp"><i class="icon fa fa-th-list"></i>我的販賣訂單</a></li>
                    </ul>
                  </li>
                  <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-cogs"></i><span class="app-menu__label">直播訂單管理</span><i class="treeview-indicator fa fa-angle-right"></i></a>
                    <ul class="treeview-menu">
                      <li><a class="treeview-item" href="<%=request.getContextPath()%>/front-end/liveOrderManagement/liveOrderListA.jsp"><i class="icon fa fa-th-list"></i>我的購買訂單</a></li>
                      <li><a class="treeview-item" href="<%=request.getContextPath()%>/front-end/liveOrderManagement/liveOrderListB.jsp"><i class="icon fa fa-th-list"></i>我的販賣訂單</a></li>
                    </ul>
                  </li>
                  <li class="treeview"><a class="app-menu__item" href="#" data-toggle="treeview"><i class="app-menu__icon fa fa-file-text"></i><span class="app-menu__label">直播專案管理</span><i class="treeview-indicator fa fa-angle-right"></i></a>
                    <ul class="treeview-menu">
                      <li>
                      <a class="treeview-item" href="<%=request.getContextPath()%>/front-end/liveManagement/liveAdd.jsp"><i class="icon fa fa-edit"></i>新增直播專案</a>
                      <li>
                      <li><a class="treeview-item" href='<%=request.getContextPath()%>/front-end/liveManagement/liveList.jsp'><i class="icon fa fa-th-list"></i>我的直播專案</a></li>
                      <li>
                      <a class="treeview-item" href="<%=request.getContextPath()%>/front-end/liveManagement/liveHistory.jsp"><i class="icon fa fa-archive"></i>我的歷史專案</a>
                      <li>
                    </ul>
                  </li>
                  <li class="treeview">
                  <a class="app-menu__item" href="<%=request.getContextPath()%>/SellerProducts?user_id=${userVO.user_id}" target="_blank"><i class="app-menu__icon fa fa-diamond"></i><span class="app-menu__label">前往我的賣場</span><i class="treeview-indicator fa fa-angle-right"></i></a></li>
				<li class="treeview">
						<form id="myForm" action="<%=request.getContextPath()%>/userChat.do"
							method="POST">
							<input value="${userVO.user_id}" name="userName" type="hidden" />
							<a class="app-menu__item" href="#" onclick="document.getElementById('myForm').submit();"><i
								class="fa fa-comment-o">&nbsp;&nbsp;&nbsp;</i><span class="app-menu__label">線上客服&nbsp;</span><i class="treeview-indicator fa fa-angle-right"></i></a>
						</form>
					</li>
                </ul>
              </aside>
               