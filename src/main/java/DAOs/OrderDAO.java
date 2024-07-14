/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import Enum.ShippingStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import org.apache.taglibs.standard.lang.jstl.NullLiteral;
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

    public void updateOrderStatus(String orderId, String newStatus) {
        String query = "UPDATE [order] SET status = ? WHERE id = ?";
        Connection conn = DB.DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, newStatus);
            ps.setString(2, orderId);
            int count = ps.executeUpdate();
            int b= count;
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Integer> getMonthlyRevenue(int year) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        List<Integer> revenue = new ArrayList<>();
        try {
            for (int i = 1; i <= 12; i++) {
                String sql = "SELECT SUM(total_price) as sumTotalPrice FROM [order] WHERE YEAR(order_date) = ? AND MONTH(order_date) = ? AND [status] = 'SHIPPED'";
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

    public int getCreateOrderId() {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        int id = 149999;
        try {
            String sql = "SELECT Max(id) as id from [order]";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                id = rs.getInt("id");
            }
        } catch (Exception e) {
            return id + 1;
        }
        return id + 1;
    }

    public int getCreateOrderLineId() {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        int id = 169999;
        try {
            String sql = "SELECT Max(id) as id from [order_line]";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                id = rs.getInt("id");
            }
        } catch (Exception e) {
            return id + 1;
        }
        return id + 1;
    }

    public void order(String userID, String addressID, boolean isBuyNow, JSONArray json) {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        PreparedStatement psu = null;
        PreparedStatement psd = null;
        try {
            conn.setAutoCommit(false);

            //add order
            int orderId = getCreateOrderId();
            String sql = "INSERT INTO [order] (id , user_id , order_date , shipping_address ,[status],total_price ) VALUES ( ? , ? , GETDATE() , ? , ? , 0 )";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setString(2, userID);
            ps.setString(3, addressID);
            ps.setString(4, ShippingStatus.SHIPPING.name());
            ps.executeUpdate();

            long totalPrice = 0;
            //add order line and update proitem and delete cart item
            String insertOrderLineQuery = "INSERT INTO order_line (id,product_item_id,order_id,quantity,price)"
                    + "VALUES\n"
                    + "(?,?,?,?,?)";
            String updateProItemQuery = "update product_item SET quantity = quantity - ? where id = ?";
            String deleteCartItemQuery = "DELETE FROM  cart_item where cart_id = (select id from cart where user_id = ? ) and product_item_id = ?";
            ps = conn.prepareStatement(insertOrderLineQuery);
            psu = conn.prepareStatement(updateProItemQuery);
            psd = conn.prepareStatement(deleteCartItemQuery);
            int orderLineId = getCreateOrderLineId();
            for (int i = 0; i < json.length(); i++) {
                JSONObject jSONObject = json.getJSONObject(i);
                int quantity = jSONObject.getInt("quantity");
                long price = jSONObject.getLong("price");
                int proItemID = jSONObject.getInt("proItemID");
                //ps
                ps.setInt(1, orderLineId++);
                ps.setInt(2, proItemID);
                ps.setInt(3, orderId);
                ps.setInt(4, quantity);
                ps.setLong(5, price);
                totalPrice += quantity * price;
                ps.addBatch();
                //psu
                psu.setInt(1, quantity);
                psu.setInt(2, proItemID);
                psu.addBatch();
                //psd
                if (!isBuyNow) {
                    psd.setString(1, userID);
                    psd.setInt(2, proItemID);
                    psd.addBatch();
                }
            }
            ps.executeBatch();
            psu.executeBatch();
            if (!isBuyNow) {
                psd.executeBatch();
            }
            //update order
            String updateOrderQuery = "update [order] SET total_price = ? WHERE id = ?";
            ps = conn.prepareStatement(updateOrderQuery);
            ps.setLong(1, totalPrice);
            ps.setInt(2, orderId);
            ps.executeUpdate();

            conn.commit();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (psu != null) {
                    psu.close();
                }
                if (psd != null) {
                    psd.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }
}
