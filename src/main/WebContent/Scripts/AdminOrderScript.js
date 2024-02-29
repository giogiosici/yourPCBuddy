function filterRows() {
    let input = document.getElementById("searchInput").value.toLowerCase();
    let startDateString = document.getElementById("startDateInput").value;
    let endDateString = document.getElementById("endDateInput").value;
    let rows = document.querySelectorAll("#container tr");
	
    let startDate = new Date(startDateString);
    let endDate = new Date(endDateString);
    let formattedStartDate = formatDate(startDate);
    let formattedEndDate = formatDate(endDate);

    for (const row of rows) {
        let userId = row.getAttribute("data-utente");
        console.log(userId);
        let giorno = row.getAttribute("data-giorno").split(" ")[0];
        console.log(giorno);
        let showRow = true;

        if (input && userId !== input) {
            showRow = false;
        }
        if (startDateString && giorno < formattedStartDate) {
            showRow = false;
        }
        if (endDateString && giorno > formattedEndDate) {
            showRow = false;
        }
        
        row.style.display = showRow ? "" : "none";
    }
}


/*** FORMATTAZIONE DATA PER CONFRONTO ***/
function formatDate(dataString) {
	let date = new Date(dataString);
	if (!(date instanceof Date)) 
        return 'Formato data non valido';
    
	let day = String(date.getDate()).padStart(2, '0');
	let month = String(date.getMonth() + 1).padStart(2, '0');
	let year = date.getFullYear();

	return `${year}-${month}-${day}`;
}