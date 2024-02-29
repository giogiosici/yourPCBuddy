<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*,model.ProductBean, model.Order, model.Cart, model.User"%>


<%ProductBean product = (ProductBean) request.getAttribute("product");

Cart cart = (Cart) request.getSession().getAttribute("cart");  
    
User user = (User) request.getSession().getAttribute("user");
%>
<!DOCTYPE html>
<html lang="it">
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="./Scripts/OrderScripts.js"></script>
<meta charset="ISO-8859-1" >
<link href="Styles/OrderView.css" rel="stylesheet" type="text/css">

<title>Checkout</title>
<jsp:include page="Header.jsp" flush="true"/>

</head>
<body>

<div class="order" align="center">
    <h2>Procedi all'ordine</h2>
    <table border="1">
        <tr>
            <th>Immagine</th>
            <th>Nome</th>
            <th>Prezzo</th>
            <th>Quantità</th>
            
        </tr>
        <% List<ProductBean> prodOrder = cart.getProducts(); 
           for (ProductBean beanOrder: prodOrder) {
            %>
  
            <tr>
                <td><img src="./Images/<%= beanOrder.getImage() %>" alt="Immagine" width="100" /></td>
                <td><%=beanOrder.getName()%></td>
                <td><%= String.format(Locale.US, "%.2f", beanOrder.getPrice()) %> &euro;</td>
                <td>
    				<%=beanOrder.getQuantity()%>
                </td>
            </tr>
        <% } %>
        
<tr>
            <td colspan="3"><strong>Prezzo Totale</strong></td>
            <td align="right"><span id="totalPrice">
                <% double totalPrice = 0;
                for (ProductBean beancart : prodOrder) {
                    double quantity = beancart.getQuantity();
                    double price = beancart.getPrice();
                    totalPrice += price * quantity;
                    cart.setTotalPrice(totalPrice);
                   }
                   out.println(String.format(Locale.US, "%.2f", totalPrice));
                %>
            </span></td>
        </tr>
        <tr>
            <th>Conferma i dati di spedizione</th>                
        <td colspan="3">
        <span id="stato"> <%= user.getStato() %></span><br>
        <span> <%=user.getVia() %> <%= user.getNumeroCivico() %> </span><br>
        <span><%= user.getCitta() %> (<%= user.getProvincia() %>)</span><br>
        <span><%= user.getCap() %></span>
        </td>
        </tr>
</table>
<form action="OrderServlet" method="POST">
	<input type="hidden" name="action" value="Acquista">
        <input type="submit" value="Acquista" class="checkout">
    </form>
</div>
<jsp:include page="Footer.jsp" flush="true"></jsp:include>
</body>
</html>