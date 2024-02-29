function updateTotalPrice(input) {
    	let quantity = parseFloat(input.value);
    	let price = parseFloat(input.parentNode.previousElementSibling.innerHTML);
    	let totalPriceElement = document.getElementById('totalPrice');
    	let totalPrice = parseFloat(totalPriceElement.innerHTML);

    // Calcola il prezzo totale senza considerare la quantità
    	let previousPrice = parseFloat(input.getAttribute('data-previous-price')) || 0;
    	totalPrice -= previousPrice;

	    let newPrice = price * quantity;
    	totalPrice += newPrice;

    // Aggiorna l'attributo 'data-previous-price' con il nuovo prezzo
   		input.setAttribute('data-previous-price', newPrice);
    	totalPriceElement.innerHTML = totalPrice.toFixed(2);
}
