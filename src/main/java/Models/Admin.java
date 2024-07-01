/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author DucNHCE180015
 */
public class Admin extends Account {
    private int admin_id;
    private String admin_name;

    public Admin(int admin_id, String admin_name, String username, String password, int account_id, String emails) {
        super(username, password, account_id, emails);
        this.admin_id = admin_id;
        this.admin_name = admin_name;
    }

    public Admin(int admin_id, String admin_name, String username, String password) {
        super(username, password);
        this.admin_id = admin_id;
        this.admin_name = admin_name;
    }

    public Admin(int admin_id, String admin_name) {
        this.admin_id = admin_id;
        this.admin_name = admin_name;
    }

    public Admin() {
    }

    public int getAdmin_id() {
        return admin_id;
    }

    public void setAdmin_id(int admin_id) {
        this.admin_id = admin_id;
    }

    public String getAdmin_name() {
        return admin_name;
    }

    public void setAdmin_name(String admin_name) {
        this.admin_name = admin_name;
    }
    
    
}
