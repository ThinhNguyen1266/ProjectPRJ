/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author DucNHCE180015
 */
public class CategoryDAO {
     public ResultSet getAllCategoriesNull(){
       Connection conn = DB.DBConnection.getConnection();
        ResultSet rs=null;
        if(conn !=null){
            try {
                Statement st= conn.createStatement();
                rs=st.executeQuery("SELECT * FROM category WHERE parent IS NULL");
            } catch (Exception e) {
                rs=null;
            }
            
        }
        return rs;
    }
}
