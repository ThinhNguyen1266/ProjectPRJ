/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Account;
import Models.Address;
import Models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author AnhNLCE181837
 */
public class UserDAO {

    public User getUser(String name) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        User obj = null;
        Address addressDraw = null;

        try {
            conn = DB.DBConnection.getConnection();
            String sql = "SELECT u.name AS user_name, u.phone_number AS phone_number, acc.email AS email, a.address AS address\n"
                    + "	FROM account acc \n"
                    + "    JOIN [user] u ON acc.id = u.account_id\n"
                    + "                    JOIN user_address ua ON u.account_id = ua.user_id\n"
                    + "                    JOIN [address] a ON ua.address_id = a.id \n"
                    + "                    WHERE acc.name = ?";
            pst = conn.prepareStatement(sql);
            pst.setString(1, name);
            rs = pst.executeQuery();

            if (rs.next()) {
                addressDraw = new Address();
                addressDraw.setAddress(rs.getString("address"));
                obj = new User(rs.getString("email"), rs.getString("user_name"), rs.getString("phone_number"), addressDraw);

            }
        } catch (Exception e) {
            // Log the exception
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) {
                    rs.close();
                }
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
        return obj;
    }

    public String getUserID(String name){
        Connection conn = null;
        ResultSet rs = null;
        String id = "";
        try{
            conn = DB.DBConnection.getConnection();
            String sql = "Select id from account where name = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, name);
            rs = pst.executeQuery();
            if(rs.next()){
                id = rs.getString("id");
            }
                    
        }catch(Exception e){
            id = "";
        }
        return id;
    }
    public ResultSet getAll() {
        ResultSet rs;
        try {
            String sql = "SELECT u.account_id, u.name, u.phone_number , a.email\n"
                    + "FROM account AS a\n"
                    + "JOIN [user] AS u \n"
                    + "ON a.id = u.account_id";
            Connection conn = DB.DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
             rs = ps.executeQuery();
            return rs;
        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

}
