/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author DucNHCE180015
 */
public class CategoryDAO {

    public Category getCategory(String id) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        Category cat = null;
        if (conn != null) {
            try {
                String sql = "SELECT * FROM Category WHERE id = ?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, id);
                rs = pst.executeQuery();
                if (rs.next()) {
                    cat = new Category(Integer.parseInt(rs.getString("id")), Integer.parseInt(rs.getString("parent")), rs.getString("name"));
                } else {
                    cat = null;
                }
            } catch (Exception e) {
                cat = null;
            }

        }
        return cat;
    }

    public ResultSet getAllCategoriesNull() {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                rs = st.executeQuery("SELECT * FROM category WHERE parent IS NULL");
            } catch (Exception e) {
                rs = null;
            }

        }
        return rs;
    }

    public ResultSet getAllSubCat(String id) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        if (conn != null) {
            try {
                String sql = "SELECT * FROM category WHERE parent = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, id);
                rs = ps.executeQuery();
            } catch (Exception e) {
                rs = null;
            }
        }
        return rs;
    }

    public ResultSet getAllProductCat(String name) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        if (conn != null) {
            try {
                String query = "SELECT p.id, p.name, p.[description], p.category_id, c.name AS category_name, (SELECT name FROM category WHERE id = c.parent) AS parent_category, p.quantity, p.[image] FROM product AS p JOIN category AS c ON p.category_id = c.id WHERE (SELECT name FROM category WHERE id = c.parent) = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, name);
                rs = ps.executeQuery();
            } catch (Exception e) {
                e.printStackTrace();
                rs = null;
            }
        }
        return rs;
    }
    
    public String getCatParentID(String catID){
        Connection conn = DB.DBConnection.getConnection();
        String catParentID = "";
        try{
            String sql = " SELECT * FROM category WHERE id = ? ";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, catID);
            ResultSet rs = pst.executeQuery();
            catParentID = rs.getString("parent");
        }catch(Exception e){
            catParentID = "";
        }
        return catParentID;
    }

    public Category getCatName(int id) {
        Connection conn = DB.DBConnection.getConnection();
        Category obj;
        try {
            String sql = "select * from category where id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                obj = new Category();
                obj.setCat_name(rs.getString("name"));
                if(rs.getString("parent")!=null)
                    obj.setParent(Integer.parseInt(rs.getString("parent")));
                else
                    obj.setParent(Integer.parseInt(rs.getString("id")));
            } else {
                obj = null;
            }
        } catch (Exception e) {
            obj = null;
        }
        return obj;
    }

    public Category getCategorByProID(int id) {
        Connection conn = DB.DBConnection.getConnection();
        Category obj;
        try {
            String sql = "select id,[name], parent from category where id=(select c.parent from product p join category c on p.category_id=c.id where p.id=?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                obj = new Category();
                obj.setCat_name(rs.getString("name"));
                obj.setCat_id(rs.getInt("id"));
                obj.setParent(rs.getInt("parent"));
            } else {
                obj = null;
            }
        } catch (Exception e) {
            obj = null;
        }
        return obj;
    }

}
