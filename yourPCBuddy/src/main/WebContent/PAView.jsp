
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*, model.User" %>
<%  
    User user = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="./Scripts/PAScripts.js"></script>
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
            <%if(user.getIndirizzo()==null){ %>
            	<button id="toggleButtonAddress" onclick="toggleAddressDropdown()">Inserire indirizzo</button>
            <% } else { 
            	String indirizzo = user.getIndirizzo();
    			String[] campi = indirizzo.split("<br>");%>
    			<strong>Nazione: </strong><%=campi[0]%><br>
    			<strong>Indirizzo: </strong><%=campi[1]%> <%=campi[2]%><br>
    			<strong>Città: </strong><%=campi[3]%> <%=campi[4]%><br>
    			<strong>CAP: </strong><%=campi[5]%><br>
           <% } %>	
        </div>
        
        <div id="addressDropdown" style="display: none;">
            <!-- Campi per l'indirizzo -->
             <form id="addressForm" action="PersonalAreaServlet" method="POST" onsubmit="return validateForm();">
    <!-- Campi per l'indirizzo -->
    		<%if(user.getIndirizzo()==null) {%>
    			<input type="text" id="state" name="state" placeholder="Stato"><br>
    			<input type="text" id="street" name="street" placeholder="Via"><br>
    			<input type="text" id="number" name="number" placeholder="Numero civico"><br>
    			<input type="text" id="city" name="city" placeholder="Città"><br>
    			<input type="text" id="provincia" name="provincia" placeholder="Provincia"><br>
    			<input type="text" id="zip" name="zip" placeholder="CAP"><br>
    		<%}else {
    			String indirizzo = user.getIndirizzo();
    			String[] campi = indirizzo.split("<br>");%>
    			<input type="text" id="state" name="state" placeholder="Stato: <%=campi[0]%>"><br>
    			<input type="text" id="street" name="street" placeholder="Via: <%=campi[1]%>"><br>
    			<input type="text" id="number" name="number" placeholder="Numero civico: <%=campi[2]%>"><br>
    			<input type="text" id="city" name="city" placeholder="Città: <%=campi[3]%>"><br>
    			<input type="text" id="provincia" name="provincia" placeholder="Provincia: <%=campi[4]%>"><br>
    			<input type="text" id="zip" name="zip" placeholder="CAP: <%=campi[5]%>"><br>
    		<%}%>
    <!-- Bottone per confermare l'aggiornamento -->
    		<input type="hidden" name="action" value="ChangeAddress">
    		<input type="submit" value ="Conferma">
			</form>
        </div>
        <%if(user.getIndirizzo()!=null){ %>
        <button id="toggleButtonAddress" onclick="toggleAddressDropdown()">Aggiorna indirizzo</button>
    	<% } %>
    </td>
        </tr>
    </table>
</div>
</body>
</html>