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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script src="./Scripts/PaginaProdottoScript.js"></script>
	<link href="Styles/PaginaProdotto.css" rel="stylesheet" type="text/css">

<jsp:include page="Header.jsp" flush="true"/>

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
<div id="dettagliProdotto + consigliati ">
<div id=dettagliProdotto>
<img src="./Images/<%=product.getImage()%>" alt="Immagine" width="200" />
        <p><strong>Nome:</strong> <%=product.getName() %></p>
        <p><strong>Prezzo:</strong> <%=String.format("%.2f", product.getPrice()) %></p>
        <p><strong>Quantità Disponibile:</strong> <%=product.getQuantity() %></p>
        <div id="descrizione">
        <p><strong>Descrizione:</strong> <%=product.getDescription() %></p>
        </div>
        <!-- Altri dettagli del prodotto possono essere aggiunti qui -->
</div>
       <div id ="aggiungiAlCarrello">
        <form action="CartServlet" method="POST" class="DetailsProduct">
            <input type="hidden" name="action" value="addC">
            <input type="hidden" name="id" value="<%=product.getCode()%>">
		    <input type="submit" value="Aggiungi al carrello">
        </form>
    </div>
<div id="consigliati">
<p>Potrebbero interessarti anche...</p>
<%		
	Collection<ProductBean> products = productDao.doRetrieveConsigliati(product); %>
	<div id="ConsigliatiProductContainer">
<% if (products != null && !products.isEmpty()) { %>
    <% for (ProductBean bean : products) { %>
    <div id=consigliatiProduct>
        <a href="javascript:void(0);"
				onclick="redirectToProduct('<%=bean.getCode()%>')"> <img
				src="./Images/<%=bean.getImage()%>" alt="Immagine" width="100" />
			</a>
        <p><%=bean.getName()%></p>
        <p><%= String.format("%.2f", bean.getPrice()) %> &euro;</p>
        <%if(bean.getQuantity()>0){ %>
        <form action="CartServlet" method="POST" class="DetailsProduct">
            <input type="hidden" name="action" value="addC">
            <input type="hidden" name="id" value="<%=bean.getCode()%>">
		    <input type="submit" value="Aggiungi al carrello">
        </form>
        
        <%} else{%>
        	<p>Esaurito</p>
    <%} %>
    </div>
    <% } 
    }%>
</div></div>
</div>
</body>
<script src="./Scripts/PaginaProdottoScript.js"></script>
</html>