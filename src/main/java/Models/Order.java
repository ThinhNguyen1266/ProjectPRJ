/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Date;



/**
 *
 * @author DucNHCE180015
 */
public class Order {
    private int order_id;
    private User user;
    private Date order_date;
    private Address shipping_address;
    private long total_price;
    private String status;
    private int warranty;

    public Order(int order_id, User user, Date order_date, Address shipping_address, long total_price, String status, int warranty) {
        this.order_id = order_id;
        this.user = user;
        this.order_date = order_date;
        this.shipping_address = shipping_address;
        this.total_price = total_price;
        this.status = status;
        this.warranty = warranty;
    }

    public Order() {
    }
    

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getOrder_date() {
        return order_date;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }

    public Address getShipping_address() {
        return shipping_address;
    }

    public void setShipping_address(Address shipping_address) {
        this.shipping_address = shipping_address;
    }

    public long getTotal_price() {
        return total_price;
    }

    public void setTotal_price(long total_price) {
        this.total_price = total_price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getWarranty() {
        return warranty;
    }

    public void setWarranty(int warranty) {
        this.warranty = warranty;
    }
    
    
}
