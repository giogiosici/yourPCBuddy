package model;

import java.io.Serializable;

public class ProductBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	int code;
	String name;
	String description;
	String image;
	float price;
	int quantity;
	int cartQuantity;
	int CategoriaID;
	String brand;
	

	public ProductBean() {
		code = -1;
		name = "";
		image="";
		description = "";
		quantity = 0;
		brand = "";
		CategoriaID=0;
		price=(float) 0.00;
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

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public int getCategoriaID() {
		return CategoriaID;
	}

	public void setCategoriaID(int CategoriaID) {
		this.CategoriaID = CategoriaID;
	}
	
	public String getImage() {
		return image;
	}
	
	public void setImage(String image) {
		this.image=image;
	}

	
	@Override
	public String toString() {
		return name + " (" + code + "), " + price + " " + quantity + ". " + description+ " " + brand + " " + CategoriaID + " " + image;
	}

}
