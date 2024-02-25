function toggleInsertDropdown() {
    var insertDropdown = document.getElementById("insertProduct");
    var updateDropdown = document.getElementById("updateProduct");
    var toggleButtonInsert = document.getElementById("toggleButtonInsert");
    var toggleButtonUpdate = document.getElementById("toggleButtonUpdate");

    if (insertDropdown.style.display === "none") {
        // Mostra il menu di inserimento e nascondi quello di aggiornamento
        insertDropdown.style.display = "block";
        toggleButtonInsert.innerHTML = "Annulla";
        updateDropdown.style.display = "none";
        toggleButtonUpdate.innerHTML = "Aggiorna";
    } else {
        // Nascondi il menu di inserimento
        insertDropdown.style.display = "none";
        toggleButtonInsert.innerHTML = "Inserisci prodotto";
    }
}


function cancelInsert() {
    var dropdown = document.getElementById("insertProduct");

    // Nascondi il dropdown
    dropdown.style.display = "none";
}

//prova
function toggleUpdateDropdown(productId) {
    var insertDropdown = document.getElementById("insertProduct");
    var updateDropdown = document.getElementById("updateProduct");
    var toggleButtonInsert = document.getElementById("toggleButtonInsert");

    if (updateDropdown.style.display === "none") {
        // Mostra il menu di aggiornamento e nascondi quello di inserimento
        updateDropdown.style.display = "block";
        insertDropdown.style.display = "none";
        toggleButtonInsert.innerHTML = "Inserisci prodotto";
        populateForm(productId); // Chiama populateForm() quando il menu di aggiornamento viene aperto
         var updateButton = document.getElementById("updateProductButton");
        updateButton.setAttribute("productId", productId);
        
    } else {
        // Nascondi il menu di aggiornamento
        updateDropdown.style.display = "none";
        updateButton.removeAttribute("productId");

        
    }
}

function populateForm(productId) {
    $.ajax({
        url: 'product', // Sostituisci con l'URL della tua servlet
        type: 'POST',
            dataType: 'json', // Specifica che ci si aspetta una risposta JSON

        data: {  id : productId,
            action: 'pdate',
             // Azione per ottenere i dati del prodotto esistente
            // Altri parametri se necessario
        },
        success: function(response) {
            // Popola il form con i dati ottenuti dalla chiamata AJAX
            var existingProduct = response.existingProduct;
	
            $('#updateProduct input[name="id"]').val(existingProduct.id);
            $('#updateProduct input[name="name"]').attr('placeholder', existingProduct.name);
			$('#updateProduct textarea[name="description"]').val(existingProduct.description);
			$('#updateProduct input[name="price"]').attr('placeholder', existingProduct.price);
			$('#updateProduct input[name="quantity"]').attr('placeholder', existingProduct.quantity);
			$('#updateProduct input[name="Categoria"]').attr('placeholder', existingProduct.categoria);
			$('#updateProduct input[name="Marca"]').attr('placeholder', existingProduct.brand);
            // Popola gli altri campi del form allo stesso modo

            // Mostra il form dopo averlo popolato
            $('#updateProduct').show();
        },
        error: function(xhr, status, error) {
            // Gestisci gli errori
        }
    });
}

function cancelUpdate() {
    document.getElementById("updateProduct").style.display = "none"; // Nasconde il form
    toggleDropdown(); // Chiama la funzione per chiudere il dropdown
}

function submitUpdateForm() {
    var productId = document.getElementById("updateProductButton").getAttribute("productId");
    if (productId) {
        // Imposta il valore di productId nel campo nascosto del modulo
        document.getElementById("productIdField").value = productId;
        // Invia il modulo
        document.getElementById("updateProductForm").submit();
    } else {
        // Gestisci l'assenza di productId
    }
}
