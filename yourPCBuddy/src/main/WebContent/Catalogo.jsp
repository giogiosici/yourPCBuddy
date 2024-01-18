<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.ProductBean" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="./Scripts/CatalogScript.js"></script>
    <link href="Styles/Slider.css" rel="stylesheet" type="text/css">
    <% Collection<ProductBean> AllProducts = (Collection<ProductBean>) session.getAttribute("AllProducts");%>
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
    
    <div class="slider-wrapper">
        <div class="price-input-container"> 
        	<div class="price-input"> 
        		<div class="price-field"> 
                	<span>Minimum Price</span> 
                    <input type="number" 
                    class="min-input" 
                    value="100"
                    onchange="sliderCatalogo()"> 
                </div> <!-- price-field 1 -->
                <div class="price-field"> 
                	<span>Maximum Price</span> 
                    <input type="number" 
                    class="max-input" 
                    value="2000"
                    onchange="sliderCatalogo()"> 
                </div> <!-- price-field 2 -->
            </div> <!-- price-input -->
            <div class="slider-container"> 
                <div class="price-slider"> 
                </div> <!-- price-slider -->
            </div> <!--slider-container -->
       </div> <!-- price-input-container -->
  
            <!-- Slider -->
        <div class="range-input"> 
            <input type="range" 
                   class="min-range" 
                   id = "min-range"
                   min="0" 
                   max="5000" 
                   value="100" 
                   step="10"
                   onchange="sliderCatalogo()"> 
            <input type="range" 
                   class="max-range" 
                   id = "max-range"
                   min="0" 
                   max="5000" 
                   value="2000" 
                   step="10"
                   onchange="sliderCatalogo()"> 
		</div><!-- range-input -->
    </div>
    <div class="prodotti" align="center">
        <h2>Catalogo</h2>
        <div class="container">
            <form class="search" id="search-bar" onsubmit="return false;">
                <input type="search" placeholder="Type something..." name="q" class="search__input" onkeyup="searchAndFilter()">
            </form>
        </div>
		
        <% if (AllProducts != null && !AllProducts.isEmpty()) { %>
            <% for (ProductBean bean : AllProducts) { %>
            <div class="schedaProdotto">
                <a href="javascript:void(0);" onclick="redirectToProduct('<%= bean.getCode() %>')">
                    <img src="./Images/<%= bean.getImage() %>" alt="Immagine" width="100" />
                </a>
                <p class="product-name"><%=bean.getName()%></p>
                <p class="product-price"><%= String.format("%.2f", bean.getPrice()) %></p>
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
<script>
  document.addEventListener("DOMContentLoaded", function () {
    sliderCatalogo();
  });
</script>

</html>
