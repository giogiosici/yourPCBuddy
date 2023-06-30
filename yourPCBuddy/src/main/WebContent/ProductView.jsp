<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	Collection<?> products = (Collection<?>) request.getAttribute("products");
	if(products == null) {
		response.sendRedirect("./product");	
		return;
	}
	
	ProductBean product = (ProductBean) request.getAttribute("product");
	
	Cart cart = (Cart) request.getAttribute("cart");
%>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,model.ProductBean, model.Cart"%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="ProductStyle.css" rel="stylesheet" type="text/css">
	<title>yourPCBuddy</title>
</head>

<body>
	<h2>Prodotti</h2>
	<a href="product">List</a>
	<table border="1">
		<tr>
			<th>Codice <a href="product?sort=code">Sort</a></th>
			<th>Nome <a href="product?sort=name">Sort</a></th>
			<th>Descrizione <a href="product?sort=description">Sort</a></th>
			<th>Categoria <a href="product?sort=CategoriaID">Sort</a></th>
			<th>Immagine <a href="product?sort=image">Sort</a></th>
			<th>Action</th>
		</tr>
		<%
			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
					
				
		%>
		<tr>
			<td><%=bean.getCode()%></td>
			<td><%=bean.getName()%></td>
			<td><%=bean.getDescription()%></td>
			<td><%=bean.getCategoriaID()%></td>
			<td><img src="Images/<%=bean.getImage()%>" width="200"></td>
			
			<td><a href="product?driver=drivermanager&action=delete&id=<%=bean.getCode()%>">Delete</a><br>
				<a href="product?driver=drivermanager&action=read&id=<%=bean.getCode()%>">Details</a><br>
				<a href="product?driver=drivermanager&action=addC&id=<%=bean.getCode()%>">Add to cart</a>
				</td>
		</tr>
		<%
				}
			} else {
		%>
		<tr>
			<td colspan="6">Nessun prodotto disponibile</td>
		</tr>
		<%
			}
		%>
	</table>
	
	
	<%
		if (product != null) {
	%>
	<h2>Dettagli</h2>
	<table border="1">
		<tr>
			<th>Codice</th>
			<th>Nome</th>
			<th>Descrizione</th>
			<th>Prezzo</th>
			<th>Quantità</th>
			<th>CategoriaID</th>
		</tr>
		<tr>
			<td><%=product.getCode()%></td>
			<td><%=product.getName()%></td>
			<td><%=product.getDescription()%></td>
			<td><%=product.getPrice()%></td>
			<td><%=product.getQuantity()%></td>
			<td><%=product.getCategoriaID()%></td>
		</tr>
	</table>
	<%
		}
	%>
	<h2>Inserimento</h2>
	<form action="product" method="post" enctype="multipart/form-data">
		<input type="hidden" name="action" value="insert"> 
		
		<label for="name">Nome:</label><br> 
		<input name="name" type="text" maxlength="20" required placeholder="Inserisci nome"><br> 
		
		<label for="description">Descrizione:</label><br>
		<textarea name="description" maxlength="100" rows="3" required placeholder="inserisci descrizione"></textarea><br>
		
		<label for="price">Prezzo:</label><br> 
		<input name="price" type="number" min="0" value="0" required><br>

		<label for="quantity">Quantità:</label><br> 
		<input name="quantity" type="number" min="1" value="1" required><br>
		
		<label for="CategoriaID">CategoriaID:</label><br> 
		<input name="CategoriaID" type="number" min="1" value="0" required><br>
		
		<label for="image">Immagine:</label><br>
  		<input type="file" name="image" accept="image/*" required><br>
  
		<input type="submit" value="Aggiungi"><input type="reset" value="Reset"> 
	</form>
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
			<td><a href="product?action=deleteC&id=<%=beancart.getCode()%>">Delete from cart</a></td>
		</tr>
		<%} %>
	</table>		
	<% } %>	
</body>
</html>