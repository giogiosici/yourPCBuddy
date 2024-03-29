<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="it">
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="./Scripts/RegisterScripts.js"></script>
<link href="Styles/LoginScreen.css" rel="stylesheet" type="text/css">

<meta charset="ISO-8859-1">
<title>Registrati</title>
<jsp:include page="Header.jsp" flush="true"/>

</head>
<body>
<main>
	<div id="Registrazione">
	<form action="RegisterServlet" method="POST" onsubmit="return validateRegistration()">
		<label for="nome">Nome:</label>
		<input type="text" id="nome" name="nome"><br><br>
		
		<label for="cognome">Cognome:</label>
		<input type="text" id="cognome" name="cognome"><br><br>
		
		<label for="username">Username:</label>
		<input type="text" id="username" name="username"><br><br>

	    <label for="password">Password:</label>
		<input type="password" id="password" name="password" required><br><br>
		
		<label for="password2"> Reinserisci Password:</label>
		<input type="password" id="password2" name="password2" required><br><br>
		
		<label for="email">Email</label>
		<input type="text" id="email" name="email"><br><br>
		<input type="submit" value="Registrati">	
		 	
  </form>
  </div>
  </main>
  <script>
  var error = "<%= request.getParameter("error") %>";

  if (error === "username_exists") {
	    Swal.fire({
	        title: 'Errore',
	        text: 'Username gi� esistente!',
	        icon: 'error',
	        confirmButtonText: 'OK'
	    });
	    
	} else if (error === "email_exists") {
	    Swal.fire({
	        title: 'Errore',
	        text: 'Email gi� esistente!',
	        icon: 'error',
	        confirmButtonText: 'OK'
	    });
	} else if (error === "registration") {
		console.log(error);
	    Swal.fire({
	        title: 'Registrazione effettuata con successo',
	        text: 'Verrai reindirizzato alla pagina di Login',
	        icon: 'success',
	        confirmButtonText: 'OK'
	    }).then((result) => {
	        if (result.isConfirmed) {
	            // Reindirizza l'utente alla pagina di login
	            window.location.href = 'LoginScreen.jsp';
	        }
	    });
	}
</script>
<jsp:include page="Footer.jsp" flush="true"></jsp:include>

</body>
</html>