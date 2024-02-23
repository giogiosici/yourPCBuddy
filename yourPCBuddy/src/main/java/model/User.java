package model;

public class User {
	private int id;
    private String nome;
    private String cognome;
    private String username;
    private String password;
	private String email;
	private String indirizzo;


    // Costruttore vuoto
    public User() {
    }
    
    
    
    

    

	public User(String nome, String cognome, String username, String password, String email, String indirizzo) {
		super();
		this.nome = nome;
		this.cognome = cognome;
		this.username = username;
		this.password = password;
		this.email = email;
		this.indirizzo = indirizzo;
	}


	// Metodi getter e setter per ciascun campo
    
    public User(String nome, String cognome, String username, String password, String email) {
		super();
		this.nome = nome;
		this.cognome = cognome;
		this.username = username;
		this.password = password;
		this.email = email;
	}



	public int getId() {
    	return id;
    }
    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getEmail() {
        return email;
    }

    public void setEmail(String Email) {
        this.email = Email;
    }

   

    public String getIndirizzo() {
		return indirizzo;
	}
    
	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}
	

	public void setId(int id) {
		this.id = id;
	}

	public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    	
}


