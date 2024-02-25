package model;

import java.io.Serializable;

public class ProductBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	int code;
	String name;
	String description;
	String image;
	double price;
	int quantity;
	int cartQuantity;
	String categoria;
	String brand;
	

	public ProductBean() {
		code = -1;
		name = "";
		image="";
		description = "";
		quantity = 0;
		brand = "";
		categoria="";
		price=(double) 0.00;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	
	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public String getCategoria() {
		return categoria;
	}

	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	
	public String getImage() {
		return image;
	}
	
	public void setImage(String image) {
		this.image=image;
	}

	
	@Override
	public String toString() {
		return name + " (" + code + "), " + price + " " + quantity + ". " + description+ " " + brand + " " + categoria + " " + image;
	}
	

	public void setNotEmpty(String name, String description, double price, int quantity, String categoria,
			String brand) {
		
		if(!name.equals(""))
		this.name = name;
		if(!description.equals(""))
		this.description = description;
		if(price > 0.0)
		this.price = price;
		if(quantity>=0)
		this.quantity = quantity;
		if(!categoria.equals(""))
		this.categoria = categoria;
		if(!brand.equals(""))
		this.brand = brand;
	}

}
