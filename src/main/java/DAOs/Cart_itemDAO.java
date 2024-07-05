/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Models.Cart;
import Models.Cart_item;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author AnhNLCE181837
 */
public class Cart_itemDAO {
    public String getCart_itemID() {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        String id = "";
        try {
            Statement st = conn.createStatement();

            rs = st.executeQuery("SELECT id FROM cart_item");
            if (rs.next() == false) {
                id = "130000";
            } else {
                while (rs.next()) {
                    id = rs.getString("id");
                }
            }
        } catch (Exception e) {
            id = "";
        }
        return id;
    }
    
    public Cart_item getCartItem(String id){
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        Cart_item obj = null;
        try {
            String sql = "SELECT * FROM cart_item where id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, id);
            rs = pst.executeQuery();
            if(rs.next()){
                ProductItemDAO pDAO = new ProductItemDAO();
                obj = new Cart_item();
                obj.setQuantity(Integer.parseInt(rs.getString("quantity")));
                obj.setProduct_item(pDAO.getProductItem(String.valueOf(rs.getString("product_item_id"))));
            }
        }catch(Exception e){
            obj = null;
        }
        return obj;
    }
    
    public int addNewCart_Item(Cart_item obj){
        Connection conn = DBConnection.getConnection();
        int count = 0;
        try{
            String sql = "Insert into cart_item values(?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, obj.getCart_item_id());
            pst.setInt(2, obj.getCart_id());
            pst.setInt(3, obj.getProduct_item().getItem_id());
            pst.setInt(4, obj.getQuantity());
            count = pst.executeUpdate();
        }catch(Exception e){
            count = 0;
        }
        return count;
    }
}
