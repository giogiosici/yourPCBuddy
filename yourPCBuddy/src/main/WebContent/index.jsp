<%@ page import="model.IProductDao" %>
<%@ page import="model.ProductDaoDataSource" %>
<%@ page import="model.ProductBean" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Collection" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>yourPCBuddy</title>
</head>
<body>
<form action="LoginScreen.jsp" method="POST">
	
	<input type="submit" value="accedi o registrati">
	</form>
<div align="center" class="header">
<h1>yourPCBuddy</h1>
<img src="./Images/PCBuddy.png" alt="logo sito">
<p>Benvenuti su yourPCBuddy</p>
</div>
<div class=prodotti align="center">
	<%		IProductDao productDao = null;
	DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
	productDao = new ProductDaoDataSource(ds);
	Collection<ProductBean> products = productDao.doRetrieveProducts(); %>
  
  <h2>Prodotti</h2>
<% if (products != null && !products.isEmpty()) { %>
    <% for (ProductBean bean : products) { %>
        <img src="./Images/<%= bean.getImage() %>" alt="Immagine" width="100" />
        <p><%=bean.getName()%></p>
        <p><%= String.format("%.2f", bean.getPrice()) %></p>
        <form action="CartServlet" method="POST">
    <input type="hidden" name="action" value="addC">
    <input type="hidden" name="id" value="<%=bean.getCode()%>">
    <input type="submit" value="Aggiungi al carrello">
</form>
    <% } %>
<% } else { %>
    <p>Nessuna immagine disponibile</p>
<% } %>
</div>	
</body>
</html>