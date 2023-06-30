<%@ page import="model.IProductDao" %>
<%@ page import="model.ProductDaoDataSource" %>
<%@ page import="model.ProductBean" %>
<%@ page import="java.util.Collection" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>yourPCBuddy</title>
</head>
<body>
<div class="header">
<h1>yourPCBuddy</h1>
<img src="./Images/PCBuddy.png" alt="logo sito">
<p>Benvenuti su yourPCBuddy</p>
</div>
	<form action="LoginScreen.jsp" method="POST">
	
	<input type="submit" value="accedi">	
	</form>
</body>
</html>