/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

/**
 *
 * @author AnhNLCE181837
 */
public class DBConnection {
    public static Connection getConnection(){
        Connection conn;
        try{
            Properties prop = new Properties();

            InputStream fi = DBConnection.class.getResourceAsStream("/database.properties");
            prop.load(fi);
            System.out.println(prop.getProperty("DATA_SERVER_NAME"));
            System.out.println(prop.getProperty("DATABASE_NAME"));
            System.out.println(prop.getProperty("USERNAME"));
            System.out.println(prop.getProperty("PASSWORD"));
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String url = "jdbc:sqlserver://"+prop.getProperty("DATA_SERVER_NAME") +":1433;"
                    + "databaseName="+prop.getProperty("DATABASE_NAME")+";"
                    + "user="+prop.getProperty("USERNAME")+";"
                    + "password="+prop.getProperty("PASSWORD")+";"
                    + "encrypt=true;trustServerCertificate=true";
            conn = DriverManager.getConnection(url);
        }catch(Exception ex){
            conn = null;
        }
        return conn;
    }
}
