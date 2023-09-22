package model;


import java.util.*;

public class Cart {
	
	double totalPrice=0;
	private int quantity;

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
	private List<ProductBean> products;
	
	public Cart() {
		products = new ArrayList<ProductBean>();
	}
	
	public void addProduct(ProductBean product) {
        for (ProductBean prod : products) {
            if (prod.getCode() == product.getCode()) {
                // Il prodotto è già nel carrello, quindi incrementa la quantità
                prod.setQuantity(prod.getQuantity() + 1);
                
                return;
            }
        }
        // Se il prodotto non è nel carrello, aggiungilo con quantità 1
       
        product.setQuantity(1);
        products.add(product);
    }
	
	public void deleteProduct(ProductBean product) {
		for(ProductBean prod : products) {
			if(prod.getCode() == product.getCode()) {
				if(prod.getQuantity()<=1)
				products.remove(prod);
				else
					prod.setQuantity(prod.getQuantity() - 1);
				return;
			}
		}
 	}
	public void delAll(ProductBean product) {
		for(ProductBean prod : products) {
			if(prod.getCode() == product.getCode()) {
				
				products.remove(prod);
				
				
				return;
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
	public void addProducts(Collection<ProductBean> product) {
		products.addAll(product);
	}
	
	
}
