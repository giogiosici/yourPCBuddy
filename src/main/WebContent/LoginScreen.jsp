<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="it">
<head>
<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="Styles/LoginScreen.css" rel="stylesheet" type="text/css">

<meta charset="ISO-8859-1">
<title>Login Page</title>
<jsp:include page="Header.jsp" flush="true"/>

</head>
<body>

<main>
<div id="Login">
<form action="Login" method="POST" >
		<label for="username">Username:</label>
		<input type="text" id="username" name="username" required><br><br>

	    <label for="password">Password:</label>
		<input type="password" id="password" name="password" required><br><br>
		<input type="submit" value="Login">	
  </form>
  
  <p>Non sei registrato? Registrati <a href="RegisterPage.jsp">qui</a></p>
</div>
</main>
</body>
<jsp:include page="Footer.jsp" flush="true"></jsp:include>

<script>
// Esegui lo script JavaScript per mostrare l'alert con SweetAlert2
<% String errorScript = (String) request.getAttribute("errorScript"); %>
<% if (errorScript != null) { %>
    <%= errorScript %>
<% } %>
</script>
</html>