<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<%
    Collection<?> products = (Collection<?>) request.getAttribute("products");
    if (products == null) {
        System.out.println("porcaccio dio");
    	//response.sendRedirect("./CartServlet");
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
<script>
	
	function updateTotalPrice(input) {
    	var quantity = parseFloat(input.value);
    	var price = parseFloat(input.parentNode.previousElementSibling.innerHTML);
    	var totalPriceElement = document.getElementById('totalPrice');
    	var totalPrice = parseFloat(totalPriceElement.innerHTML);

    // Calcola il prezzo totale senza considerare la quantità
    	var previousPrice = parseFloat(input.getAttribute('data-previous-price')) || 0;
    	totalPrice -= previousPrice;

	    var newPrice = price * quantity;
    	totalPrice += newPrice;

    // Aggiorna l'attributo 'data-previous-price' con il nuovo prezzo
   		input.setAttribute('data-previous-price', newPrice);
    	totalPriceElement.innerHTML = totalPrice.toFixed(2);
}
</script>

</head>
<body>
<form action="index.jsp" method="POST">
        <input type="submit" value="home">
        </form>
<div class="cart" align="center">
<% if (cart != null && !cart.isEmpty()) { %>
    <h2>Carrello</h2>
    <table border="1">
        <tr>
            <th>Immagine</th>
            <th>Nome</th>
            <th>Prezzo</th>
            <th>Quantità</th>
            <th></th>
        </tr>
        <% List<ProductBean> prodcart = cart.getProducts(); 
           for (ProductBean beancart: prodcart) {
            %>
  
            <tr>
                <td><img src="./Images/<%= beancart.getImage() %>" alt="Immagine" width="100" /></td>
                <td><%=beancart.getName()%></td>
                <td><%= String.format(Locale.US, "%.2f", beancart.getPrice()) %></td>
                <td>
                    <%=beancart.getQuantity()%>
                </td>
                <td>
                    <form action="CartServlet" method="POST">
                        <input type="hidden" name="action" value="deleteC">
                        <input type="hidden" name="id" value="<%=beancart.getCode()%>">
                        <input type="hidden" name="quantity" value="<%=beancart.getQuantity()%>">
                        <input type="submit" value="Rimuovi">
                    </form>
                    
                    <form action="CartServlet" method="POST">
    					<input type="hidden" name="action" value="addC">
    					<input type="hidden" name="id" value="<%=beancart.getCode()%>">	
    					<input type="submit" value="Aggiungi">
					</form>
					
					<form action="CartServlet" method="POST">
    					<input type="hidden" name="action" value="delAllC">
    					<input type="hidden" name="id" value="<%=beancart.getCode()%>">
    					<input type="submit" value="Rimuovi tutto">
					</form>
					
                </td>
            </tr>
        <% } %>
        
        <tr>
            <td colspan="4"><strong>Prezzo Totale</strong></td>
            <td align="right"><span id="totalPrice">
                <% double totalPrice = 0;
                for (ProductBean beancart : prodcart) {
                    double quantity = beancart.getQuantity();
                    double price = beancart.getPrice();
                    totalPrice += price * quantity;
                    cart.setTotalPrice(totalPrice);
                   }
                   out.println(String.format(Locale.US, "%.2f", totalPrice));
                %>
            </span></td>
        </tr>
    </table>
<% } else { %>
    <h2>Carrello</h2>
    <p>Non sono presenti elementi nel carrello</p>
<% } %>
</div>
</body>
</html>
