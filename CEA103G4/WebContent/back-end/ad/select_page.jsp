<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Ad: Home</title>

<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>IBM Ad: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for IBM Ad: Home</p>

<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='listAllAd.jsp'>List</a> all Ads.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/ad/ad.do" >
        <b>輸入廣告編號 (如18001):</b>
        <input type="text" name="ad_no">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="adSvc" scope="page" class="com.ad.model.AdService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back-end/ad/ad.do" >
       <b>選擇廣告編號:</b>
       <select size="1" name="ad_no">
         <c:forEach var="adVO" items="${adSvc.all}" > 
          <option value="${adVO.ad_no}">${adVO.ad_no}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
</ul>


<h3>廣告管理</h3>

<ul>
  <li><a href='addAd.jsp'>Add</a> a new Ad.</li>
</ul>

</body>
</html>