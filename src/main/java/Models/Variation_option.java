/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author DucNHCE180015
 */
public class Variation_option extends Variation {
    private int varop_id;
    private String value;

    public Variation_option(int varop_id, String value, int var_id, String var_name, Models.Category Category) {
        super(var_id, var_name, Category);
        this.varop_id = varop_id;
        this.value = value;
    }

    public Variation_option(int varop_id, String value) {
        this.varop_id = varop_id;
        this.value = value;
    }

    public Variation_option() {
    }

    public int getVarop_id() {
        return varop_id;
    }

    public void setVarop_id(int varop_id) {
        this.varop_id = varop_id;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
    
    
}
