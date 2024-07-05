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
    private String pro_img;
    private int pro_quan;
    private Category Category;
    
    public Product(int pro_id, int pro_quan){
        this.pro_id = pro_id;
        this.pro_quan = pro_quan;
    }

    public Product(int pro_id, String pro_name, String pro_des, String pro_img, int pro_quan, Category Category) {
        this.pro_id = pro_id;
        this.pro_name = pro_name;
        this.pro_des = pro_des;
        this.pro_img = pro_img;
        this.pro_quan = pro_quan;
        this.Category = Category;
    }

    public Product() {
    }

    public long getPro_quan() {
        return pro_quan;
    }

    public void setPro_quan(int pro_quan) {
        this.pro_quan = pro_quan;
    }

    public Category getCategory() {
        return Category;
    }

    public void setCategory(Category Category) {
        this.Category = Category;
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

    

    public String getPro_img() {
        return pro_img;
    }

    public void setPro_img(String pro_img) {
        this.pro_img = pro_img;
    }
    
    
}
