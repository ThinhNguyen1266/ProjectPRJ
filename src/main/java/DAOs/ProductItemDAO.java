/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DB.DBConnection;
import Models.Category;
import Models.Product_item;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author AnhNLCE181837
 */
public class ProductItemDAO {

    public String getProduct_itemID() {
        String id = "210000"; // Default value if no id is found
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
            String sql = "SELECT *\n"
                    + "FROM product_item \n"
                    + "where id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, id);
            rs = pst.executeQuery();
            if (rs.next()) {
                obj = new Product_item();
                obj.setItem_id(Integer.parseInt(rs.getString("id")));
                obj.setPrice(Long.parseLong(rs.getString("price")));
                obj.setItem_quan(Integer.parseInt(rs.getString("quantity")));
                obj.setPro_id(Integer.parseInt(rs.getString("product_id")));
                CategoryDAO cDAO = new CategoryDAO();
                Category cat = cDAO.getCategorByProID(obj.getPro_id());
                obj.setCategory(cat);
            } else {
                obj = null;
            }
        } catch (Exception e) {
            obj = null;
        }
        return obj;
    }

    public ResultSet getDropDownListVariation(String variationID) {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT vo.id, va.name as name, vo.value as value\n"
                    + "	FROM variation va JOIN variation_option vo ON va.id = vo.variation_id\n"
                    + "	where va.id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, variationID);
            rs = pst.executeQuery();
        } catch (Exception e) {
            rs = null;
        }

        return rs;
    }

    public ResultSet getAllAdmin() {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT p.id AS pro_id, p.name as pro_name, p.[description], p.[image], (SELECT SUM(quantity) quantity FROM product_item where product_id = p.id GROUP BY product_id)\n"
                    + " as quantity, c.parent as catParent, c.name as cat_name FROM product p JOIN category c ON p.category_id = c.id";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            return rs;
        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public boolean checkCreateNewProItem(String id) {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement pst = null;
        try {
            String sql = "SELECT * FROM product p JOIN product_item pi ON p.id = pi.product_id JOIN category c ON p.category_id = c.id WHERE c.parent = 302000 AND p.id = ?";
            pst = conn.prepareStatement(sql);
            pst.setString(1, id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            return false;
        }
        return false;
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
                    + "    p.id as pro_id, pi.id as pro_item_id, p.name as pro_name, p.[description], SUM(pi.quantity) as quantity, MIN(pi.price) as price , p.[image],\n"
                    + "    COALESCE(pc.name + ' ', '')+c.name as cat_name\n"
                    + "FROM product as p\n"
                    + "    JOIN product_item as pi\n"
                    + "    on p.id = pi.product_id\n"
                    + "    JOIN category as c\n"
                    + "    on p.category_id = c.id\n"
                    + "    JOIN category as pc\n"
                    + "    ON c.parent = pc.id\n"
                    + "Where p.id = ? \n"
                    + "GROUP BY p.id,pi.id, p.name, p.[description], p.quantity, p.[image], pc.name,c.name";
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

    public int deleteProductItem(String id) {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        int count = 0;
        try {
            String sql = "DELETE FROM product_item WHERE id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, id);
            count = pst.executeUpdate();
        } catch (Exception e) {
            count = 0;
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
                    + "where p.id = ? ";
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

    public JSONObject getUpdatedProductOptions(String pro_id, JSONObject selectedOptions, int numOfOp) {
        JSONObject json = new JSONObject();
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            int tmp = 0;
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
            int index = 2;
            for (String key : selectedOptions.keySet()) {
                ps.setString(index++, key);
                ps.setString(index++, selectedOptions.getString(key));
            }
            rs = ps.executeQuery();

            Map<String, JSONArray> variations = new HashMap<>();
            long price = 0;
            int quan = 0;
            String id = "";
            while (rs.next()) {
                String variationName = rs.getString("variation_name");
                String variationOption = rs.getString("variation_option_value");
                if (numOfOp == tmp) {
                    price = rs.getLong("price");
                    quan = rs.getInt("quantity");
                    id = rs.getString("id");
                }
                if (!variations.containsKey(variationName)) {
                    variations.put(variationName, new JSONArray());
                }
                if (!containJson(variations.get(variationName), variationOption)) {
                    variations.get(variationName).put(variationOption);
                }
            }
            json.put("price", price);
            json.put("quan", quan);
            json.put("id", id);
            for (Map.Entry<String, JSONArray> entry : variations.entrySet()) {
                json.put(entry.getKey(), entry.getValue());
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

    public ResultSet getProductItemFromProduct(String id) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        try {
            String sql = "SELECT pi.id AS proItemID, pi.quantity as quantity, pi.price as price \n"
                    + "FROM product p JOIN product_item pi ON p.id = pi.product_id \n"
                    + "WHERE p.id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, Integer.parseInt(id));
            rs = pst.executeQuery();
        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public ResultSet getProductVariance(String proItemId) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        try {
            String sql = "SELECT pc.products_item_id AS proItemID, va.id as variationID, vo.id as variationOptionID, va.name as variane_name, vo.value as variance_value\n"
                    + "	FROM product_configuration pc\n"
                    + "	JOIN variation_option vo ON pc.variation_option_id = vo.id\n"
                    + "	JOIN variation va ON va.id = vo.variation_id\n"
                    + "	WHERE pc.products_item_id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, Integer.parseInt(proItemId));
            rs = pst.executeQuery();
        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public int checkUpdate(Product_item proItem, List<String[]> option) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        int count = 0;
        try {
            StringBuilder sb = new StringBuilder();
            sb.append("SELECT\n"
                    + "    v.name as variation_name, vo.[value] as variation_option_value, pi.price, pi.quantity\n"
                    + "FROM product as p\n"
                    + "    JOIN product_item as pi\n"
                    + "    on p.id = pi.product_id\n"
                    + "    JOIN product_configuration as pc\n"
                    + "    ON pi.id = pc.products_item_id\n"
                    + "    JOIN variation_option as vo\n"
                    + "    on vo.id = pc.variation_option_id\n"
                    + "    JOIN variation as v\n"
                    + "    on  vo.variation_id = v.id\n"
                    + "where p.id = ? ");
            ProductItemDAO piDAO = new ProductItemDAO();
            int Lindex = 0;
            while (Lindex++ < option.size()) {
                sb.append("AND EXISTS\n"
                        + "(\n"
                        + "    select 1\n"
                        + "    FROM product as p2\n"
                        + "        JOIN product_item as pi2\n"
                        + "        on p2.id = pi2.product_id\n"
                        + "        JOIN product_configuration as pc2\n"
                        + "        ON pi2.id = pc2.products_item_id\n"
                        + "        JOIN variation_option as vo2\n"
                        + "        on vo2.id = pc2.variation_option_id\n"
                        + "        JOIN variation as v2\n"
                        + "        on  vo2.variation_id = v2.id\n"
                        + "    where pi2.id =pi.id\n"
                        + "        AND v2.name = ? AND vo2.[value] = ?\n"
                        + ")");
            }
            String sql = sb.toString();
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, proItem.getPro_id());
            int index = 2;

            for (String[] pair : option) {
                pst.setString(index++, pair[0]);
                pst.setString(index++, pair[1]);
            }

            rs = pst.executeQuery();
            if (rs.next()) {
                return 0;
            } else {
                return 1;
            }

        } catch (Exception e) {
            count = 0;
        }
        return count;
    }

    public ResultSet getOrderProductItem(int id) {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "select pi.id as pro_item_id, p.name as product_name, p.[image] \n"
                    + "from product_item pi join product p on pi.product_id = p.id\n"
                    + "where pi.id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs;
            }
        } catch (Exception e) {
            return null;
        }
        return null;
    }

    public int updateProductItemVariation(Product_item proItem, String oldVariationOP, String newVariationOP) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        int count = 0;
        try {
            String sql = "UPDATE product_configuration SET variation_option_id = ?"
                    + " WHERE products_item_id = ? AND variation_option_id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, newVariationOP);
            pst.setString(2, String.valueOf(proItem.getItem_id()));
            pst.setString(3, oldVariationOP);
            count = pst.executeUpdate();
        } catch (Exception e) {
            count = 0;
        }
        return count;
    }

    public int updateProductItem(Product_item proItem, String quantity, String price) {
        Connection conn = DB.DBConnection.getConnection();
        ResultSet rs = null;
        int count = 0;
        try {
            String sql = "UPDATE product_item SET quantity = ?, price = ? "
                    + " WHERE id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, quantity);
            pst.setString(2, price);
            pst.setString(3, String.valueOf(proItem.getItem_id()));
            count = pst.executeUpdate();
        } catch (Exception e) {
            count = 0;
        }
        return count;
    }

    public ResultSet SortProduct(int price, String type, String name) {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String sortOrder = type.equalsIgnoreCase("asc") ? "ASC" : "DESC";
            String sql = "";

            if (price == 1000) {
                sql = "SELECT p.id as pro_id , p.name as pro_name , MIN(price) as price , p.[image]\n"
                        + "FROM product as p \n"
                        + "JOIN product_item as pi \n"
                        + "on p.id = pi.product_id\n"
                        + "JOIN category as c \n"
                        + "on c.id = p.category_id\n"
                        + "where pi.price < 10000000 \n"
                        + "AND p.name like ? \n"
                        + "GROUP BY p.id, p.name, p.[image]\n"
                        + "ORDER BY MIN(pi.price) " + sortOrder;
            } else if (price == 2000) {
                sql = "SELECT p.id as pro_id , p.name as pro_name , MIN(price) as price , p.[image]\n"
                        + "FROM product as p \n"
                        + "JOIN product_item as pi \n"
                        + "on p.id = pi.product_id\n"
                        + "JOIN category as c \n"
                        + "on c.id = p.category_id\n"
                        + "where pi.price > 10000000 and pi.price < 20000000 \n"
                        + "AND p.name like ? \n"
                        + "GROUP BY p.id, p.name, p.[image]\n"
                        + "ORDER BY MIN(pi.price) " + sortOrder;
            } else if (price == 3000) {
                sql = "SELECT p.id as pro_id , p.name as pro_name , MIN(price) as price , p.[image]\n"
                        + "FROM product as p \n"
                        + "JOIN product_item as pi \n"
                        + "on p.id = pi.product_id\n"
                        + "JOIN category as c \n"
                        + "on c.id = p.category_id\n"
                        + "where pi.price > 20000000\n"
                        + "AND p.name like ? \n"
                        + "GROUP BY p.id, p.name, p.[image]\n"
                        + "ORDER BY MIN(pi.price) " + sortOrder;
            }

            if (!sql.isEmpty()) {
                System.out.println("Executing SQL: " + sql);
                ps = conn.prepareStatement(sql);
                ps.setString(1, "%" + name + "%");
                rs = ps.executeQuery();
            } else {
                System.out.println("No SQL query executed for price: " + price);
            }

        } catch (Exception e) {
            e.printStackTrace();
            rs = null;
        }
        return rs;
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
