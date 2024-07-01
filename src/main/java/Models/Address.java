/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author DucNHCE180015
 */
public class Address {
    private int addressId;
    private String address;
    private Province Province;

    // No-argument constructor
    public Address() {
    }

    public Address(int addressId, int provinceId, String address, Province Province) {
        this.addressId = addressId;
        
        this.address = address;
        this.Province = Province;
    }

    public Province getProvince() {
        return Province;
    }

    public void setProvince(Province Province) {
        this.Province = Province;
    }

    

    // Getters and Setters
    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}

