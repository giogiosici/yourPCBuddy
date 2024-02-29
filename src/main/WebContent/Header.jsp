<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
<link href="Styles/Header.css" rel="stylesheet" type="text/css">

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header>
	<div id="logo">
		<img src="./Images/logoSito2.png" alt="logo sito">
	</div>
		<div id="navBar">
		<%
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		String path = httpServletRequest.getServletPath();
		
		if (path.contains("/index.jsp")) {
		%>
		
		
<div class="container">
    <form id="search-form" class="search" action="CatalogServlet" method="POST">
        <input id="search-input" type="search" name="q" placeholder="Type something..." class="search__input">
        <div class="search__button" id="search-button">
            <i class="ri-search-2-line search__icon"></i>
            <i class="ri-close-line search__close"></i>
        </div>
    </form>
</div>


		
			<%
			if (session.getAttribute("username") != null) {
			%>
			<form action="LogoutServlet" method="POST">
				<input type="submit" value="Logout" class="top-buttons__button">
			</form>
			<form action="PersonalAreaServlet" method="POST">
				<input type="submit" value="Area Personale" class="top-buttons__button">
			</form>

			<%
			} else {
			%>
			<form action="LoginScreen.jsp" method="POST">
				<input type="submit" value="Accedi o registrati" class="top-buttons__button">
			</form>
			<%
			}
			%>
			<form action="CartServlet" method="post">
				<input type="submit" value="Carrello" class="top-buttons__button">
			</form>
			<form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo" class="top-buttons__button">
			</form>
		
		<%
		} else if (path.contains("/LoginScreen.jsp")) {
		%>
		
			<form action="CartServlet" method="post">
				<input type="submit" value="Carrello" class="top-buttons__button">
			</form>
			<form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo" class="top-buttons__button">
			</form>
			<form action="index.jsp" method="POST">
				<input type="submit" value="Home" class="top-buttons__button">
			</form>
		
		<%
		} else if (path.contains("/RegisterPage.jsp")) {
		%>
		
			<form action="CartServlet" method="post">
				<input type="submit" value="Carrello" class="top-buttons__button">
			</form>
			<form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo" class="top-buttons__button">
			</form>
			<form action="index.jsp" method="POST">
				<input type="submit" value="Home" class="top-buttons__button">
			</form>
		
		<%
		} else if (path.contains("/OrderPage.jsp")) {
		%>
		
			<form action="CartServlet" method="post">
				<input type="submit" value="Carrello" class="top-buttons__button">
			</form>
			<form action="LogoutServlet" method="POST">
				<input type="submit" value="Logout" class="top-buttons__button">
			</form>
			<form action="index.jsp" method="POST">
				<input type="submit" value="Home" class="top-buttons__button">
			</form>
			<form action="PersonalAreaServlet" method="POST">
				<input type="submit" value="Area Personale" class="top-buttons__button">
			</form>
			<form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo" class="top-buttons__button">
			</form>
		
		<%
		} else if (path.contains("/PAView.jsp")) {
		%>
		
			<form action="CartServlet" method="post">
				<input type="submit" value="Carrello" class="top-buttons__button">
			</form>
			<form action="LogoutServlet" method="POST">
				<input type="submit" value="Logout" class="top-buttons__button">
			</form>
			<form action="index.jsp" method="POST">
				<input type="submit" value="Home" class="top-buttons__button">
			</form>
			<form action="OrderServlet" method="POST">
				<input type="submit" name="action" value="Storico ordini" class="top-buttons__button">
			</form>
			<form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo" class="top-buttons__button">
			</form>
		
		<%
		} else if (path.contains("/Catalogo.jsp")) {
		%>
		
			<form action="index.jsp" method="POST">
				<input type="submit" value="Home" class="top-buttons__button">
			</form>
			<%
			if (session.getAttribute("username") != null) {
			%>
			<form action="LogoutServlet" method="POST">
				<input type="submit" value="Logout" class="top-buttons__button">
			</form>
			<form action="PersonalAreaServlet" method="POST">
				<input type="submit" value="Area Personale" class="top-buttons__button">
			</form>
			<%
			} else {
			%>
			<form action="LoginScreen.jsp" method="POST">
				<input type="submit" value="Accedi o registrati" class="top-buttons__button">
			</form>
			<%
			}
			%>
			<form action="CartServlet" method="post">
				<input type="submit" value="Carrello" class="top-buttons__button">
			</form>
		
		<%
		} else if (path.contains("/CartView.jsp")) {
		%>
		
			<form action="index.jsp" method="POST">
				<input type="submit" value="Home" class="top-buttons__button">
			</form>
			<%
			if (session.getAttribute("username") != null) {
			%>
			<form action="LogoutServlet" method="POST">
				<input type="submit" value="Logout" class="top-buttons__button">
			</form>
			<form action="PersonalAreaServlet" method="POST">
				<input type="submit" value="Area Personale" class="top-buttons__button">
			</form>
			<%
			} else {
			%>
			<form action="LoginScreen.jsp" method="POST">
				<input type="submit" value="Accedi o registrati" class="top-buttons__button">
			</form>
			<%
			}
			%>
			<form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo" class="top-buttons__button">
			</form>
		
			
		<%
		} else if (path.contains("/OrderView.jsp")) {
			%>
			
	<form action="CartServlet" method="post">
		<input type="submit" value="Carrello" class="top-buttons__button">
	</form>
	<form action="LogoutServlet" method="POST">
        <input type="submit" value="Logout" class="top-buttons__button">
    </form>
   	<form action="index.jsp" method="POST">
        <input type="submit" value="Home" class="top-buttons__button">
    </form>
    <form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo" class="top-buttons__button">
			</form>
		

			<%
		} else if (path.contains("/PaginaProdotto.jsp")) {
			%>
			
			<form action="index.jsp" method="POST">
				<input type="submit" value="Home" class="top-buttons__button">
			</form>
			<%
			if (session.getAttribute("username") != null) {
			%>
			<form action="LogoutServlet" method="POST">
				<input type="submit" value="Logout" class="top-buttons__button">
			</form>
			<form action="PersonalAreaServlet" method="POST">
				<input type="submit" value="Area Personale" class="top-buttons__button">
			</form>

			<%
			} else {
			%>
			<form action="LoginScreen.jsp" method="POST">
				<input type="submit" value="Accedi o registrati" class="top-buttons__button">
			</form>
			<%
			}
			%>
			<form action="CartServlet" method="post">
				<input type="submit" value="Carrello" class="top-buttons__button">
			</form>
			<form action="CatalogServlet" method="post">
				<input type="submit" value="Catalogo" class="top-buttons__button">
			</form>
		

			<%
			}
			%>
			</div>
	</header>
</body>
</html>