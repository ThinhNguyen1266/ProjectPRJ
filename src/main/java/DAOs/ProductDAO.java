/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import java.sql.Connection;
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
}
