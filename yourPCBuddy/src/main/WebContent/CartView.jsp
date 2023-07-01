<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	Collection<?> products = (Collection<?>) request.getAttribute("products");
	if(products == null) {
		response.sendRedirect("./CartServlet");	
		return;
	}
	
	ProductBean product = (ProductBean) request.getAttribute("product");
	
	Cart cart = (Cart) request.getAttribute("cart");
%>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,model.ProductBean, model.Cart"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Carrello</title>
</head>
<body>
<div class=cart align="center">
<% if(cart != null) { %>
		<h2>Cart</h2>
		<table border="1">
		<tr>
			<th>Name</th>
			<th>Action</th>
		</tr>
		<% List<ProductBean> prodcart = cart.getProducts(); 	
		   for(ProductBean beancart: prodcart) {
		%>
		<tr>
			<td><%=beancart.getName()%></td>
			<td><form action="CartServlet" method="POST">
    			<input type="hidden" name="action" value="deleteC">
    			<input type="hidden" name="id" value="<%=beancart.getCode()%>">
    			<button type="submit">Rimuovi</button>
				</form>
			</td>
		</tr>
		<%} %>
	</table>		
	<% } %>	
	</div>>
</body>
</html>