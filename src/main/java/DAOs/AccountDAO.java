/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Models.Account;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

/**
 *
 * @author AnhNLCE181837
 */
public class AccountDAO {

    public boolean login(Account acc) {
        Connection conn = DB.DBConnection.getConnection();
        try {
            String hashedPassword = getMD5Hash(acc.getPassword());
            String sql = "SELECT * FROM account WHERE name = ? AND password = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, acc.getUsername());
            pst.setString(2, hashedPassword);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            return false;
        }
        return false;
    }
    
    public String getAccountID (Account acc){
        Connection conn = DB.DBConnection.getConnection();
        String id = null;
        try {
            String hashedPassword = getMD5Hash(acc.getPassword());
            String sql = "SELECT * FROM account WHERE name = ? AND password = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, acc.getUsername());
            pst.setString(2, hashedPassword);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                id = rs.getString("id");
            }
        } catch (Exception e) {
           id = null;
        }
        return id;
    }
    
    public boolean loginAdmin(Account acc) {
        Connection conn = DB.DBConnection.getConnection();
        try {
            String hashedPassword = getMD5Hash(acc.getPassword());
            String sql = "SELECT * FROM account WHERE name = ? AND password = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, acc.getUsername());
            pst.setString(2, hashedPassword);
            System.out.println(hashedPassword);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {

                if (acc.getPassword().equals("admin")) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public String getMD5Hash(String input) {
        try {
            // Get the instance of the MD5 MessageDigest
            MessageDigest md = MessageDigest.getInstance("MD5");

            // Digest the input bytes and get the hash's bytes
            byte[] messageDigest = md.digest(input.getBytes(StandardCharsets.UTF_8));

            // Convert the byte array into a signum representation
            BigInteger no = new BigInteger(1, messageDigest);

            // Convert the hash into a hexadecimal format
            String hashtext = no.toString(16);

            // Add preceding 0s to make it 32 bit
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }

            return hashtext;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
