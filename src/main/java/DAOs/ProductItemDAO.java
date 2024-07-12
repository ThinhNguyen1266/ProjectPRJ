/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Models.Product_item;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author AnhNLCE181837
 */
public class ProductItemDAO {

    public String getProduct_itemID() {
        String id = "149999"; // Default value if no id is found
        try ( Connection conn = DBConnection.getConnection();  Statement st = conn.createStatement();  ResultSet rs = st.executeQuery("SELECT TOP 1 id FROM [product_item] ORDER BY id DESC")) {

            if (rs.next()) {
                id = rs.getString("id");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Print the stack trace for debugging
        }
        return id;
    }

    public Product_item getProductItem(String id) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        Product_item obj = null;
        try {
            String sql = "SELECT pi.id as proItem_id, p.id as pro_id, p.name as pro_name, pi.price as price, p.[image] as image\n"
                    + "FROM product as p\n"
                    + "JOIN product_item as pi\n"
                    + "on p.id = pi.product_id where pi.id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                obj = new Product_item(rs.getInt("proItem_id"), rs.getInt("pro_id"), rs.getInt("price"), rs.getString("image"), rs.getString("pro_name"));
            } else {
                obj = null;
            }
        } catch (Exception e) {
            obj = null;
        }
        return obj;
    }

    public ResultSet getAllAdmin() {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT\n"
                    + "    p.id as pro_id, p.name as pro_name, p.[description], SUM(pi.quantity) as quantity, MIN(pi.price) as price , p.[image],\n"
                    + "    COALESCE(pc.name + ' ', '')+c.name as cat_name\n"
                    + "FROM product as p\n"
                    + "    JOIN product_item as pi\n"
                    + "    on p.id = pi.product_id\n"
                    + "    JOIN category as c\n"
                    + "    on p.category_id = c.id\n"
                    + "    JOIN category as pc\n"
                    + "    ON c.parent = pc.id\n"
                    + "GROUP BY p.id, p.name, p.[description], p.quantity, p.[image], pc.name,c.name";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            return rs;
        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public ResultSet getAllInMenu() {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT p.id as pro_id , p.name as pro_name , MIN(price) as price , p.[image]\n"
                    + "FROM product as p \n"
                    + "JOIN product_item as pi \n"
                    + "on p.id = pi.product_id\n"
                    + "GROUP BY p.id, p.name, p.[image]";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            return rs;

        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public ResultSet getAllByName(String name) {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT p.id as pro_id , p.name as pro_name , MIN(price) as price , p.[image]\n"
                    + "FROM product as p \n"
                    + "JOIN product_item as pi \n"
                    + "on p.id = pi.product_id\n"
                    + "GROUP BY p.id, p.name, p.[image]\n"
                    + "HAVING p.name like ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            rs = ps.executeQuery();

            return rs;

        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public ResultSet getAllByCatParent(String cat_id) {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT p.id as pro_id , p.name as pro_name , MIN(price) as price , p.[image]\n"
                    + "FROM product as p \n"
                    + "JOIN product_item as pi \n"
                    + "on p.id = pi.product_id\n"
                    + "JOIN category as c \n"
                    + "on c.id = p.category_id\n"
                    + "where c.parent = ? \n"
                    + "GROUP BY p.id, p.name, p.[image]";
            ps = conn.prepareStatement(sql);
            ps.setString(1, cat_id);
            rs = ps.executeQuery();

            return rs;

        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public ResultSet getProductView(String pro_id) {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT\n"
                    + "    p.id as pro_id, p.name as pro_name, p.[description], SUM(pi.quantity) as quantity, MIN(pi.price) as price , p.[image],\n"
                    + "    COALESCE(pc.name + ' ', '')+c.name as cat_name\n"
                    + "FROM product as p\n"
                    + "    JOIN product_item as pi\n"
                    + "    on p.id = pi.product_id\n"
                    + "    JOIN category as c\n"
                    + "    on p.category_id = c.id\n"
                    + "    JOIN category as pc\n"
                    + "    ON c.parent = pc.id\n"
                    + "Where p.id = ? \n"
                    + "GROUP BY p.id, p.name, p.[description], p.quantity, p.[image], pc.name,c.name";
            ps = conn.prepareStatement(sql);
            ps.setString(1, pro_id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs;
            }
        } catch (Exception e) {
            return null;
        }
        return null;
    }

    public int addNewProductItem(Product_item obj) {
        Connection conn = null;
        PreparedStatement pst = null;
        int count = 0;

        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO product_item (id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            pst = conn.prepareStatement(sql);
            pst.setInt(1, obj.getItem_id());
            pst.setInt(2, obj.getPro_id());
            pst.setInt(3, obj.getItem_quan()); // Assuming 'quantity' is a field in Product_item
            pst.setDouble(4, obj.getPrice()); // Assuming 'price' is a field in Product_item
            count = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            count = 0;
        } finally {
            try {
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

        return count;
    }

    public JSONObject getProductOptions(String pro_id) {
        JSONObject json = new JSONObject();
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT\n"
                    + "    v.name as variation_name, vo.[value] as variation_option_value\n"
                    + "FROM product as p\n"
                    + "    JOIN product_item as pi\n"
                    + "    on p.id = pi.product_id\n"
                    + "    JOIN product_configuration as pc\n"
                    + "    ON pi.id = pc.products_item_id\n"
                    + "    JOIN variation_option as vo\n"
                    + "    on vo.id = pc.variation_option_id\n"
                    + "    JOIN variation as v\n"
                    + "    on  vo.variation_id = v.id\n"
                    + "where p.id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, pro_id);
            rs = ps.executeQuery();
            Map<String, JSONArray> variations = new HashMap<>();
            while (rs.next()) {
                String variationName = rs.getString("variation_name");
                String variationOption = rs.getString("variation_option_value");
                if (!variations.containsKey(variationName)) {
                    variations.put(variationName, new JSONArray());
                }
                if (!containJson(variations.get(variationName), variationOption)) {
                    variations.get(variationName).put(variationOption);
                }
            }

            for (Map.Entry<String, JSONArray> entry : variations.entrySet()) {
                if (entry.getValue().length() > 1) {
                    json.put(entry.getKey(), entry.getValue());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return json;
    }

    public JSONObject getUpdatedProductOptions(String pro_id, JSONObject selectedOptions,int numOfOp) {
        JSONObject json = new JSONObject();
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            int tmp =0;
            StringBuilder sql = new StringBuilder("SELECT "
                    + "    pi.id ,v.name as variation_name, vo.[value] as variation_option_value,pi.price,pi.quantity "
                    + "FROM product as p "
                    + "    JOIN product_item as pi "
                    + "    on p.id = pi.product_id "
                    + "    JOIN product_configuration as pc "
                    + "    ON pi.id = pc.products_item_id "
                    + "    JOIN variation_option as vo "
                    + "    on vo.id = pc.variation_option_id "
                    + "    JOIN variation as v "
                    + "    on  vo.variation_id = v.id "
                    + "where p.id = ? ");
            for (String key : selectedOptions.keySet()) {
                sql.append("AND EXISTS "
                        + "( "
                        + "    select 1 "
                        + "    FROM product as p2 "
                        + "    JOIN product_item as pi2 "
                        + "    on p2.id = pi2.product_id "
                        + "    JOIN product_configuration as pc2 "
                        + "    ON pi2.id = pc2.products_item_id "
                        + "    JOIN variation_option as vo2 "
                        + "    on vo2.id = pc2.variation_option_id "
                        + "    JOIN variation as v2 "
                        + "    on  vo2.variation_id = v2.id "
                        + "    where pi2.id =pi.id "
                        + "    AND v2.name = ? AND vo2.[value] = ? "
                        + ")");
                tmp++;
            }
            ps = conn.prepareStatement(sql.toString());
            ps.setString(1, pro_id);
            int index =2;
            for(String key: selectedOptions.keySet()){
                ps.setString(index++, key); 
                ps.setString(index++, selectedOptions.getString(key));
            }
            rs = ps.executeQuery();
            
            Map<String,JSONArray> variations = new HashMap<>();
            long price  =0 ;
            int quan =0;
            String id ="";
            System.out.println(numOfOp);
            System.out.println(tmp);
            while(rs.next()){
                String variationName = rs.getString("variation_name");
                String variationOption = rs.getString("variation_option_value");
                if(numOfOp==tmp){
                    price = rs.getLong("price");
                    quan = rs.getInt("quantity");
                    id = rs.getString("id");
                }
                if(!variations.containsKey(variationName)){
                    variations.put(variationName, new JSONArray());
                }
                if (!containJson(variations.get(variationName), variationOption)) {
                    variations.get(variationName).put(variationOption);
                }
            }
            json.put("price", price);
            json.put("quan", quan);
            json.put("id", id);
            for(Map.Entry<String,JSONArray> entry : variations.entrySet()){
                json.put(entry.getKey(), entry.getValue());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return json;
    }

    private boolean containJson(JSONArray jsona, String value) {
        for (int i = 0; i < jsona.length(); i++) {
            if (jsona.getString(i).equals(value)) {
                return true;
            }
        }
        return false;
    }
}
