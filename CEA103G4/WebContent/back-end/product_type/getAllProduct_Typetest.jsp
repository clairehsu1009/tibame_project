<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*,org.json.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.product_type.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	Product_TypeDAO dao = new Product_TypeDAO();
    List<Product_TypeVO> list = dao.getAll();
    pageContext.setAttribute("list",list);
    
    JSONArray jsonArray = new JSONArray();
    JSONObject obj = new JSONObject();   
    
%>

	<c:forEach var="obj" items="${list}" >
		
	</c:forEach>