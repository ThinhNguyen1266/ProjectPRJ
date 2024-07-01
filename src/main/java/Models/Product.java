/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author DucNHCE180015
 */
public class Product {
    private int pro_id;
    private String pro_name;
    private String pro_des;
    private int cat_id;
    private String pro_img;

    public Product() {
    }

    public Product(int pro_id, String pro_name, String pro_des, int cat_id, String pro_img) {
        this.pro_id = pro_id;
        this.pro_name = pro_name;
        this.pro_des = pro_des;
        this.cat_id = cat_id;
        this.pro_img = pro_img;
    }

    public int getPro_id() {
        return pro_id;
    }

    public void setPro_id(int pro_id) {
        this.pro_id = pro_id;
    }

    public String getPro_name() {
        return pro_name;
    }

    public void setPro_name(String pro_name) {
        this.pro_name = pro_name;
    }

    public String getPro_des() {
        return pro_des;
    }

    public void setPro_des(String pro_des) {
        this.pro_des = pro_des;
    }

    public int getCat_id() {
        return cat_id;
    }

    public void setCat_id(int cat_id) {
        this.cat_id = cat_id;
    }

    public String getPro_img() {
        return pro_img;
    }

    public void setPro_img(String pro_img) {
        this.pro_img = pro_img;
    }
    
    
}
