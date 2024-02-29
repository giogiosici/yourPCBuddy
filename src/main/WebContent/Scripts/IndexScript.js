function redirectToProduct(productId) {
	window.location.href = 'PaginaProdotto.jsp?productId=' + productId;
}

$(document).ready(function() {
	
	$('.IndexProduct').submit(function(e) {
		e.preventDefault(); // Previene l'invio predefinito del form
		let formData = $(this).serialize(); // Ottiene i dati del form serializzati

		// Trova il campo "quantity" associato a questo form
		let quantityField = $('#quantity_' + $(this).find('input[name="id"]').val());

		// Ottieni il valore corrente del campo "quantity" e convertilo in un numero intero
		let currentQuantity = parseInt(quantityField.val());

		// Incrementa il valore di "quantity" di 1
		let newQuantity = currentQuantity + 1;

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

//barra di ricerca

document.addEventListener('DOMContentLoaded', function() {
	localStorage.removeItem('searchQuery');
    const searchForm = document.getElementById('search-form');
    searchForm.addEventListener('submit', function(event) {
        event.preventDefault(); // Evita il comportamento predefinito del modulo

        // Recupera il valore di ricerca inserito dall'utente
        const searchInput = document.getElementById('search-input');
        const searchQuery = searchInput.value.trim();

        // Verifica se il valore di ricerca non è vuoto
        if (searchQuery !== '') {
            // Salva il valore di ricerca in localStorage
            localStorage.setItem('searchQuery', searchQuery);

            // Invia il modulo
            this.submit();
        }
    });
});




