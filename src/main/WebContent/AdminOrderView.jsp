<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="model.OrderDao"%>
<%@ page import="model.OrderDaoDataSource"%>
<%@ page import="model.Order"%>
<%@ page import="model.ProductBean" %>
<%@ page import="model.User" %>

<%


User user = (User) session.getAttribute("user");
int flag = 0;
if (user == null)
	response.sendRedirect("LoginScreen.jsp");
	
%>
<!DOCTYPE html>
<html>
<head>
	<link href="Styles/AdminProduct.css" rel="stylesheet" type="text/css">
<script src="./Scripts/AdminOrderScript.js"></script>

    <meta charset="UTF-8">
    <title>Ordini</title>
</head>
<body>
<div id="adminNav">
<form action="LogoutServlet" method="POST">
        <input type="submit" value="Logout">
    </form>
    <form action="PersonalAreaServlet" method="POST">
        <input type="submit" value="Area Personale">
    </form>
<form action="AdminProductView.jsp" method="post">
		<input type="submit" value="Prodotti">
	</form>
</div>
    <%
    OrderDao orderDao = null;
    DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
    orderDao = new OrderDaoDataSource(ds);
    List<Order> orders = orderDao.DoRetrieveAllOrder();
    %>
	
	<div id="filtri">
			<h5>Filtri</h5>
			<div class="user-search">
				<label>Id: </label> <input type="text" id="searchInput"
					placeholder="inserire l'id utente..." onkeyup="filterRows()">
			</div>
			<div>
				<label>da </label> <input type="date" id="startDateInput"
					onchange="filterRows()" /> <label>a </label> <input type="date"
					id="endDateInput" onchange="filterRows()" />	
			</div>
		</div>
	<div id="adminContent">
    <h2>Ordini</h2>

    <%
    if (orders != null && !orders.isEmpty()) {
        for (Order order : orders) {
    %>
    
    
    
	

	<table border="1">
	<thead>
	<h3>Ordine N°: <%= order.getCode() %></h3>
    
    <h4>Data e ora: <%= order.getDateTime() %>
    </h4>
		<tr>
			<th>Id Utente</th>
			<th>Immagine</th>
			<th>Nome </th>
			<th>Quantità</th>
			<th>Prezzo Totale</th>
			
		</tr>
		</thead>
		<tbody id="container">
		<%
        List<ProductBean> products = order.getProducts();
        if (products != null && !products.isEmpty()) {
            for (ProductBean product : products) {
        %>
		
		<tr class="order-row" data-utente = <%=order.getUserId() %> data-giorno=<%= order.getDateTime() %>>
			<td><%=order.getUserId() %></td>
			<td><img src="Images/<%=product.getImage()%>" width="100"></td>
			<td class="product-name"><%=product.getName()%></td>
			<td><%=product.getQuantity()%></td>
			<td><%=String.format("%.2f", order.getTotalPrice())%> &euro;</td>
			</tr>
			
    <%
            }
        }
        %>
    
    <%
        }
    }
    %>
    
    </table>
    </div>
</body>
</html>