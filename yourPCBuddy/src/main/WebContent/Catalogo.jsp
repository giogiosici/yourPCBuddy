<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.ProductBean" %>
<%@ page import="java.util.Collection" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="./Scripts/CatalogScript.js"></script>
    
    <meta charset="UTF-8">
    <title>Catalogo</title>
</head>
<body>
    <form action="index.jsp" method="POST">
        <input type="submit" value="Home">
    </form>
    <% if (session.getAttribute("username") != null) { %>
        <form action="LogoutServlet" method="POST">
            <input type="submit" value="Logout">
        </form>
        <form action="PersonalAreaServlet" method="POST">
            <input type="submit" value="Area Personale">
        </form>
    <% } else { %>
        <form action="LoginScreen.jsp" method="POST">
            <input type="submit" value="Accedi o registrati">
        </form>
    <% } %>
    <form action="CartServlet" method="post">
        <input type="submit" value="carrello">
    </form>

    <div class="prodotti" align="center">
        <h2>Catalogo</h2>
        <div class="container">
            <form class="search" id="search-bar">
                <input type="search" placeholder="Type something..." name="q" class="search__input" onkeyup="searchAndFilter()">
    
                <div class="search__button" id="search-button">
                    <i class="ri-search-2-line search__icon"></i>
                    <i class="ri-close-line search__close"></i>
                </div>
            </form>
        </div>
        <% Collection<ProductBean> AllProducts = (Collection<ProductBean>) session.getAttribute("AllProducts");%>
        <% if (AllProducts != null && !AllProducts.isEmpty()) { %>
            <% for (ProductBean bean : AllProducts) { %>
            <div class="schedaProdotto">
                <a href="javascript:void(0);" onclick="redirectToProduct('<%= bean.getCode() %>')">
                    <img src="./Images/<%= bean.getImage() %>" alt="Immagine" width="100" />
                </a>
                <p class="product-name"><%=bean.getName()%></p>
                <p><%= String.format("%.2f", bean.getPrice()) %></p>
                <form action="CartServlet" method="POST" class="CatalogProduct">
                    <input type="hidden" name="action" value="addC">
                    <input type="hidden" name="id" value="<%=bean.getCode()%>">
                    <input type="submit" value="Aggiungi al carrello">
                </form>
                </div>
            <% } %>
        <% } else { %>
            <p>Nessun prodotto disponibile</p>
        <% } %>
    </div>
</body>
</html>
