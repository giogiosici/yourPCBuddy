<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%


User user = (User) session.getAttribute("user");
int flag = 0;
if (user == null)
	response.sendRedirect("LoginScreen.jsp");
	Collection<?> products = (Collection<?>) request.getAttribute("products");
	if(products == null) {
		response.sendRedirect("./product");	
		return;
	}
	
	ProductBean product = (ProductBean) request.getAttribute("product");
	
	ProductBean existingProduct= (ProductBean) request.getAttribute("existingProduct");
	
%>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,model.ProductBean"%>

<head>
<script src="./Scripts/Search.js"></script>
<script src="./Scripts/AdminScript.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="Styles/AdminProduct.css" rel="stylesheet" type="text/css">
	
	<title>yourPCBuddy</title>
</head>

<body>
<div id="adminNav" class="adminNav">
    <form action="LogoutServlet" method="POST">
        <input type="submit" value="Logout" class="top-buttons__button">
    </form>
    
    <form action="PersonalAreaServlet" method="POST">
        <input type="submit" value="Area Personale" class="top-buttons__button">
    </form>
    
    <form action="AdminOrderView.jsp" method="post">
		<input type="submit" value="Ordini" class="top-buttons__button">
	</form>
</div>
<div id="adminContent">
	<h2>Prodotti</h2>
	<div class="container">
            <form class="search" id="search-bar">
                <input type="search" placeholder="Type something..." name="q" class="search__input" onkeyup="searchAndFilter()">
    
                <div class="search__button" id="search-button">
                    <i class="ri-search-2-line search__icon"></i>
                    <i class="ri-close-line search__close"></i>
                </div>
            </form>
        </div>
        <button id="toggleButtonInsert" onclick="toggleInsertDropdown()">Inserisci prodotto</button>
        
	<table border="1">
		<tr>
			<th>Codice</th>
			<th>Nome </th>
			<th>Descrizione</th>
			<th>Categoria </th>
			<th>Immagine</th>
			<th></th>
		</tr>
		<%
			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
					String imagePath = "Images\\" + bean.getImage();
				
		%>
		<tr class="product-row">
			<td><%=bean.getCode()%></td>
			<td class="product-name"><%=bean.getName()%></td>
			<td><%=bean.getDescription()%></td>
			<td><%=bean.getCategoria()%></td>
			<td><img src="Images/<%=bean.getImage()%>" width="100"></td>
			<td>
			<div class="dropdown">
    <button id="toggleButtonUpdate" onclick="toggleUpdateDropdown(<%=bean.getCode()%>)" >Aggiorna</button>
    <div id="myDropdown" class="dropdown-content">
        <!-- Rimuovi la riga dell'ancora e sposta l'evento onclick direttamente sul bottone -->
    </div>
</div>

			
        		<br>
        		<form action="product" method="post">
           			<input type="hidden" name="driver" value="drivermanager">
            		<input type="hidden" name="action" value="delete">
           			<input type="hidden" name="id" value="<%=bean.getCode()%>">
           			<input type="submit" value="Rimuovi">
       			</form>
        	<br>
        		<form action="product" method="post">
           			<input type="hidden" name="driver" value="drivermanager">
            		<input type="hidden" name="action" value="details">
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
			<th>Marca</th>
			<th>Nome</th>
			<th>immagine</th>
			<th>Descrizione</th>
			<th>Prezzo</th>
			<th>Quantità</th>
			<th>Categoria</th>
		</tr>
		<tr>
			<td><%=product.getCode()%></td>
			<td><%=product.getBrand()%></td>
			<td><%=product.getName()%></td>
			<td><img src="Images/<%=product.getImage()%>" width="100"></td>
			<td><%=product.getDescription()%></td>
			<td><%= String.format("%.2f", product.getPrice()) %></td>
			<td><%=product.getQuantity()%></td>
			<td><%=product.getCategoria()%></td>
		</tr>
	</table>
	<%
		}
	%><% System.out.println(request.getAttribute("existingProduct")); %>
		<div id="updateProduct" style ="display: none; ">
	
    <h2>Aggiornamento Prodotto</h2>
    <form action="product" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" id="productId"> 
            
            <label for="name">Nome:</label><br> 
            <input name="name" type="text" maxlength="20" placeholder=""><br>
    
            <label for="description">Descrizione:</label><br>
            <textarea name="description" maxlength="100" rows="3"></textarea><br>
            
            <label for="price">Prezzo:</label><br> 
            <input name="price" type="number"  step="0.01" min="0.00"><br>
    
            <label for="quantity">Quantità:</label><br> 
            <input name="quantity" type="number"><br>
            
            <label for="Categoria">Categoria:</label><br> 
            <input name="Categoria" type="text" placeholder=""><br>
            
            <label for="Marca">Marca:</label><br> 
            <input name="Marca" type="text" maxlength="20" placeholder=""><br>
            
            <label for="image">Immagine:</label><br>
            <input type="file" name="image" accept="image/*"><br>
            
            <button id="updateProductButton" type="button" onclick="updateProduct()">Aggiorna</button> 
            <input type="reset" value="Reset">
            
            <button id="toggleButtonUpdate" type="button" onclick="toggleUpdateDropdown()">Annulla</button>
            
        </form>
        
    </div>

<div id="insertProduct" style="display: none;">

	<h2>Inserimento</h2>
	<form action="product" method="post" enctype="multipart/form-data">
		<input type="hidden" name="action" value="insert"> 
		
		<label for="name">Nome:</label><br> 
		<input name="name" type="text" maxlength="20" required placeholder="Inserisci nome" required><br> 
		
		<label for="description">Descrizione:</label><br>
		<textarea name="description" maxlength="100" rows="3" required placeholder="inserisci descrizione" required></textarea><br>
		
		<label for="price">Prezzo:</label><br> 
		<input name="price" type="number"  step="0.01" min="0.00" value="0" required><br>

		<label for="quantity">Quantità:</label><br> 
		<input name="quantity" type="number" min="1" value="1" required><br>
		
		<label for="Categoria">Categoria:</label><br> 
		<input name="Categoria" type="text" required placeholder="Inserisci Categoria" required><br>
		
		<label for="Marca">Marca:</label><br> 
		<input name="Marca" type="text" maxlength="20" required placeholder="Inserisci marca" required><br> 
		
		<label for="image">Immagine:</label><br>
  		<input type="file" name="image" accept="image/*" required><br>
  
		<input type="submit" value="Aggiungi"><input type="reset" value="Reset">  <button id="toggleButtonInsert" onclick="toggleInsertDropdown()">Annulla</button>
		
</form>
	</div>
	</div>
</body>
</html>