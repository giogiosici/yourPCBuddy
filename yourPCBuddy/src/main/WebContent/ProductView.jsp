<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	Collection<?> products = (Collection<?>) request.getAttribute("products");
	if(products == null) {
		response.sendRedirect("./product");	
		return;
	}
	
	ProductBean product = (ProductBean) request.getAttribute("product");
	
%>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,model.ProductBean"%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="ProductStyle.css" rel="stylesheet" type="text/css">
	<title>yourPCBuddy</title>
</head>

<body>
	<h2>Prodotti</h2>
	<table border="1">
		<tr>
			<th>Codice</th>
			<th>Nome <a href="product?sort=name">Ordina</a></th>
			<th>Descrizione</th>
			<th>Categoria <a href="product?sort=CategoriaID">Ordina</a></th>
			<th>Immagine</th>
			<th>Action</th>
		</tr>
		<%
			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
					String imagePath = "Images\\" + bean.getImage();
				
		%>
		<tr>
			<td><%=bean.getCode()%></td>
			<td><%=bean.getName()%></td>
			<td><%=bean.getDescription()%></td>
			<td><%=bean.getCategoriaID()%></td>
			<td><img src="Images/<%=bean.getImage()%>" width="200"></td>
			<td>
        		<form action="product" method="post">
           			<input type="hidden" name="driver" value="drivermanager">
            		<input type="hidden" name="action" value="delete">
           			<input type="hidden" name="id" value="<%=bean.getCode()%>">
           			<input type="submit" value="Rimuovi">
       			</form>
        	<br>
        		<form action="product" method="post">
           			<input type="hidden" name="driver" value="drivermanager">
            		<input type="hidden" name="action" value="read">
            		<input type="hidden" name="id" value="<%=bean.getCode()%>">
           			<input type="submit" value="Dettagli">
        		</form>
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
			<td><%= String.format("%.2f", product.getPrice()) %></td>
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
		<input name="price" type="number"  step="0.01" min="0.00" value="0" required><br>

		<label for="quantity">Quantità:</label><br> 
		<input name="quantity" type="number" min="1" value="1" required><br>
		
		<label for="CategoriaID">CategoriaID:</label><br> 
		<input name="CategoriaID" type="number" min="1" value="0" required><br>
		
		<label for="image">Immagine:</label><br>
  		<input type="file" name="image" accept="image/*" required><br>
  
		<input type="submit" value="Aggiungi"><input type="reset" value="Reset"> 
	</form>
	
</body>
</html>