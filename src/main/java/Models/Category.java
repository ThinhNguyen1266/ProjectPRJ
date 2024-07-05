/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author DucNHCE180015
 */
public class Category {
    private int cat_id;
    private int parent;
    private String cat_name;

    public Category() {
    }

    public Category(int cat_id, int parent, String cat_name) {
        this.cat_id = cat_id;
        this.parent = parent;
        this.cat_name = cat_name;
    }

    public Category(int cat_id) {
        this.cat_id = cat_id;
    }
    
    public int getCat_id() {
        return cat_id;
    }

    public void setCat_id(int cat_id) {
        this.cat_id = cat_id;
    }

    public int getParent() {
        return parent;
    }

    public void setParent(int parent) {
        this.parent = parent;
    }

    public String getCat_name() {
        return cat_name;
    }

    public void setCat_name(String cat_name) {
        this.cat_name = cat_name;
    }
    
    
}
