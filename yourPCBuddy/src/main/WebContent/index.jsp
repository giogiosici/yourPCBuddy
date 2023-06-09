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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="ISO-8859-1">
<title>yourPCBuddy</title>
</head>
<body>
	<form action="LoginScreen.jsp" method="POST">
		<input type="submit" value="accedi o registrati">
	</form>
	<form action="CartServlet" method="post">
		<input type="submit" value="carrello">
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
        <form action="CartServlet" method="POST" class="IndexProduct">
    			<input type="hidden" name="action" value="addC">
    			<input type="hidden" name="id" value="<%=bean.getCode()%>">
    		<input type="submit" value="Aggiungi al carrello">
		</form>
    <% } %>
<% } else { %>
    <p>Nessun prodotto disponibile</p>
<% } %>
<script>
$(document).ready(function() {
    $('.IndexProduct').submit(function(e) {
        e.preventDefault(); // Previene l'invio predefinito del form

        var formData = $(this).serialize(); // Ottiene i dati del form serializzati

        // Invia la richiesta AJAX al tuo form di destinazione
        $.ajax({
            url: 'CartServlet',
            type: 'POST',
            data: formData,
            success: function(response) {
                // Gestisci la risposta del server, se necessario
            },
            error: function(xhr, status, error) {
                // Gestisci gli errori, se necessario
            }
        });
    });
});
</script>


</div>	
</body>
</html>