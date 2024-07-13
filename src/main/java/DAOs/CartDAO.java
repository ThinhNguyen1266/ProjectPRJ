/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Models.Cart;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author AnhNLCE181837
 */
public class CartDAO {
    
     public String getCartID() {
        String id = "169999"; // Default value if no id is found
        try ( Connection conn = DBConnection.getConnection();  Statement st = conn.createStatement();  ResultSet rs = st.executeQuery("SELECT TOP 1 id FROM [cart] ORDER BY id DESC")) {

            if (rs.next()) {
                id = rs.getString("id");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Print the stack trace for debugging
        }
        return id;
    }
     
     public int getCartIDByUserID(String userID) {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps =null;
        ResultSet rs = null;
        int id = 0;
        try {
            String sql = "SELECT * FROM cart WHERE cart.user_id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, userID);
            rs = ps.executeQuery();
            if(rs.next()) id = rs.getInt("id");
        } catch (Exception e) {
            id = 0;
        }
        return id;
    }
    
    public int addNewCart(Cart obj){
        Connection conn = DBConnection.getConnection();
        int count = 0;
        try{
            String sql = "Insert into cart values(?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, obj.getCart_id());
            pst.setInt(2, obj.getUser().getId());
            count = pst.executeUpdate();
        }catch(Exception e){
            count = 0;
        }
        return count;
    }
}
