/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author DucNHCE180015
 */
public class Cart_item extends Cart {
    private int cart_item_id;
    private int cart_item_quan;
    private Product_item Product_item;

    public Cart_item(int cart_item_id, int cart_item_quan, Product_item Product_item, int cart_id, User user) {
        super(cart_id, user);
        this.cart_item_id = cart_item_id;
        this.cart_item_quan = cart_item_quan;
        this.Product_item = Product_item;
    }

    public Cart_item(int cart_item_id, int cart_item_quan, Product_item Product_item) {
        this.cart_item_id = cart_item_id;
        this.cart_item_quan = cart_item_quan;
        this.Product_item = Product_item;
    }

    public Cart_item() {
    }

    public int getCart_item_id() {
        return cart_item_id;
    }

    public void setCart_item_id(int cart_item_id) {
        this.cart_item_id = cart_item_id;
    }

    public int getCart_item_quan() {
        return cart_item_quan;
    }

    public void setCart_item_quan(int cart_item_quan) {
        this.cart_item_quan = cart_item_quan;
    }

    public Product_item getProduct_item() {
        return Product_item;
    }

    public void setProduct_item(Product_item Product_item) {
        this.Product_item = Product_item;
    }
    
    
}
