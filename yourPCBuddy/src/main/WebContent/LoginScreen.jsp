<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
</head>
<body>
<form action="Login" method="post">
		<label for="username">Username:</label>
		<input type="text" id="username" name="username" required><br><br>

	    <label for="password">Password:</label>
		<input type="password" id="password" name="password" required><br><br>
		<input type="submit" value="login">		
  </form>
  <% String errorMessage = (String) request.getAttribute("errorMessage");
   if (errorMessage != null && !errorMessage.isEmpty()) { %>
    <div class="error-message">
        <%= errorMessage %>
    </div>
<% } %>
  <p>Non sei registrato? Registrati <a href="RegisterPage.jsp">qui</a></p>
</body>
</html>