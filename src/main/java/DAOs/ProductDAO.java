/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Models.Category;
import Models.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author AnhNLCE181837
 */
public class ProductDAO {

    public ProductDAO() {
    }

    public ResultSet getAll() {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("SELECT * from product");
        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public ResultSet getAllProductAdmin() {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        try {
            String sql = "SELECT  p.id , p.name, p.[description], p.[image], p.quantity,c.name  \n"
                    + "FROM [product] as p JOIN [category] as c\n"
                    + "ON p.category_id = c.id\n"
                    + "ORDER BY p.id ASC";
            PreparedStatement ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public Product getProduct(String id) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        Product obj = null;
        try {
            String sql = "Select * FROM product where id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                obj = new Product();
                obj.setPro_id(Integer.parseInt(rs.getString("id")));
                obj.setPro_name(rs.getString("name"));
                obj.setPro_img(rs.getString("image"));
                obj.setPro_des(rs.getString("description"));
                obj.setPro_quan(Integer.parseInt(rs.getString("quantity")));
                Category cat = new Category();
                CategoryDAO cDAO = new CategoryDAO();
                cat = cDAO.getCategory(rs.getString("category_id"));
                obj.setCategory(cat);
            } else {
                obj = null;
            }
        } catch (Exception e) {
            obj = null;
        }
        return obj;
    }
    
    

    public ResultSet getAllProductByName(String name) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        if (conn != null) {
            try {
                String query = "SELECT * FROM product WHERE name LIKE ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, "%" + name + "%");
                rs = ps.executeQuery();
            } catch (Exception e) {
                e.printStackTrace();
                rs = null;
            }
        }
        return rs;
    }

    public Product getProductByID(String id) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        Product product = null;
        try {
            String sql = "SELECT * FROM Product WHERE ID = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, id);
            rs = pst.executeQuery();
        } catch (Exception e) {
            product = null;
        }
        return product;
    }
    public String getProductName(String id) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        
        try {
            String sql = "SELECT * FROM Product WHERE ID = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, id);
            rs = pst.executeQuery();
            if(rs.next()){
                return rs.getString("name");
            }
        } catch (Exception e) {
             return null;
        }
        return null;
    }

    public void add(Product product) {
        try {
            String sql = "INSERT INTO product (id,name,[description],quantity,[image],category_id)\n"
                    + "VALUES\n"
                    + "(? , ? , ? , ? , ?, ?)";
            Connection conn = DB.DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, product.getPro_id());
            ps.setString(2, product.getPro_name());
            ps.setString(3, product.getPro_des());
            ps.setLong(4, product.getPro_quan());
            ps.setString(5, product.getPro_img());
            ps.setInt(6, product.getCategory().getCat_id());
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public int getMaxID(int category_id) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        if (conn != null) {
            try {
                String query = "select MAX(p.id) as id\n"
                        + "from product AS p join category AS c \n"
                        + "on p.category_id = c.id\n"
                        + "where  parent = (SELECT parent from category where id = ?)";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setInt(1, category_id);
                rs = ps.executeQuery();
                if(rs.next()) return rs.getInt("id");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0;
    }
    
    public int editProduct(Product obj) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        int count = 0;
        try{
            String sql = "UPDATE Product SET name = ?, description = ?, category_id = ? where id = ? ";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, obj.getPro_name());
            pst.setString(2, obj.getPro_des());
            pst.setInt(3, obj.getCategory().getCat_id());
            pst.setInt(4, obj.getPro_id());
            count = pst.executeUpdate();
        }catch(Exception e){
            count = 0;
        }
        return count;
    }
    
    public ResultSet getProItemIDByProID(String proID){
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        try{
            String sql = "SELECT pi.id AS proItemID FROM product p JOIN product_item pi ON p.id = pi.product_id WHERE p.id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, proID);
            rs = pst.executeQuery();
        }catch(Exception e){
            rs= null;
        }
        return rs;
    }
   
    public int deleteProduct(String proID){
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        int count = 0;
        
        try {
            String sql = "DELETE FROM product WHERE id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, proID);
            count = pst.executeUpdate();
        } catch (Exception e) {
            count = 0;
        }
        return count;
    }
}
