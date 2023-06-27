<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registrati</title>
</head>
<body>
	<form action="RegisterServlet" method="POST" onsubmit="return validateEmail()">
		<label for="username">Username:</label>
		<input type="text" id="username" name="name" required><br><br>

	    <label for="password">Password:</label>
		<input type="password" id="password" name="password" required><br><br>
		
		<label for="email">Email</label>
		<input type="email" id="email" name="email" required><br><br>
		<input type="submit" value="Registrati">	
		 	
  </form>
  <script>
    function validateEmail() {
        var emailInput = document.getElementById("email").value;
        if (emailInput.indexOf('@') === -1) {
            alert("Inserisci un indirizzo email valido.");
            return false; // Blocca l'invio del form se la validazione fallisce
        }
        var domain = emailInput.split('@')[1]; // Ottieni il dominio dell'email dopo la '@'

        if (domain.endsWith('.com') || domain.endsWith('.it')) {
            return true; // Consente l'invio del form se la validazione è passata
        } else {
            alert("L'indirizzo email deve terminare con .com o .it");
            return false; // Blocca l'invio del form se la validazione fallisce
        }
    }

</script>
</body>
</html>