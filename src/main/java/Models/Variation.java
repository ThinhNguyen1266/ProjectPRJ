/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author DucNHCE180015
 */
public class Variation {
    private int var_id;
    private String var_name;
    private Category Category;

    public Variation(int var_id, String var_name, Category Category) {
        this.var_id = var_id;
        this.var_name = var_name;
        this.Category = Category;
    }

    public Variation() {
    }

    public int getVar_id() {
        return var_id;
    }

    public void setVar_id(int var_id) {
        this.var_id = var_id;
    }

    public String getVar_name() {
        return var_name;
    }

    public void setVar_name(String var_name) {
        this.var_name = var_name;
    }

    public Category getCategory() {
        return Category;
    }

    public void setCategory(Category Category) {
        this.Category = Category;
    }
    
    
}
