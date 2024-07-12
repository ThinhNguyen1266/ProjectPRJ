/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author AnhNLCE181837
 */
public class Product_configurationDAO {
    public int Addnew(String productItemID, String variationOpID){
        Connection conn = DB.DBConnection.getConnection();
        int count = 0;
        try{
            String sql = "INSERT INTO product_configuration VALUES(?, ?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, productItemID);
            pst.setString(2, variationOpID);
            count = pst.executeUpdate();
        }catch(Exception e){
            count= 0;
        }
        return count;
    }
    
    public int delete(String productItemID){
        Connection conn = DB.DBConnection.getConnection();
        int count = 0;
        try{
            String sql = "DELETE FROM product_configuration WHERE products_item_id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, productItemID);
            count = pst.executeUpdate();
        }catch(Exception e){
            count= 0;
        }
        return count;
    }
}
