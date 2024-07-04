/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
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
    
    
    public ResultSet getAll(){
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs=null;
        try{
            Statement st = conn.createStatement();
            rs = st.executeQuery("SELECT * from product");
            if(rs.next()){
                return rs;
            }else
                rs=null;
            
        }catch(Exception e){
            rs = null;
        }
        return rs;
    }
    
    public Product getProduct(String id) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs=null;
        Product obj = null;
        try{
            String sql = "Select * FROM product where id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, id);
            rs = pst.executeQuery();
            if(rs.next()){
                obj = new Product();
                obj.setPro_name(rs.getString("name"));
            }else 
                obj = null;
        }catch(Exception e){
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
}
