<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    Collection<?> products = (Collection<?>) request.getAttribute("products");
    if (products == null) {
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
<script>
    function updateTotalPrice(input) {
        var quantity = parseFloat(input.value);
        var price = parseFloat(input.parentNode.previousElementSibling.innerHTML);
        var totalPriceElement = document.getElementById('totalPrice');
        var totalPrice = parseFloat(totalPriceElement.innerHTML);
        var previousQuantity = parseFloat(input.getAttribute('data-previous-quantity')) || 1;
        
        // Aggiorna il prezzo totale rimuovendo il prezzo corrispondente alla quantità precedente
        var previousPrice = price * previousQuantity;
        totalPrice -= previousPrice;
        
        // Aggiorna il prezzo totale con il nuovo valore
        var newPrice = price * quantity;
        totalPrice += newPrice;
        
        // Aggiorna l'attributo 'data-previous-quantity' con la nuova quantità
        input.setAttribute('data-previous-quantity', quantity);
        
        totalPriceElement.innerHTML = totalPrice.toFixed(2); // Aggiorna il prezzo totale con 2 decimali
        
        
    }
</script>
</head>
<body>

<div class="cart" align="center">
<% if (cart != null && !cart.isEmpty()) { %>
    <h2>Carrello</h2>
    <table border="1">
        <tr>
            <th>Immagine</th>
            <th>Nome</th>
            <th>Prezzo</th>
            <th>Quantità</th>
            <th>Action</th>
        </tr>
        <% List<ProductBean> prodcart = cart.getProducts(); 
           for (ProductBean beancart: prodcart) {
            %>
        
            <tr>
                <td><img src="./Images/<%= beancart.getImage() %>" alt="Immagine" width="100" /></td>
                <td><%=beancart.getName()%></td>
                <td><%= String.format(Locale.US, "%.2f", beancart.getPrice()) %></td>
                <td>
                    <input name="quantity_<%= beancart.getCode() %>" type="number" min="1" value="1" style="width: 50px;" onchange="updateTotalPrice(this)">
                </td>
                <td>
                    <form action="CartServlet" method="POST">
                        <input type="hidden" name="action" value="deleteC">
                        <input type="hidden" name="id" value="<%=beancart.getCode()%>">
                        <input type="submit" value="Rimuovi">
                    </form>
                </td>
            </tr>
        <% } %>
        
        <tr>
            <td colspan="4"><strong>Prezzo Totale</strong></td>
            <td align="right"><span id="totalPrice">
                <% double totalPrice = 0;
                   for (ProductBean beancart: prodcart) {
                       String quantityParam = "quantity_" + beancart.getCode();
                       String quantityValue = request.getParameter(quantityParam);
                       double quantity = quantityValue != null ? Double.parseDouble(quantityValue) : 1;
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
