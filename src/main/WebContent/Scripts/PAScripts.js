//Indirizzo
function toggleAddressDropdown() {
    var dropdown = document.getElementById("addressDropdown");
    var currentAddress = document.getElementById("currentAddress");
    var toggleButtonAddress = document.getElementById("toggleButtonAddress");

    if (dropdown.style.display === "none") {
        // Mostra il dropdown e nascondi l'indirizzo attuale
        dropdown.style.display = "block";
        currentAddress.style.display = "none";
        toggleButtonAddress.innerHTML = "Annulla";
    } else {
        // Nascondi il dropdown e mostra l'indirizzo attuale
        dropdown.style.display = "none";
        currentAddress.style.display = "block";
        toggleButtonAddress.innerHTML = "Aggiorna indirizzo";
    }
}

    
function cancelAddressUpdate() {
    var dropdown = document.getElementById("addressDropdown");
    var currentAddress = document.getElementById("currentAddress");
    var toggleButtonAddress = document.getElementById("toggleButtonAddress");
    var confirmButtonAddress = document.getElementById("confirmButtonAddress");

    // Nascondi il dropdown e mostra l'indirizzo attuale
    dropdown.style.display = "none";
    currentAddress.style.display = "block";

    // Mostra il pulsante "Aggiorna indirizzo" e nascondi il pulsante "Annulla" e "Conferma"
    toggleButtonAddress.style.display = "block";
    confirmButtonAddress.style.display = "none";
}

function validateForm() {
    var state = document.getElementById("state").value;
    var street = document.getElementById("street").value;
    var number = document.getElementById("number").value;
    var city = document.getElementById("city").value;
    var provincia = document.getElementById("provincia").value;
    var zip = document.getElementById("zip").value;
    
    // Verifica che il CAP sia composto solo da numeri e abbia una lunghezza massima di 5
    var zipPattern = /^\d{5}$/;
    var lettersPattern = /^[A-Za-z\s]+$/;
    var numbersPattern = /^[1-9]\d*[a-zA-Z]?$/;
    var provPattern = /^[A-Za-z]{2}$/;
    var addressPattern = /^(Via |Viale |via |viale |Piazza |piazza |Traversa |traversa )[A-Za-z\s]+$/;
    
    if (!state.match(lettersPattern)) {
        // Utilizza SweetAlert2 per visualizzare un messaggio di avviso personalizzato
        Swal.fire({
            icon: 'error',
            title: 'Errore',
            text: 'Inserire uno stato valido.'
        });
        return false;
    }
    if (!city.match(lettersPattern)) {
        // Utilizza SweetAlert2 per visualizzare un messaggio di avviso personalizzato
        Swal.fire({
            icon: 'error',
            title: 'Errore',
            text: 'Inserire una città valida.'
        });
        return false;
    }
    
    if (!street.match(addressPattern)) {
        // Utilizza SweetAlert2 per visualizzare un messaggio di avviso personalizzato
        Swal.fire({
            icon: 'error',
            title: 'Errore',
            text: 'Inserire una via valida.'
        });
        return false;
    }
    
    if (!provincia.match(provPattern)) {
        // Utilizza SweetAlert2 per visualizzare un messaggio di avviso personalizzato
        Swal.fire({
            icon: 'error',
            title: 'Errore',
            text: 'Inserire una provincia valida.'
        });
        return false;
    }
    
    if (!number.match(numbersPattern)) {
        // Utilizza SweetAlert2 per visualizzare un messaggio di avviso personalizzato
        Swal.fire({
            icon: 'error',
            title: 'Errore',
            text: 'Inserire un numero civico valido.'
        });
        return false;
    }
    
    
    if (!zip.match(zipPattern)) {
        // Utilizza SweetAlert2 per visualizzare un messaggio di avviso personalizzato
        Swal.fire({
            icon: 'error',
            title: 'Errore',
            text: 'Inserire un CAP valido.'
        });
        return false;
    }
    
     
    
    // Puoi aggiungere ulteriori controlli qui per gli altri campi se necessario
    
    return true; // Se tutti i campi sono validi, il modulo verrà inviato al server
}
//Fine Indirizzo

//Email 
function toggleEmailDropdown() {
    var currentEmail = document.getElementById("currentEmail");
    var dropdown = document.getElementById("emailDropdown");
    var toggleButtonEmail = document.getElementById("toggleButtonEmail");

    if (dropdown.style.display === "none") {
        // Nascondi l'indirizzo email corrente
        currentEmail.style.display = "none";
        // Mostra il dropdown
        dropdown.style.display = "block";
        toggleButtonEmail.innerHTML = "Annulla";
    } else {
        // Mostra l'indirizzo email corrente
        currentEmail.style.display = "block";
        // Nascondi il dropdown
        dropdown.style.display = "none";
        toggleButtonEmail.innerHTML = "Aggiorna email";
    }
}


function cancelEmailUpdate() {
    var dropdown = document.getElementById("emailDropdown");
    var toggleButtonEmail = document.getElementById("toggleButtonEmail");

    // Nascondi il dropdown
    dropdown.style.display = "none";
    toggleButtonEmail.innerHTML = "Aggiorna email";
}

function validateEmail() {
    var emailInput = document.getElementById("email").value;

    if (emailInput.indexOf('@') === -1) {
        Swal.fire({
            title: 'Errore',
            text: 'Email non valida!',
            icon: 'error',
            confirmButtonText: 'OK'
        });
        return false; // Blocca l'invio del form se la validazione fallisce
    }

    var domain = emailInput.split('@')[1];

    if (domain.endsWith('.com') || domain.endsWith('.it')) {
        // Consente l'invio del form se la validazione è passata
    } else {
        Swal.fire({
            title: 'Errore',
            text: 'Email non valida!',
            icon: 'error',
            confirmButtonText: 'OK'
        });
        return false; // Blocca l'invio del form se la validazione fallisce
    }
}
