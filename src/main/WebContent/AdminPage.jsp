<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
	<link href="Styles/AdminPage.css" rel="stylesheet" type="text/css">

<title>Admin Page</title>
</head>
<%
User user = (User) session.getAttribute("user");
int flag = 0;
if (user == null)
	response.sendRedirect("LoginScreen.jsp");
else if (user.getId() == 1) {
	flag = 1;
}
%>
<body>
<div id="adminNav">
<form action="LogoutServlet" method="POST">
        <input type="submit" value="Logout">
    </form>
    
<form action="ProductControl" method="post">
		<input type="submit" value="Prodotti">
	</form>
	
	<form action="AdminOrderView.jsp" method="post">
		<input type="submit" value="Ordini">
	</form>
	</div>
</body>
</html>