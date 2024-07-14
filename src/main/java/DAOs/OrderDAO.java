/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author AnhNLCE181837
 */
public class OrderDAO {

    public ResultSet getNumberOfYear() {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        try {
            String sql = "SELECT DISTINCT YEAR(order_date) as year FROM [order]";
            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);
        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public List<Integer> getMonthlyRevenue(int year) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        List<Integer> revenue = new ArrayList<>();
        try {
            for (int i = 1; i <= 12; i++) {
                String sql = "SELECT SUM(total_price) as sumTotalPrice FROM [order] WHERE YEAR(order_date) = ? AND MONTH(order_date) = ? AND [status] = 'shipped'";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setInt(1, year);
                pst.setInt(2, i);
                rs = pst.executeQuery();
                if (rs.next()) {
                    // Handle the case where revenue might be null
                    int monthlyRevenue = rs.getInt("sumTotalPrice") / 1000000;
                    revenue.add(rs.wasNull() ? 0 : monthlyRevenue);
                } else {
                    revenue.add(0); // No rows returned, so revenue is 0 for that month
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources to avoid memory leaks
            try {
                if (rs != null) {
                    rs.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return revenue;
    }

    public JSONObject getChartStatistics(List<Integer> listOfYear) {
        JSONObject json = new JSONObject();
        for (Integer year : listOfYear) {
            List<Integer> monthlyRevenue = getMonthlyRevenue(year);
            json.put(String.valueOf(year), new JSONArray(monthlyRevenue));
        }
        return json;
    }

    public ResultSet getAllOrder() {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs;
        try {
            String sql = "SELECT o.id AS order_id, u.name AS customer, o.total_price as total, o.[status]\n"
                    + " FROM [order] o JOIN [user] u ON o.user_id = u.account_id ";
            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);
        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }
}
