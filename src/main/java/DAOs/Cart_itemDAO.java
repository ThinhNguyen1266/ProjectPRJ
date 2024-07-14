/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
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
        String id = "129999"; // Default value if no id is found
        try ( Connection conn = DBConnection.getConnection();  Statement st = conn.createStatement();  ResultSet rs = st.executeQuery("SELECT TOP 1 id FROM [cart_item] ORDER BY id DESC")) {

            if (rs.next()) {
                id = rs.getString("id");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Print the stack trace for debugging
        }
        return id;
    }

    public Cart_item getCartItem(String id) {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        Cart_item obj = null;
        try {
            String sql = "SELECT * FROM cart_item where id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                ProductItemDAO pDAO = new ProductItemDAO();
                obj = new Cart_item();
                obj.setQuantity(Integer.parseInt(rs.getString("quantity")));
                obj.setProduct_item(pDAO.getProductItem(String.valueOf(rs.getString("product_item_id"))));
            }
        } catch (Exception e) {
            obj = null;
        }
        return obj;
    }

    public int addNewCart_Item(Cart_item obj) {
        Connection conn = DBConnection.getConnection();
        int count = 0;
        try {
            String sql = "Insert into cart_item values(?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, obj.getCart_item_id());
            pst.setInt(2, obj.getCart_id());
            pst.setInt(3, obj.getProduct_item().getItem_id());
            pst.setInt(4, obj.getQuantity());
            count = pst.executeUpdate();
        } catch (Exception e) {
            count = 0;
        }
        return count;
    }

    public int deleteNewCart_Item(int id) {
        Connection conn = DBConnection.getConnection();
        int count = 0;
        try {
            String sql = "delete from cart_item where id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);

            count = pst.executeUpdate();
        } catch (Exception e) {
            count = 0;
        }
        return count;
    }


        public boolean deleteCartItem(String cartId, String proItemId) {
             Connection conn = DBConnection.getConnection();
            try {
                String sql = "DELETE FROM cart_item where cart_id = ? AND product_item_id = ?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, cartId);
                pst.setString(2, proItemId);
                int rowsAffected = pst.executeUpdate();
                return rowsAffected > 0;
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
        }
    

    public ResultSet getAllCartProductItem(String userID) {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "    select ci.cart_id as cart_id, ci.id as cart_item_id,pi.id as pro_item_id,  p.name as pro_name, ci.quantity as quantity, pi.price as price , p.[image]\n"
                    + "    from [user] as u \n"
                    + "    join cart as c\n"
                    + "    on u.account_id = c .user_id\n"
                    + "    join cart_item  as ci \n"
                    + "    on ci.cart_id = c.id\n"
                    + "    join product_item as pi \n"
                    + "    on ci.product_item_id = pi.id\n"
                    + "    join product as p \n"
                    + "    on p.id = pi.product_id\n"
                    + "    where u.account_id = ?";

            ps = conn.prepareStatement(sql);
            ps.setString(1, userID);
            rs = ps.executeQuery();
            return rs;
        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public void addQuantity(String cartItemID, int quan) {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = null;
        try {
            String sql = "update cart_item set quantity = quantity +  ? where id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, quan);
            ps.setString(2, cartItemID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateQuantity(String cartItemID, String newQuan) {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = null;
        try {
            String sql = "update cart_item set quantity = ? where id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, newQuan);
            ps.setString(2, cartItemID);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public String contain(int cartID, String proItemID) {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT id FROM cart_item where cart_id =? and product_item_id=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, cartID);
            ps.setString(2, proItemID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("id");
            }
        } catch (Exception e) {
            return null;
        }
        return null;
    }

}
