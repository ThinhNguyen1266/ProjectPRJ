/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author DucNHCE180015
 */
public class User extends Account {
    private int id;
    private String name;
    private String phoneNumber;
    private Address Address;
    
    public User() {
    }
    
    public User(String email, String name, String phoneNumber, Address address){
        super("", "", 0, email);
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.Address = address;
    }
    public User(int id,String email, String name, String phoneNumber, Address address){
        super("", "", 0, email);
        this.id=id;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.Address = address;
    }

    public User(int id, String name, String phoneNumber, Address Address, String username, String password, int account_id, String emails) {
        super(username, password, account_id, emails);
        this.id = id;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.Address = Address;
    }

    public User(int id, String name, String phoneNumber, Address Address, String username, String password) {
        super(username, password);
        this.id = id;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.Address = Address;
    }

    public User(int id, String name, String phoneNumber, Address Address) {
        this.id = id;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.Address = Address;
    }
    
    
    public Address getAddress() {
        return Address;
    }

    public void setAddress(Address Address) {
        this.Address = Address;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
}

