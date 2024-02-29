function searchAndFilter() {
        // Otteniamo il testo di ricerca dalla casella di ricerca
        let searchQuery = document.getElementById('search-bar').querySelector('input[name="q"]').value.toLowerCase();

        // Ottieni tutti gli elementi della tabella dei prodotti
        let products = document.querySelectorAll('.product-row');

        // Itera su ciascun elemento e nascondi o mostra in base alla ricerca
        products.forEach(function (product) {
            let productName = product.querySelector('.product-name').innerText.toLowerCase();

            if (productName.includes(searchQuery)) {
                // Se il nome del prodotto contiene la query di ricerca, mostra l'elemento
                product.style.display = 'table-row';
            } else {
                // Altrimenti, nascondi l'elemento
                product.style.display = 'none';
            }
        });
    }

    // Chiama la funzione di filtro quando la pagina è completamente caricata
    window.onload = searchAndFilter;
    
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