<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%
    
    
    ProductBean product = (ProductBean) request.getAttribute("product");
    
    Cart cart = (Cart) request.getAttribute("cart");
 
    // Ottieni il valore di isLogged dal ServletContext
    Boolean isLogged = (Boolean) getServletContext().getAttribute("isLogged");

%>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,model.ProductBean, model.Cart"%>
<!DOCTYPE html>
<html lang="it">
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="./Scripts/CartScript.js"></script>
<link href="Styles/Carrello.css" rel="stylesheet" type="text/css">

<meta charset="UTF-8">
<title>Carrello</title>
<jsp:include page="Header.jsp" flush="true"/>

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
            <th></th>
        </tr>
        
        <% List<ProductBean> prodcart = cart.getProducts(); %>

           <%for (ProductBean beancart: prodcart) {
            %>
  
            <tr>
                <td><img src="./Images/<%= beancart.getImage() %>" alt="Immagine" width="100" /></td>
                <td><%=beancart.getName()%></td>
                <td><%= String.format(Locale.US, "%.2f", beancart.getPrice()) %> &euro;</td>
                <td>
    				<%=beancart.getQuantity()%>
                </td>
                
                <td>
                    <form action="CartServlet" method="POST" class="removeOneFromCartForm">
                        <input type="hidden" name="action" value="deleteC">
                        <input type="hidden" name="id" value="<%=beancart.getCode()%>">
                        <input type="hidden" name="quantity" value="<%=beancart.getQuantity()%>">
                        <input type="submit" value="Rimuovi">
                    </form>
                    
                    <form action="CartServlet" method="POST" class="addOneToCartForm">
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
    
    	<form action="OrderServlet" method="POST" onsubmit="return checkLogin()">
    		<input type="submit" value="Procedi al checkout">
		</form>
	<script>
    function checkLogin() {
        var isLogged = <%= isLogged == null ? "false" : isLogged %>;

        if (!isLogged) {
            var customText = "Per proseguire, è necessario effettuare l'accesso.";

            // Utilizza SweetAlert2 per mostrare un alert personalizzato
            Swal.fire({
                title: 'Attenzione!',
                text: customText,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'OK',
                cancelButtonText: 'Annulla'
            }).then((result) => {
                if (result.isConfirmed) {
                    // L'utente ha fatto clic su "OK", quindi reindirizza alla pagina di login
                    window.location.href = "LoginScreen.jsp";
                }
            });

            return false; // Interrompi l'invio del modulo
        }
        return true; // Permetti l'invio del modulo
    }
</script>
<% } else { %>
    <h2>Carrello</h2>
    <p>Non sono presenti elementi nel carrello</p>
<% } %>
</div>
<jsp:include page="Footer.jsp" flush="true"></jsp:include>

</body>
</html>
