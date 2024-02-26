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

//update
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
}

function submitUpdateForm() {
    var productId = document.getElementById("updateProductButton").getAttribute("productId");
    if (productId) {
        // Imposta il valore di productId nel campo nascosto del modulo
        document.getElementById("productIdField").value = productId;
        
        // Mostra l'alert di SweetAlert
        Swal.fire({
            title: 'Successo!',
            text: 'Prodotto aggiornato con successo!',
            icon: 'success',
            confirmButtonText: 'Ok'
        }).then((result) => {
            // Questa funzione viene chiamata dopo che l'utente ha cliccato "Ok"
            if (result.value) {
                // Invia il modulo
                document.getElementById("updateProductForm").submit();
            }
        });
    } else {
        // Gestisci l'assenza di productId
        Swal.fire({
            title: 'Errore!',
            text: 'ID prodotto non trovato. Impossibile aggiornare.',
            icon: 'error',
            confirmButtonText: 'Ok'
        });
    }
}

//prova
function toggleDetailsDropdown(productId) {
    var detailsDropdown = document.getElementById("detailsTable");
    var toggleButtonDetails = document.getElementById("toggleButtonDetails");

    if (detailsDropdown.style.display === "none") {
        // Mostra il menu di aggiornamento e nascondi quello di inserimento
       	detailsDropdown.style.display = "block";        
       populateDetails(productId); // Chiama populateForm() quando il menu di aggiornamento viene aperto

    } else {
        // Nascondi il menu di aggiornamento
        detailsDropdown.style.display = "none";       
    }
}

function populateDetails(productId) {
    console.log("showtime");
    $.ajax({
        url: 'product',
        type: 'POST',
        dataType: 'json',
        data: {
            id: productId,
            action: 'details'
        },
       success: function(response) {
    var product = response.product;
    if (product) {
        $('#code').text(product.code);
        $('#brand').text(product.brand);
        $('#name').text(product.name);
        $('#image').attr('src', 'Images/' + product.image);
        $('#description').text(product.description);
        $('#price').text(product.price.toFixed(2));
        $('#quantity').text(product.quantity);
        $('#categoria').text(product.categoria);
        
        $('#detailsTable').show();
    } else {
        console.log('Il prodotto è nullo.');
    }
},

        error: function(xhr, status, error) {
            // Gestisci gli errori
        }
    });
}
function cancelDetails() {
    document.getElementById("detailsTable").style.display = "none"; // Nasconde il form
}