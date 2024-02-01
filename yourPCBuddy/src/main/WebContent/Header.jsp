<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="Styles/Header.css" rel="stylesheet" type="text/css">

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header>
	<div id="logo">
		<img src="./Images/PCBuddy.png" alt="logo sito">
	</div>
		<div id="navBar">
		<%
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		String path = httpServletRequest.getServletPath();
		System.out.println(path);
		
		if (path.contains("/index.jsp")) {
		%>
		<h1>yourPCBuddy</h1>
		<p>Benvenuti su yourPCBuddy</p>

		
			<%
			if (session.getAttribute("username") != null) {
			%>
			<form action="LogoutServlet" method="POST">
				<input type="submit" value="Logout">
			</form>
			<form action="PersonalAreaServlet" method="POST">
				<input type="submit" value="Area Personale">
			</form>

			<%
			} else {
			%>
			<form action="LoginScreen.jsp" method="POST">
				<input type="submit" value="Accedi o registrati">
			</form>
			<%
			}
			%>
			<form action="CartServlet" method="post">
				<input type="submit" value="Carrello">
			</form>
			<form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo">
			</form>
		
		<%
		} else if (path.contains("/LoginScreen.jsp")) {
		%>
		
			<form action="CartServlet" method="post">
				<input type="submit" value="Carrello">
			</form>
			<form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo">
			</form>
			<form action="index.jsp" method="POST">
				<input type="submit" value="Home">
			</form>
		
		<%
		} else if (path.contains("/RegisterPage.jsp")) {
		%>
		
			<form action="CartServlet" method="post">
				<input type="submit" value="Carrello">
			</form>
			<form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo">
			</form>
			<form action="index.jsp" method="POST">
				<input type="submit" value="Home">
			</form>
		
		<%
		} else if (path.contains("/OrderPage.jsp")) {
		%>
		
			<form action="CartServlet" method="post">
				<input type="submit" value="Carrello">
			</form>
			<form action="LogoutServlet" method="POST">
				<input type="submit" value="Logout">
			</form>
			<form action="index.jsp" method="POST">
				<input type="submit" value="Home">
			</form>
			<form action="PersonalAreaServlet" method="POST">
				<input type="submit" value="Area Personale">
			</form>
			<form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo">
			</form>
		
		<%
		} else if (path.contains("/PAView.jsp")) {
		%>
		
			<form action="CartServlet" method="post">
				<input type="submit" value="Carrello">
			</form>
			<form action="LogoutServlet" method="POST">
				<input type="submit" value="Logout">
			</form>
			<form action="index.jsp" method="POST">
				<input type="submit" value="Home">
			</form>
			<form action="OrderServlet" method="POST">
				<input type="submit" name="action" value="Storico ordini">
			</form>
			<form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo">
			</form>
		
		<%
		} else if (path.contains("/Catalogo.jsp")) {
		%>
		
			<form action="index.jsp" method="POST">
				<input type="submit" value="Home">
			</form>
			<%
			if (session.getAttribute("username") != null) {
			%>
			<form action="LogoutServlet" method="POST">
				<input type="submit" value="Logout">
			</form>
			<form action="PersonalAreaServlet" method="POST">
				<input type="submit" value="Area Personale">
			</form>
			<%
			} else {
			%>
			<form action="LoginScreen.jsp" method="POST">
				<input type="submit" value="Accedi o registrati">
			</form>
			<%
			}
			%>
			<form action="CartServlet" method="post">
				<input type="submit" value="Carrello">
			</form>
		
		<%
		} else if (path.contains("/CartView.jsp")) {
		%>
		
			<form action="index.jsp" method="POST">
				<input type="submit" value="Home">
			</form>
			<%
			if (session.getAttribute("username") != null) {
			%>
			<form action="LogoutServlet" method="POST">
				<input type="submit" value="Logout">
			</form>
			<form action="PersonalAreaServlet" method="POST">
				<input type="submit" value="Area Personale">
			</form>
			<%
			} else {
			%>
			<form action="LoginScreen.jsp" method="POST">
				<input type="submit" value="Accedi o registrati">
			</form>
			<%
			}
			%>
			<form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo">
			</form>
		
			
		<%
		} else if (path.contains("/OrderView.jsp")) {
			%>
			
	<form action="CartServlet" method="post">
		<input type="submit" value="Carrello">
	</form>
	<form action="LogoutServlet" method="POST">
        <input type="submit" value="Logout">
    </form>
   	<form action="index.jsp" method="POST">
        <input type="submit" value="Home">
    </form>
    <form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo">
			</form>
		

			<%
		} else if (path.contains("/PaginaProdotto.jsp")) {
			%>
			
			<form action="index.jsp" method="POST">
				<input type="submit" value="Home">
			</form>
			<%
			if (session.getAttribute("username") != null) {
			%>
			<form action="LogoutServlet" method="POST">
				<input type="submit" value="Logout">
			</form>
			<form action="PersonalAreaServlet" method="POST">
				<input type="submit" value="Area Personale">
			</form>

			<%
			} else {
			%>
			<form action="LoginScreen.jsp" method="POST">
				<input type="submit" value="Accedi o registrati">
			</form>
			<%
			}
			%>
			<form action="CartServlet" method="post">
				<input type="submit" value="Carrello">
			</form>
			<form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo">
			</form>
		

			<%
			}
			%>
			</div>
	</header>
</body>
</html>