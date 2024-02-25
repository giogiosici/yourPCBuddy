package model;

public class User {
	private int id;
    private String nome;
    private String cognome;
    private String username;
    private String password;
	private String email;
	private String stato;
	private String citta;
	private String provincia;
	private String via;
	private String numeroCivico;
	private String cap;

    // Costruttore vuoto
    public User() {
    }
    
    
    
    

    

	public User(String nome, String cognome, String username, String password, String email, String stato, String citta,
			String provincia, String via, String numeroCivico, String cap) {
		super();
		this.nome = nome;
		this.cognome = cognome;
		this.username = username;
		this.password = password;
		this.email = email;
		this.stato = stato;
		this.citta = citta;
		this.provincia = provincia;
		this.via = via;
		this.numeroCivico = numeroCivico;
		this.cap = cap;
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

   

    public String getStato() {
		return stato;
	}
    
	public void setStato(String stato) {
		this.stato = stato;
	}
	
	public String getCitta() {
		return citta;
	}
	
	public void setCitta(String citta) {
		this.citta = citta;
	}
	
	public String getProvincia() {
		return provincia;
	}

	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}

	public String getVia() {
		return via;
	}

	public void setVia(String via) {
		this.via = via;
	}

	public String getNumeroCivico() {
		return numeroCivico;
	}

	public void setNumeroCivico(String numeroCivico) {
		this.numeroCivico = numeroCivico;
	}

	public String getCap() {
		return cap;
	}

	public void setCap(String cap) {
		this.cap = cap;
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
    
    public void setIndirizzo(String stato, String citta,
			String provincia, String via, String numeroCivico, String cap) {
    	this.stato=stato;
    	this.citta=citta;
    	this.provincia = provincia;
    	this.via=via;
    	this.numeroCivico = numeroCivico;
    	this.cap = cap;
    }







	@Override
	public String toString() {
		return "User [id=" + id + ", nome=" + nome + ", cognome=" + cognome + ", username=" + username + ", password="
				+ password + ", email=" + email + ", stato=" + stato + ", citta=" + citta + ", provincia=" + provincia
				+ ", via=" + via + ", numeroCivico=" + numeroCivico + ", cap=" + cap + "]";
	}
    
    
    	
}


