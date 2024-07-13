/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Models.Province;
import Models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author AnhNLCE181837
 */
public class ProvinceDAO {

    public ProvinceDAO() {
    }

    public ResultSet getAll() {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM province");
        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public String getProvinceID(String province) {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        String id = "";
        try {
            String sql = "SELECT id FROM province WHERE name = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, province);
            rs = pst.executeQuery();
            if (rs.next()) {
                id = rs.getString("id");
            }
        } catch (Exception e) {
            id = "";
        }
        return id;
    }

    public Province getUserAddress(String name) {

        Province obj;
        Connection conn = DB.DBConnection.getConnection();

        try {
            String sql = "select p.name from [user] us \n"
                    + "join user_address usa on us.account_id=usa.user_id \n"
                    + "join [address] a on usa.address_id=a.id \n"
                    + "join province p on a.province_id=p.id \n"
                    + "WHERE us.name= ? and usa.is_default='1'";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, name);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                obj = new Province();
                obj.setProvince_name(rs.getString("name"));
            } else {
                obj = null;
            }
        } catch (Exception e) {
            obj = null;
        }
        return obj;
    }
}
