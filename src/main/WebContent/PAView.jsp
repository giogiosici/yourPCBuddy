
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*, model.User" %>
<%  
    User user = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="it">
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="./Scripts/PAScripts.js"></script>
<link href="Styles/PersonalArea.css" rel="stylesheet" type="text/css">

<meta charset="ISO-8859-1">
<title>Area Personale</title>
<jsp:include page="Header.jsp" flush="true"/>

</head>
<body>

<div class="PA" align="center">
    <h2>Area Personale</h2>
    <table border="1">
        <tr>
            <th>Nome</th>
            <td><%= user.getNome()%></td>
        </tr>
        <tr>
            <th>Cognome</th>
            <td><%=user.getCognome() %></td>
        </tr>
        <tr>
            <th>Username</th>
            <td><%= user.getUsername()%></td>
        </tr>
         <tr>
            <th>Email</th>
            <td>
            <div id=currentEmail>
            	<%= user.getEmail()%>
            </div>
            <div id="emailDropdown" style="display: none;">
    			<form id="emailForm" action="PersonalAreaServlet" method="POST" onsubmit="return validateEmail();">
        		<input type="email" id="email" name="email" placeholder="<%=user.getEmail()%>"><br>
        		<input type="hidden" name="action" value="ChangeEmail">
        		<button id="confirmButton" type="submit">Conferma</button>
    			</form>
			</div>
				<button id="toggleButtonEmail" onclick="toggleEmailDropdown()">Aggiorna email</button>
            </td>
        </tr>
        <tr>
            <th>Indirizzo di Spedizione</th>
            <td>
            <div id="currentAddress">
            <%if(user.getStato()==null){ %>
            	<button id="toggleButtonAddress" onclick="toggleAddressDropdown()">Inserire indirizzo</button>
            <% } else { %>
    			<strong>Nazione: </strong><%=user.getStato()%><br>
    			<strong>Indirizzo: </strong><%=user.getVia()%> <%=user.getNumeroCivico()%><br>
    			<strong>Città: </strong><%=user.getCitta()%> (<%=user.getProvincia()%>)<br>
    			<strong>CAP: </strong><%=user.getCap()%><br>
           <% } %>	
        </div>
        
        <div id="addressDropdown" style="display: none;">
            <!-- Campi per l'indirizzo -->
             <form id="addressForm" action="PersonalAreaServlet" method="POST" onsubmit="return validateForm();">
    <!-- Campi per l'indirizzo -->
    		<%if(user.getStato()==null) {%>
    			<input type="text" id="state" name="state" placeholder="Stato"><br>
    			<input type="text" id="street" name="street" placeholder="Via"><br>
    			<input type="text" id="number" name="number" placeholder="Numero civico"><br>
    			<input type="text" id="city" name="city" placeholder="Città"><br>
    			<input type="text" id="provincia" name="provincia" placeholder="Provincia"><br>
    			<input type="text" id="zip" name="zip" placeholder="CAP"><br>
    		<%}else {%>
    			<input type="text" id="state" name="state" placeholder="Stato: <%=user.getStato()%>"><br>
    			<input type="text" id="street" name="street" placeholder="Via: <%=user.getVia()%>"><br>
    			<input type="text" id="number" name="number" placeholder="Numero civico: <%=user.getNumeroCivico()%>"><br>
    			<input type="text" id="city" name="city" placeholder="Città: <%=user.getCitta()%>"><br>
    			<input type="text" id="provincia" name="provincia" placeholder="Provincia: <%=user.getProvincia()%>"><br>
    			<input type="text" id="zip" name="zip" placeholder="CAP: <%=user.getCap()%>"><br>
    		<%}%>
    <!-- Bottone per confermare l'aggiornamento -->
    		<input type="hidden" name="action" value="ChangeAddress">
    		<input type="submit" value ="Conferma">
			</form>
        </div>
        <%if(user.getStato()!=null){ %>
        <button id="toggleButtonAddress" onclick="toggleAddressDropdown()">Aggiorna indirizzo</button>
    	<% } %>
    </td>
        </tr>
    </table>
</div>
<jsp:include page="Footer.jsp" flush="true"></jsp:include>

</body>
</html>