/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author AnhNLCE181837
 */
public class VariationDAO {

    public String getVariationID(String name, String catParentID) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        String variationID = "";
        try {
            String sql = "SELECT id FROM variation WHERE name = ? "
                    + " AND category_id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, catParentID);
            rs = pst.executeQuery();
            if (rs.next()) {
                return (rs.getString("id"));
            }
        } catch (Exception e) {
            variationID = "";
        }
        return variationID;
    }

    public String getVariationOpID(String value, String variationID) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        String variationOpID = "";
        try {
            String sql = "SELECT id FROM variation_option WHERE [value] = ? "
                    + "AND variation_id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, value);
            pst.setString(2, variationID);
            rs = pst.executeQuery();
            if (rs.next()) {
                return (rs.getString("id"));
            }
        } catch (Exception e) {
            variationOpID = "";
        }
        return variationOpID;
    }
}
