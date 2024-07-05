/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Models.Cart;
import Models.Product;
import Models.Product_item;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author AnhNLCE181837
 */
public class ProductItemDAO {

    public String getProduct_itemID() {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        String id = "";
        try {
            Statement st = conn.createStatement();

            rs = st.executeQuery("SELECT id FROM product_item");
            if (rs.next() == false) {
                id = "150000";
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

    public Product_item getProductItem(String id) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        Product_item obj = null;
        try {
            String sql = "Select * FROM product_item where id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                obj = new Product_item(rs.getInt("id"), rs.getInt("product_id"));
            } else {
                obj = null;
            }
        } catch (Exception e) {
            obj = null;
        }
        return obj;
    }

    public int addNewProductItem(Product_item obj) {
        Connection conn = null;
        PreparedStatement pst = null;
        int count = 0;

        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO product_item (id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            pst = conn.prepareStatement(sql);
            pst.setInt(1, obj.getItem_id());
            pst.setInt(2, obj.getPro_id());
            pst.setInt(3, obj.getItem_quan()); // Assuming 'quantity' is a field in Product_item
            pst.setDouble(4, obj.getPrice()); // Assuming 'price' is a field in Product_item

            count = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            count = 0;
        } finally {
            try {
                if (pst != null) {
                    pst.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return count;
    }

}
