<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.ProductBean"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="it">
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="./Scripts/CatalogScript.js"></script>

<link href="Styles/Catalogo.css" rel="stylesheet" type="text/css">


<%
Collection<ProductBean> AllProducts = (Collection<ProductBean>) session.getAttribute("AllProducts");
%>


<meta charset="UTF-8">
<title>Catalogo</title>
<jsp:include page="Header.jsp" flush="true"/>

</head>
<body>
	<h2 align = "center">Catalogo</h2>
	<div class="container">
    <form class="search" id="search-bar">
        <input type="search" placeholder="Type something..." name="q" id="search-input" class="search__input" onkeyup="searchAndFilter()">
        <div class="search__button" id="search-button">
            <i class="ri-search-2-line search__icon"></i>
            <i class="ri-close-line search__close"></i>
        </div>
    </form>
</div>

		<div id="filtriEProdotti">
<div id="filtri">
	<div class="slider-wrapper">
	<div class="price-input-container">
		<div class="price-input">
			<div class="price-field">
				<span>Da</span> <input type="number" class="min-input"
					value="100" onchange="sliderCatalogo()" min="0" max="5000">
			</div>
			<!-- price-field 1 -->
			<div class="price-field">
				<span>A</span> <input type="number" class="max-input"
					value="2000" onchange="sliderCatalogo()" min="0" max="5000">
			</div>
			<!-- price-field 2 -->
		</div>
		<!-- price-input -->
		<div class="slider-container">
			<div class="price-slider"></div>
			<!-- price-slider -->
		</div>
		<!--slider-container -->
	</div>
	<!-- price-input-container -->

	<!-- Slider -->
	<div class="range-input">
		<input type="range" class="min-range" id="min-range" min="0"
			max="5000" value="100" step="10" onchange="sliderCatalogo()">
		<input type="range" class="max-range" id="max-range" min="0"
			max="5000" value="2000" step="10" onchange="sliderCatalogo()">
	</div>
	<!-- range-input -->
</div>
	
	<div class="checkbox">
		<form>
		<h4>Categorie</h4>
    <% 
        if (AllProducts != null && !AllProducts.isEmpty()) { 
            Set<String> uniqueCategories = new HashSet<>();
            Set<String> uniqueBrands = new HashSet<>();

            for (ProductBean bean : AllProducts) {
                uniqueCategories.add(bean.getCategoria());
                uniqueBrands.add(bean.getBrand());
            }

            for (String category : uniqueCategories) {
    %>
                <label><input type="checkbox" name="category" value="<%= category %>"> <%= category %></label><br>
                
    <%
            }
            %>
            <h4>Marche</h4>
            <%
            for (String brand : uniqueBrands) {
    %>
                <label><input type="checkbox" name="brand" value="<%= brand %>"> <%= brand %></label><br>
    <%
            }
        }
    %>
</form>
<div id="noProductsMessage" style="display: none;">
 <p align="center"> Nessun prodotto rispecchia i filtri selezionati.</p>
</div>

	</div>
	
	
		
		
	</div>
	<div class="prodotti" align="center">
		<%
		if (AllProducts != null && !AllProducts.isEmpty()) {
			for (ProductBean bean : AllProducts) {
		%>
		<div class="schedaProdotto" data-category="<%=bean.getCategoria()%>" data-brand="<%=bean.getBrand()%>">
			<a href="javascript:void(0);"
				onclick="redirectToProduct('<%=bean.getCode()%>')"> <img
				src="./Images/<%=bean.getImage()%>" alt="Immagine" width="100" />
			</a>
			<p class="product-name"><%=bean.getName()%></p>
			<p class="product-price"><%=String.format("%.2f", bean.getPrice())%>  &euro;</p>
			<%if(bean.getQuantity()>0){ %>
			<form action="CartServlet" method="POST" class="CatalogProduct">
            <input type="hidden" name="action" value="addC">
            <input type="hidden" name="id" value="<%=bean.getCode()%>">
		    <input type="submit" value="Aggiungi al carrello">
        </form>
			<%} else{%>
        	<p>Esaurito</p>
    <%} %>
		</div>
		<%
		}
		%>
		<%
		} else {
		%>
		<p>Nessun prodotto disponibile</p>
		<%
		}
		%>
	</div>
	</div>
	<jsp:include page="Footer.jsp" flush="true"></jsp:include>
	
</body>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    sliderCatalogo();
  });
</script>
</html>
