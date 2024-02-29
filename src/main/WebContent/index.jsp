<%@ page import="model.IProductDao" %>
<%@ page import="model.ProductDaoDataSource" %>
<%@ page import="model.ProductBean" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Collection" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="it">
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="./Scripts/IndexScript.js"></script>
<link href="Styles/Index.css" rel="stylesheet" type="text/css">
<meta charset="ISO-8859-1">
<title>yourPCBuddy</title>
<jsp:include page="Header.jsp" flush="true"/>
</head>
<body>


<div class=ultimeAggiunte align="center">
	<%		IProductDao productDao = null;
	DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
	productDao = new ProductDaoDataSource(ds);
	Collection<ProductBean> products = productDao.doRetrieveLastProducts(); %>
  
  <h2>Ultime aggiunte</h2>
  <div id="IndexProductContainer">
<% if (products != null && !products.isEmpty()) { %>
    <% for (ProductBean bean : products) { %>
    <div id=IndexProduct>
        <a href="javascript:void(0);"
				onclick="redirectToProduct('<%=bean.getCode()%>')"> <img
				src="./Images/<%=bean.getImage()%>" alt="Immagine" width="100" />
			</a>
        <p><%=bean.getName()%></p>
        <p><%= String.format("%.2f", bean.getPrice()) %> &euro;</p>
        <%if(bean.getQuantity()>0){ %>
        <form method="POST" class="IndexProduct">
            <input type="hidden" name="action" value="addC">
            <input type="hidden" name="id" value="<%=bean.getCode()%>">
 		    <input type="submit" value="Aggiungi al carrello">
        </form>
        
        <%} else{%>
        	<p>Esaurito</p>
    <%} %>
    </div>
    <% } %>
    
<% } else { %>
    <p>Nessun prodotto disponibile</p>
<% } %>
	</div>

</div>
<jsp:include page="Footer.jsp" flush="true"></jsp:include>

</body>

</html>