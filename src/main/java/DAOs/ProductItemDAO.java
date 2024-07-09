/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
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
        String id = "149999"; // Default value if no id is found
        try ( Connection conn = DBConnection.getConnection();  Statement st = conn.createStatement();  ResultSet rs = st.executeQuery("SELECT TOP 1 id FROM [product_item] ORDER BY id DESC")) {

            if (rs.next()) {
                id = rs.getString("id");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Print the stack trace for debugging
        }
        return id;
    }

    public Product_item getProductItem(String id) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        Product_item obj = null;
        try {
            String sql = "SELECT pi.id as proItem_id, p.id as pro_id, p.name as pro_name, pi.price as price, p.[image] as image\n"
                    + "FROM product as p\n"
                    + "JOIN product_item as pi\n"
                    + "on p.id = pi.product_id where pi.id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                obj = new Product_item(rs.getInt("proItem_id"), rs.getInt("pro_id"), rs.getInt("price"), rs.getString("image"), rs.getString("pro_name"));
            } else {
                obj = null;
            }
        } catch (Exception e) {
            obj = null;
        }
        return obj;
    }

    public ResultSet getAllAdmin() {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT \n"
                    + "DISTINCT p.id as pro_id, p.name as pro_name,p.[description],pi.quantity, pi.price , p.[image], (select name from category where id = c.parent)+' '+c.name as cat_name\n"
                    + "FROM product as p\n"
                    + "JOIN product_item as pi\n"
                    + "on p.id = pi.product_id\n"
                    + "JOIN category as c\n"
                    + "on p.category_id = c.id";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            return rs;
        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public ResultSet getAllInMenu() {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT pi.id as proItem_id, p.id as pro_id, p.name as pro_name, pi.price, p.[image]\n"
                    + "FROM product as p\n"
                    + "JOIN product_item as pi\n"
                    + "on p.id = pi.product_id";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            return rs;

        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public ResultSet getAllByName(String name) {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT DISTINCT p.id as pro_id, p.name as pro_name, pi.price , p.[image]\n"
                    + "FROM product as p\n"
                    + "JOIN product_item as pi\n"
                    + "on p.id = pi.product_id\n"
                    + "where p.name like ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            rs = ps.executeQuery();

            return rs;

        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public ResultSet getAllByCatParent(String cat_id) {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT DISTINCT p.id as pro_id, p.name as pro_name, pi.price , p.[image]\n"
                    + "FROM product as p\n"
                    + "JOIN product_item as pi\n"
                    + "on p.id = pi.product_id\n"
                    + "JOIN category as c\n"
                    + "on p.category_id = c.id\n"
                    + "where c.parent = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, cat_id);
            rs = ps.executeQuery();

            return rs;

        } catch (Exception e) {
            rs = null;
        }
        return rs;
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
