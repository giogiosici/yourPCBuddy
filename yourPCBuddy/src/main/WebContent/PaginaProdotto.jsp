<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.ProductBean" %>
<%@ page import="java.util.Collection" %>
<%@ page import="model.IProductDao" %>
<%@ page import="model.ProductDaoDataSource" %>
<%@ page import="javax.sql.DataSource" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dettagli prodotto</title>
</head>
<body>
<%
	DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
	IProductDao productDao = new ProductDaoDataSource(ds);
    String productId = request.getParameter("productId");
    int prodId = Integer.parseInt(productId);
    ProductBean product = productDao.doRetrieveByKey(prodId);
%>

<h2>Dettagli del Prodotto</h2>
<img src="./Images/<%=product.getImage()%>" alt="Immagine" width="200" />
        <p><strong>Nome:</strong> <%=product.getName() %></p>
        <p><strong>Prezzo:</strong> <%=product.getPrice() %></p>
        <p><strong>Descrizione:</strong> <%=product.getDescription() %></p>
        <p><strong>Quantità Disponibile:</strong> <%=product.getQuantity() %></p>
        <!-- Altri dettagli del prodotto possono essere aggiunti qui -->

        <!-- Aggiungi al carrello -->
        <form action="CartServlet" method="POST">
            <input type="hidden" name="action" value="addC">
            <input type="hidden" name="id" value="<%=product.getCode() %>">
            <input type="hidden" name="quantity" value="1">
            <input type="submit" value="Aggiungi al carrello">
        </form>
    
    
    <!-- Aggiungi altri dettagli del prodotto, se necessario -->

    <!-- Link per tornare al catalogo -->
    <p><a href="Catalogo.jsp">Torna al catalogo</a></p>

</body>
</html>