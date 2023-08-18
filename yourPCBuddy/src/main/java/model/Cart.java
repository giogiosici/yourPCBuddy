package model;


import java.util.*;

public class Cart {
	
	double totalPrice=0;
	
	private List<ProductBean> products;
	
	public Cart() {
		products = new ArrayList<ProductBean>();
	}
	
	public void addProduct(ProductBean product) {
		products.add(product);
	}
	
	public void deleteProduct(ProductBean product) {
		for(ProductBean prod : products) {
			if(prod.getCode() == product.getCode()) {
				products.remove(prod);
				break;
			}
		}
 	}
	
	public List<ProductBean> getProducts() {
		return  products;
	}
	public boolean isEmpty() {
	    return products.isEmpty();
	}
	public boolean isInCart(ProductBean product) {
		for(ProductBean prod : products) {
			if(prod.getCode() == product.getCode())
				return true;
		}
		return false;
	}

	
	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}
	
	public double getTotalPrice() {
		return totalPrice;
	}
}
