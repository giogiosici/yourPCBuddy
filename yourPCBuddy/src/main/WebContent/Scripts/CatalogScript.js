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
const toggleSearch = (search, button) =>{
   const searchBar = document.getElementById(search),
         searchButton = document.getElementById(button)

   searchButton.addEventListener('click', () =>{
       // We add the show-search class, so that the search bar expands
       searchBar.classList.toggle('show-search')
   })
}
toggleSearch('search-bar', 'search-button')

// Includi la funzione di ricerca JavaScript qui
        function searchAndFilter() {
            var searchQuery = document.getElementById('search-bar').querySelector('input[name="q"]').value.toLowerCase();

            var products = document.querySelectorAll('.schedaProdotto');

            products.forEach(function (product) {
                var productName = product.querySelector('.product-name').innerText.toLowerCase();

                if (productName.includes(searchQuery)) {
                    product.style.display = 'block';
                } else {
                    product.style.display = 'none';
                }
            });
        }

        window.onload = searchAndFilter;