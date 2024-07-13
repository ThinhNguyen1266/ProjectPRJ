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

    public ResultSet getVariationIDByCatParentName(String catParentID) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        String top = (catParentID.equals("300000"))? "2" : "3";
        try {
            String sql;
            if(top.equals("2"))
             sql = "SELECT Distinct top 2 va.id, va.name FROM variation va JOIN variation_option vo ON va.id = vo.variation_id\n"
                    + "WHERE va.category_id = ? group BY va.id, va.name";
            else
                sql = "SELECT Distinct top 3 va.id, va.name FROM variation va JOIN variation_option vo ON va.id = vo.variation_id\n"
                    + "WHERE va.category_id = ? group BY va.id, va.name";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, catParentID);
            rs = pst.executeQuery();
            return rs;
        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

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
