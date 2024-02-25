<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="model.OrderDao"%>
<%@ page import="model.OrderDaoDataSource"%>
<%@ page import="model.Order"%>
<%@ page import="model.ProductBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ordini</title>
</head>
<body>
<div id=navbar>
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

    <h2>Ordini</h2>

    <%
    if (orders != null && !orders.isEmpty()) {
        for (Order order : orders) {
    %>
    <h3>Ordine <%= order.getCode() %></h3>
    <h4>Utente: <%=order.getUserId() %></h4>
    
    <p>Data e ora: <%= order.getDateTime() %></p>
    
    
    <!-- Mostra i dettagli dei prodotti per questo ordine -->
    <ul>
        <%
        List<ProductBean> products = order.getProducts();
        if (products != null && !products.isEmpty()) {
            for (ProductBean product : products) {
        %>
            <li><img src="./Images/<%=product.getImage() %>" width="80" height="80"> 
            <%= product.getName() %> - Quantità: <%= product.getQuantity() %> - 
        	<p>Totale: <%= String.format("%.2f", order.getTotalPrice()) %></p>
        	</li>
        <%
            }
        }
        %>
    </ul>

    <%
        }
    } else {
    %>
        <p>Nessun ordine disponibile</p>
    <%
    }
    %>
</body>
</html>
