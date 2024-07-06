/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Models.Account;
import Models.Address;
import Models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author AnhNLCE181837
 */
public class CreateAccountDAO {

    public String getAccountID() {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        String id = "";
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("SELECT id FROM account");
            while (rs.next()) {
                id = rs.getString("id");
            }
        } catch (Exception e) {
            id = "";
        }
        return id;
    }

    public String getUserID() {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        String id = "";
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("SELECT id FROM account");
            while (rs.next()) {
                id = rs.getString("id");
            }
        } catch (Exception e) {
            id = "";
        }
        return id;
    }

    public String getAddressID() {
        String id = "99999"; // Default value if no id is found
        try ( Connection conn = DBConnection.getConnection();  Statement st = conn.createStatement();  ResultSet rs = st.executeQuery("SELECT TOP 1 id FROM [address] ORDER BY id DESC")) {

            if (rs.next()) {
                id = rs.getString("id");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Print the stack trace for debugging
        }
        return id;
    }

    public int addNewAccount(Account acc) {
        Connection conn = DBConnection.getConnection();
        int count = 0;
        try {
            String sql = "Insert into account(id, name, password, email) values(?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, acc.getAccount_id());
            pst.setString(2, acc.getUsername());
            pst.setString(3, acc.getPassword());
            pst.setString(4, acc.getEmails());

            count = pst.executeUpdate();
        } catch (Exception e) {
            count = 0;
        }

        return count;
    }

    public int addNewUser(User user) {
        Connection conn = DBConnection.getConnection();
        int count = 0;
        try {
            String sql = "Insert into [user](account_id, name, phone_number) values(?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, user.getAccount_id());
            pst.setString(2, user.getName());
            pst.setString(3, user.getPhoneNumber());
            count = pst.executeUpdate();
        } catch (Exception e) {
            count = 0;
        }

        return count;
    }

    public int addNewUserAddress(Address address, Account acc) {
        Connection conn = DBConnection.getConnection();
        int count = 0;
        try {
            String sql = "Insert into user_address(user_id, address_id, is_default) values(?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, acc.getAccount_id());
            pst.setInt(2, address.getAddressId());
            pst.setInt(3, 1);
            count = pst.executeUpdate();
        } catch (Exception e) {
            count = 0;
        }

        return count;
    }

    public int addNewAddress(Address address) {
        Connection conn = DBConnection.getConnection();
        int count = 0;
        try {
            String sql = "Insert into address(id, province_id, address) values(?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, address.getAddressId());
            pst.setInt(2, address.getProvince().getProvince_id());
            pst.setString(3, address.getAddress());
            count = pst.executeUpdate();
        } catch (Exception e) {
            count = 0;
        }

        return count;
    }
}
