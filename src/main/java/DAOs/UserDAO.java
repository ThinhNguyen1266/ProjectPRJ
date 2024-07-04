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
        Account acc = null;

        try {
            conn = DB.DBConnection.getConnection();
            String sql = "select * from account where name = ?";
            pst = conn.prepareStatement(sql);
            pst.setString(1, name);
            rs = pst.executeQuery();

            if (rs.next()) {
                acc = new Account();
                acc.setEmails(rs.getString("email"));
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

}
