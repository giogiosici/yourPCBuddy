function redirectToProduct(productId) {
	window.location.href = 'PaginaProdotto.jsp?productId=' + productId;
}

$(document).ready(function() {
	$('.CatalogProduct').submit(function(e) {
		e.preventDefault(); // Previene l'invio predefinito del form

		var formData = $(this).serialize(); // Ottiene i dati del form serializzati

		// Trova il campo "quantity" associato a questo form
		var quantityField = $('#quantity_' + $(this).find('input[name="id"]').val());

		// Ottieni il valore corrente del campo "quantity" e convertilo in un numero intero
		var currentQuantity = parseInt(quantityField.val());

		// Incrementa il valore di "quantity" di 1
		var newQuantity = currentQuantity + 1;

		// Imposta il nuovo valore di "quantity" nel campo
		quantityField.val(newQuantity);

		// Invia la richiesta AJAX al tuo form di destinazione
		$.ajax({
			url: 'CartServlet',
			type: 'POST',
			data: formData,
			success: function(response) {
				// Gestisci la risposta del server, se necessario
			},
			error: function(xhr, status, error) {
				// Gestisci gli errori, se necessario
			}
		});
	});
});

/*=============== SEARCH BAR JS ===============*/

// Includi la funzione di ricerca JavaScript qui
function searchAndFilter() {
	var searchQuery = document.getElementById('search-bar').querySelector('input[name="q"]').value.toLowerCase();

	var products = document.querySelectorAll('.schedaProdotto');

	products.forEach(function(product) {
		var productName = product.querySelector('.product-name').innerText.toLowerCase();

		if (productName.includes(searchQuery)) {
			product.style.display = 'block';
		} else {
			product.style.display = 'none';
		}
	});
}

window.onload = searchAndFilter;

//searchbar da un'altra pagina
window.onload = function() {
    const storedSearchQuery = localStorage.getItem('searchQuery');
    if (storedSearchQuery) {
        const searchInput = document.getElementById('search-input');
        searchInput.value = storedSearchQuery;
        localStorage.removeItem('searchQuery');
	
    }
    searchAndFilter();
};

/*=============== Filtri prodotti JS ===============*/
// Funzione per filtrare i prodotti per prezzo

function sliderCatalogo() {

	const rangevalue =
		document.querySelector(".slider-container .price-slider");
	const rangeInputvalue =
		document.querySelectorAll(".range-input input");

	// Set the price gap 
	let priceGap = 10;

	// Adding event listners to price input elements 
	const priceInputvalue =
		document.querySelectorAll(".price-input input");
	for (let i = 0; i < priceInputvalue.length; i++) {
		priceInputvalue[i].addEventListener("input", e => {

			// Parse min and max values of the range input 
			let minp = parseInt(priceInputvalue[0].value) || 0;
			let maxp = parseInt(priceInputvalue[1].value) || Number.MAX_VALUE;
			let diff = maxp - minp;

			sliderPrice(minp,maxp);

			if (minp < 0) {
				alert("minimum price cannot be less than 0");
				priceInputvalue[0].value = 0;
				minp = 0;
			}

			// Validate the input values 
			/*if (maxp > 10000) { 
				alert("maximum price cannot be greater than 10000"); 
				priceInputvalue[1].value = 10000;
				 
			 
			} */

			if (minp > maxp - priceGap) {
				priceInputvalue[0].value = maxp - priceGap;
				minp = maxp - priceGap;

				if (minp < 0) {
					priceInputvalue[0].value = 0;
					minp = 0;
				}

			}



			/*else if (maxp < minp + priceGap) {
				priceInputvalue[1].value = minp + priceGap;
				maxp=minp + priceGap;
				}*/
			// Check if the price gap is met 
			// and max price is within the range 
			if (diff >= priceGap && maxp <= rangeInputvalue[1].max) {
				if (e.target.className === "min-input") {
					rangeInputvalue[0].value = minp;
					let value1 = rangeInputvalue[0].max;
					rangevalue.style.left = `${(minp / value1) * 100}%`;
					
				}
				else {
					rangeInputvalue[1].value = maxp;
					let value2 = rangeInputvalue[1].max;
					rangevalue.style.right =
						`${100 - (maxp / value2) * 100}%`;
				}
			}
		});

		// Add event listeners to range input elements 
		for (let i = 0; i < rangeInputvalue.length; i++) {
			rangeInputvalue[i].addEventListener("input", e => {
				let minVal =
					parseInt(rangeInputvalue[0].value);
				let maxVal =
					parseInt(rangeInputvalue[1].value);

				let diff = maxVal - minVal;
				sliderPrice(minVal,maxVal);
				// Check if the price gap is exceeded 
				if (diff < priceGap) {

					// Check if the input is the min range input 
					if (e.target.className === "min-range") {
						rangeInputvalue[0].value = maxVal - priceGap;
					}
					else {
						rangeInputvalue[1].value = minVal + priceGap;
					}
				}
				else {

					// Update price inputs and range progress 
					priceInputvalue[0].value = minVal;
					priceInputvalue[1].value = maxVal;
					rangevalue.style.left =
						`${(minVal / rangeInputvalue[0].max) * 100}%`;
					rangevalue.style.right =
						`${100 - (maxVal / rangeInputvalue[1].max) * 100}%`;
				}
			});
		}
	}
	
}

function sliderPrice() {
  // Ottenere tutte le schede prodotto
  var products = document.getElementsByClassName('schedaProdotto');

  // Filtrare i prodotti in base al range di prezzo
  for (var i = 0; i < products.length; i++) {
    var product = products[i];
    var price = parseFloat(product.querySelector('.product-price').innerText.replace(',', '.'));

    var pricePass = isPriceInRange(price);

    // Visualizzare o nascondere il prodotto in base ai filtri
    if (pricePass && isCheckboxFiltered(product)) {
      product.style.display = '';
    } else {
      product.style.display = 'none';
    }
  }
}

function isPriceInRange(price) {
  // Ottenere i valori del range di prezzo
  var minPrice = parseFloat(document.querySelector('.min-input').value);
  var maxPrice = parseFloat(document.querySelector('.max-input').value);

  // Verificare se il prezzo è compreso nel range
  return price >= minPrice && price <= maxPrice;
}

function isCheckboxFiltered(product) {
  const category = product.getAttribute('data-category');
  const brand = product.getAttribute('data-brand');
  const categoryCheckboxes = document.querySelectorAll('input[name="category"]');
  const brandCheckboxes = document.querySelectorAll('input[name="brand"]');
  const visibleCategories = Array.from(categoryCheckboxes).filter(checkbox => checkbox.checked).map(checkbox => checkbox.value);
  const visibleBrands = Array.from(brandCheckboxes).filter(checkbox => checkbox.checked).map(checkbox => checkbox.value);

  // Controlla se la categoria del prodotto è inclusa tra quelle selezionate
  const isVisibleCategory = visibleCategories.length === 0 || visibleCategories.includes(category);

  // Controlla se il marchio del prodotto è inclusa tra quelli selezionati
  const isVisibleBrand = visibleBrands.length === 0 || visibleBrands.includes(brand);

  // Restituisci true solo se sia la categoria che il marchio sono visibili
  return isVisibleCategory && isVisibleBrand;
}



/*=============== checkbox ===============*/

document.addEventListener("DOMContentLoaded", function () {
  const categoryCheckboxes = document.querySelectorAll('input[name="category"]');
  const brandCheckboxes = document.querySelectorAll('input[name="brand"]');
  const products = document.querySelectorAll('.schedaProdotto');

  function filterCheckbox() {
    const visibleCategories = Array.from(categoryCheckboxes).filter(checkbox => checkbox.checked).map(checkbox => checkbox.value);
    const visibleBrands = Array.from(brandCheckboxes).filter(checkbox => checkbox.checked).map(checkbox => checkbox.value);
	let productsFound = false;
	
	
    products.forEach(product => {
      const category = product.getAttribute('data-category');
      const brand = product.getAttribute('data-brand');

      // Controlla se la categoria del prodotto è inclusa tra quelle selezionate
      const isVisibleCategory = visibleCategories.length === 0 || visibleCategories.includes(category);

      // Controlla se il marchio del prodotto è incluso tra quelli selezionati
      const isVisibleBrand = visibleBrands.length === 0 || visibleBrands.includes(brand);

      // Mostra il prodotto solo se soddisfa entrambi i filtri
      if (isVisibleCategory && isVisibleBrand) {
        product.style.display = "block";
        productsFound = true;
      } else {
        product.style.display = "none";
      }
    });
    // Mostra il messaggio se nessun prodotto è stato trovato
  const noProductsMessage = document.getElementById('noProductsMessage');
  	if (productsFound) {
    	noProductsMessage.style.display = "none";
  	} else {
    	noProductsMessage.style.display = "block";
  	}
  }

  // Aggiungi event listener per le checkbox
  categoryCheckboxes.forEach(checkbox => checkbox.addEventListener('change', filterCheckbox));
  brandCheckboxes.forEach(checkbox => checkbox.addEventListener('change', filterCheckbox));

  // Chiamata iniziale per filtrare i prodotti correttamente all'avvio
  filterCheckbox();
});








