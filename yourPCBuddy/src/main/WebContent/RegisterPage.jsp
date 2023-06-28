<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registrati</title>
</head>
<body>
	<form action="RegisterServlet" method="POST" onsubmit="return validateRegistration()">
		<label for="username">Username:</label>
		<input type="text" id="username" name="name"><br><br>

	    <label for="password">Password:</label>
		<input type="password" id="password" name="password" required><br><br>
		
		<label for="password2"> Reinserisci Password:</label>
		<input type="password" id="password2" name="password2" required><br><br>
		
		<label for="email">Email</label>
		<input type="text" id="email" name="email"><br><br>
		<input type="submit" value="Registrati">	
		 	
  </form>
  <script>
  var error = "<%= request.getParameter("error") %>";

  if (error === "username_exists") {
      alert("Username già esistente!");
      
  } else if (error === "email_exists") {
      alert("Email già esistente!");
 	}  
  function validateRegistration() {
    
    	var emailInput = document.getElementById("email").value;//validazione email
        if (emailInput.indexOf('@') === -1) {
            alert("Inserisci un indirizzo email valido.");
            return false; // Blocca l'invio del form se la validazione fallisce
        }
        var domain = emailInput.split('@')[1]; // Ottieni il dominio dell'email dopo la '@'

        if (domain.endsWith('.com') || domain.endsWith('.it')) {
            // Consente l'invio del form se la validazione è passata
        } else {
            alert("L'indirizzo email deve terminare con .com o .it");
            return false; // Blocca l'invio del form se la validazione fallisce
        }
        var password1 = document.getElementById("password").value; // Controllo password
        var password2 = document.getElementById("password2").value;

        if (password1 === password2) {
            // Le password sono uguali
            return true; // Consente l'invio del form
        } else {
            // Le password sono diverse
            alert("Le password non corrispondono.");
            return false; // Blocca l'invio del form
        }
    }
</script>
</body>
</html>