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
public class UserDAO {

    public User getUser(String name) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        User obj = null;
        Address addressDraw = null;

        try {
            conn = DB.DBConnection.getConnection();
            String sql = "SELECT u.name AS user_name, u.phone_number AS phone_number, acc.email AS email, a.address AS address\n"
                    + "	FROM account acc \n"
                    + "    JOIN [user] u ON acc.id = u.account_id\n"
                    + "                    JOIN user_address ua ON u.account_id = ua.user_id\n"
                    + "                    JOIN [address] a ON ua.address_id = a.id \n"
                    + "                    WHERE acc.name = ?";
            pst = conn.prepareStatement(sql);
            pst.setString(1, name);
            rs = pst.executeQuery();

            if (rs.next()) {
                addressDraw = new Address();
                addressDraw.setAddress(rs.getString("address"));
                obj = new User(rs.getString("email"), rs.getString("user_name"), rs.getString("phone_number"), addressDraw);

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

    public User getUserWithId(String name) {
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        User obj = null;
        Address addressDraw = null;

        try {
            conn = DB.DBConnection.getConnection();
            String sql = "SELECT u.account_id, u.name AS user_name, u.phone_number AS phone_number, acc.email AS email, a.address AS address\n"
                    + "	FROM account acc \n"
                    + "    JOIN [user] u ON acc.id = u.account_id\n"
                    + "                    JOIN user_address ua ON u.account_id = ua.user_id\n"
                    + "                    JOIN [address] a ON ua.address_id = a.id \n"
                    + "                    WHERE acc.name = ?";
            pst = conn.prepareStatement(sql);
            pst.setString(1, name);
            rs = pst.executeQuery();

            if (rs.next()) {
                addressDraw = new Address();
                addressDraw.setAddress(rs.getString("address"));
                obj = new User(rs.getInt("account_id"), rs.getString("email"), rs.getString("user_name"), rs.getString("phone_number"), addressDraw);

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

    public String getUserID(String name) {
        Connection conn = null;
        ResultSet rs = null;
        String id = "";
        try {
            conn = DB.DBConnection.getConnection();
            String sql = "Select id from account where name = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, name);
            rs = pst.executeQuery();
            if (rs.next()) {
                id = rs.getString("id");
            }

        } catch (Exception e) {
            id = "";
        }
        return id;
    }

    public String getUserAddressID(String userid) {
        Connection conn = null;
        ResultSet rs = null;
        String id = "";
        try {
            conn = DB.DBConnection.getConnection();
            String sql = "Select a.id from address a join user_address ua on a.id=ua.address_id where ua.user_id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, userid);
            rs = pst.executeQuery();
            if (rs.next()) {
                id = rs.getString("id");
            }

        } catch (Exception e) {
            id = "";
        }
        return id;
    }

    public ResultSet getAll() {
        ResultSet rs;
        try {
            String sql = "SELECT u.account_id, u.name, u.phone_number , a.email\n"
                    + "FROM account AS a\n"
                    + "JOIN [user] AS u \n"
                    + "ON a.id = u.account_id";
            Connection conn = DB.DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            return rs;
        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public int editUser(int id, User newinfo) {

        int count;
        try {
            Connection conn = DB.DBConnection.getConnection();
            String sql = "UPDATE [user] set name=?, phone_number=? where account_id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, newinfo.getName());
            pst.setString(2, newinfo.getPhoneNumber());
            pst.setInt(3, newinfo.getId());

            count = pst.executeUpdate();
        } catch (Exception e) {
            count = 0;
        }
        return count;
    }

    public int editUserEmail(int id, User newinfo) {

        int count;
        try {
            Connection conn = DB.DBConnection.getConnection();
            String sql = "UPDATE account set email=? where id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, newinfo.getEmails());
            pst.setInt(2, newinfo.getId());

            count = pst.executeUpdate();
        } catch (Exception e) {
            count = 0;
        }
        return count;
    }

    public int editUserAddress(Address address, User newinfo) {
        Connection conn = DB.DBConnection.getConnection();
        int count = 0;
        try {
            String sql = "Update address set province_id=?, address=? where id=?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, newinfo.getAddress().getProvince().getProvince_id());
            pst.setString(2, newinfo.getAddress().getAddress());
            pst.setInt(3, newinfo.getAddress().getAddressId());
            count = pst.executeUpdate();
        } catch (Exception e) {
            count = 0;
        }

        return count;
    }

    public ResultSet getAllUserAddress(int id) {
        Connection conn = DB.DBConnection.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "select *\n"
                    + "from user_address ua \n"
                    + "join address a on ua.address_id=a.id \n"
                    + "join [province] p on a.province_id=p.id\n"
                    + "where ua.user_id=?";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            return rs;
        } catch (Exception e) {
            rs = null;
        }
        return rs;
    }

    public int getUserDefault(int userid) {
        Connection conn = null;
        ResultSet rs = null;
        int id = 0;
        try {
            conn = DB.DBConnection.getConnection();
            String sql = "Select a.id from address a join user_address ua on a.id=ua.address_id where ua.user_id= ? and ua.is_default='1'";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, userid);
            rs = pst.executeQuery();
            if (rs.next()) {
                id = rs.getInt("id");
            }

        } catch (Exception e) {
            id = 0;
        }
        return id;
    }

    public int setAddressDefault(int address_id) {
        Connection conn = DB.DBConnection.getConnection();
        int count;
        try {
            String sql = "update user_address set is_default='1' where address_id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, address_id);
            count = pst.executeUpdate();
        } catch (Exception e) {
            count = 0;
        }
        return count;
    }

    public int setAddressNormal(int address_id) {
        Connection conn = DB.DBConnection.getConnection();
        int count;
        try {
            String sql = "update user_address set is_default='0' where address_id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, address_id);
            count = pst.executeUpdate();
        } catch (Exception e) {
            count = 0;
        }
        return count;
    }

    public String getUserDefaultAddress(int userid) {
        Connection conn = null;
        ResultSet rs = null;
        String address="";
        String province="";
        String fulladdress="";
        try {
            conn = DB.DBConnection.getConnection();
            String sql = "Select a.id,a.address,p.name from address a \n"
                    + "join user_address ua on a.id=ua.address_id \n"
                    + "join province p on a.province_id=p.id\n"
                    + "where ua.user_id= ? and ua.is_default='1'";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, userid);
            rs = pst.executeQuery();
            if (rs.next()) {
                address = rs.getString("address");
                province=rs.getString("name");
                fulladdress=address+","+province;
                
            }

        } catch (Exception e) {
           fulladdress=null;
        }
        return fulladdress;
    }
}
