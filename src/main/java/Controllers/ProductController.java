/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.AccountDAO;
import DAOs.CartDAO;
import DAOs.Cart_itemDAO;
import DAOs.CategoryDAO;
import DAOs.ProductDAO;
import DAOs.ProductItemDAO;
import DAOs.Product_configurationDAO;
import DAOs.UserDAO;
import DAOs.VariationDAO;
import Models.Cart;
import Models.Cart_item;
import Models.Category;
import Models.Product;
import Models.Product_item;
import Models.User;
import Models.Variation;
import com.mycompany.projectprjgroup1.AzureBlobStorageUtil;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author AnhNLCE181837
 */
@MultipartConfig
public class ProductController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getRequestURI();
        HttpSession session = request.getSession();
        boolean coke = false;
        if (path.equals("/ProductController/List")) {
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("username")) {
                        session.setAttribute("customername", cookie.getValue());
                        coke = true;
                        break;
                    }
                }
            }
            request.getRequestDispatcher("/index.jsp").forward(request, response);

        } else if (path.equals("/ProductController/About-Contact")) {
            request.getRequestDispatcher("/about-contact.jsp").forward(request, response);
        } else if (path.startsWith("/ProductController/Cart")) {
            Cookie[] cookies = request.getCookies();
            boolean flag = false;
            for (Cookie c : cookies) {
                if (c.getName().equals("username")) {
                    flag = true;
                }
            }
            if (!flag) {
                response.sendRedirect("/AccountController/Login");
            } else {
                String[] s = path.split("/");
                String id = s[s.length - 1];
                ProductItemDAO pdao = new ProductItemDAO();
                Product_item obj = pdao.getProductItem(id);
                session.setAttribute("product", obj);
                request.getRequestDispatcher("/cart.jsp").forward(request, response);
            }
        } else if (path.equals("/ProductController/Checkout")) {
             Cookie[] cookies = request.getCookies();
             String id="";
           if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("username")) {
                        id=cookie.getValue();
                        break;
                    }
                }
            }
            AccountDAO dao = new AccountDAO();
            User user = null;
            user = new User();
            UserDAO userDAO = new UserDAO();
            user = userDAO.getUserWithId(id);
            session.setAttribute("userinformation", user);
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        } else if (path.startsWith("/ProductController/Category")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];
            session.setAttribute("categoryid", id);
            request.getRequestDispatcher("/category.jsp").forward(request, response);
        } else if (path.equals("/ProductController/Search")) {
            request.getRequestDispatcher("/searched_product.jsp").forward(request, response);
        } else if (path.startsWith("/ProductController/AddToCart")) {
            String[] url = path.split("/");
            String id = url[url.length - 1];
            response.sendRedirect("/ProductController/Cart/" + id);
        } else if (path.equals("/ProductController/PlaceOrder")) {

            response.sendRedirect("/ProductController/List");
        } else if (path.startsWith("/ProductController/Delete/")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];
            Cart_itemDAO cdao = new Cart_itemDAO();
            cdao.deleteNewCart_Item(Integer.parseInt(id));
            List<Cart_item> cartList = (List<Cart_item>) session.getAttribute("cartList");

            // Find and remove the item from the cartList
            if (cartList != null) {
                Iterator<Cart_item> iterator = cartList.iterator();
                while (iterator.hasNext()) {
                    Cart_item item = iterator.next();
                    if (item.getCart_item_id() == Integer.parseInt(id)) { // Assuming getId() returns the ID of the item
                        iterator.remove();
                        break; // Item found and removed, exit the loop
                    }
                }
            }

            // Update the cartList in the session
            session.setAttribute("cartList", cartList);
            response.sendRedirect("/ProductController/Cart");
        } else if (path.startsWith("/ProductController/Edit/")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];
            request.setAttribute("editID", id);
            request.getRequestDispatcher("/editProduct.jsp").forward(request, response);
        } else if (path.startsWith("/ProductController/View")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];
            request.setAttribute("proId", id);
            request.getRequestDispatcher("/product.jsp").forward(request, response);

        } else if (path.equals("/ProductController/Sort")) {

            request.getRequestDispatcher("/sorted_product.jsp").forward(request, response);

        } else if (path.startsWith("/ProductController/EditProductItem/")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];
            request.setAttribute("ProItemID", id);
            request.getRequestDispatcher("/editProductItem.jsp").forward(request, response);
        } else if (path.startsWith("/ProductController/ProductItem/AddNew/")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];
            ProductDAO pDAO = new ProductDAO();
            Product obj = pDAO.getProduct(id);
            request.setAttribute("product", obj);
            request.getRequestDispatcher("/createProductItem.jsp").forward(request, response);
        } else if (path.startsWith("/ProductController/DeleteProductItem/")) {
            String[] s = path.split("/");
            String proItemId = s[s.length - 2];
            String proId = s[s.length - 1];
            ProductItemDAO piDAO = new ProductItemDAO();
            Product_configurationDAO pcDAO = new Product_configurationDAO();
            pcDAO.delete(proItemId);
            piDAO.deleteProductItem(proItemId);
            response.sendRedirect("/ProductController/Edit/" + proId);
        } else {
            request.getRequestDispatcher("/404.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (request.getParameter("btnAddToCart") != null) {
            String proItem_id = request.getParameter("proItemId");
            String quantity = request.getParameter("quantity");
            List<Cart_item> cartList = new ArrayList<Cart_item>();

            Cart_itemDAO cart_itemDAO = new Cart_itemDAO();
            ProductItemDAO productItemDAO = new ProductItemDAO();

            Product_item product_item = productItemDAO.getProductItem(proItem_id);

            String pro_name = product_item.getPro_name();

            Cart cart = null;
            CartDAO cartDAO = new CartDAO();
            UserDAO userDAO = new UserDAO();

            Cookie[] c = request.getCookies();
            String username = "";
            for (Cookie cookie : c) {
                if (cookie.getName().equals("username")) {
                    username = cookie.getValue();
                    break;
                }
            }

            String userID = userDAO.getUserID(username);

            User user = new User();
            user.setId(Integer.parseInt(userID));
            int count;

            String cartIDDraw = cartDAO.getCartID();
            int cartID = (Integer.parseInt(cartIDDraw) + 1);

            cart = new Cart(cartID, user);

            String cart_itemIDDraw = cart_itemDAO.getCart_itemID();
            int cart_itemID = (Integer.parseInt(cart_itemIDDraw) + 1);

            if (session.getAttribute("cartList") == null) {
                Cart_item cart_item = new Cart_item(cart_itemID, product_item, cartID, user, Integer.parseInt(quantity));

                cartList.add(cart_item);
                count = cartDAO.addNewCart(cart);
                count = cart_itemDAO.addNewCart_Item(cart_item);

                session.setAttribute("cartList", cartList);
            } else {
                Cart_item cart_item = new Cart_item(cart_itemID, product_item, (cartID - 1), user, Integer.parseInt(quantity));

                cartList = (List<Cart_item>) session.getAttribute("cartList");
                cartList.add(cart_item);
                count = cart_itemDAO.addNewCart_Item(cart_item);
            }
            ProductDAO pDAO = new ProductDAO();

            int index = 0;
            while (index < cartList.size()) {
                Product p = pDAO.getProduct(String.valueOf(cart_itemDAO.getCartItem(String.valueOf(cartList.get(index).getCart_item_id())).getProduct_item().getPro_id()));
                index++;
            }
            response.sendRedirect("/ProductController/List");
        }

        if (request.getParameter("btnSearch") != null) {
            String name = request.getParameter("txtSearchName");
            session.setAttribute("Searchname", name);
            response.sendRedirect("/ProductController/Search");
        }
        if (request.getParameter("createBtn") != null) {
            ProductDAO pdao = new ProductDAO();

            String name = request.getParameter("proName");
            String des = request.getParameter("proDes");
            String quan = request.getParameter("proQuan");
            String cat = request.getParameter("proCat");
            int maxID = pdao.getMaxID(Integer.parseInt(cat));
            maxID++;
            Part part = request.getPart("proImg");
            String fileName = part.getSubmittedFileName();
            InputStream fileContent = part.getInputStream();
            File tempFile = File.createTempFile("upload-", fileName);
            try ( FileOutputStream fos = new FileOutputStream(tempFile)) {
                byte[] buffer = new byte[1024];
                int len;
                while ((len = fileContent.read(buffer)) != -1) {
                    fos.write(buffer, 0, len);
                }
            }
            AzureBlobStorageUtil azureBlobStorageUtil = new AzureBlobStorageUtil();
            String imageUrl = azureBlobStorageUtil.uploadImage(tempFile.getPath(), fileName);
            tempFile.delete();
            Category category = new Category(Integer.parseInt(cat));
            Product product = new Product(maxID, name, des, imageUrl, Integer.parseInt(quan), category);
            pdao.add(product);
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
        }

        if (request.getParameter("btnUpdate") != null) {
            String id = request.getParameter("proID");
            String name = request.getParameter("proName");
            String des = request.getParameter("proDes");
            String subCat = request.getParameter("proSubCat");

            Product obj = new Product();
            obj.setPro_id(Integer.parseInt(id));
            obj.setPro_name(name);
            obj.setPro_des(des);
            Category cat = new Category(Integer.parseInt(subCat));
            obj.setCategory(cat);

            ProductDAO pDAO = new ProductDAO();
            int count = pDAO.editProduct(obj);
            if (count != 0) {
                response.sendRedirect("/Admin_profile");
            }
        } else if (request.getParameter("btnEditProItem") != null) {
            String proItemID = request.getParameter("TxtProItemID");
            String quantity = request.getParameter("TxtQuantity");
            String price = request.getParameter("TxtPrice");
            ProductItemDAO pDAO = new ProductItemDAO();
            Product_item pi = pDAO.getProductItem(proItemID);
            CategoryDAO cDAO = new CategoryDAO();
            String catParent = cDAO.getCatName(pi.getCategory().getParent()).getCat_name();
            List<String[]> option = new ArrayList<>();
            List<String[]> ProItemVariation = new ArrayList<>();
            ResultSet rs = pDAO.getProductVariance(proItemID);
            if (catParent.equals("Laptops")) {
                String Storage = request.getParameter("txtStorage");
                String RAM = request.getParameter("txtRAM");
                option.add(new String[]{"Storage", Storage});
                option.add(new String[]{"RAM", RAM});
                try {
                    while (rs.next()) {
                        String proItemVariationName = rs.getString("variane_name");
                        String proItemVariationValue = rs.getString("variance_value");
                        if (proItemVariationName.equals("Storage") || proItemVariationName.equals("RAM")) {
                            ProItemVariation.add(new String[]{proItemVariationName, proItemVariationValue});
                        }
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else {
                String Storage = request.getParameter("txtStorage");
                String RAM = request.getParameter("txtRAM");
                String Color = request.getParameter("txtColor");
                option.add(new String[]{"Color", Color});
                option.add(new String[]{"Storage", Storage});
                option.add(new String[]{"RAM", RAM});
                try {
                    while (rs.next()) {
                        String proItemVariationName = rs.getString("variane_name");
                        String proItemVariationValue = rs.getString("variance_value");
                        if (proItemVariationName.equals("Color") || proItemVariationName.equals("Storage") || proItemVariationName.equals("RAM")) {
                            ProItemVariation.add(new String[]{proItemVariationName, proItemVariationValue});
                        }
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (pDAO.checkUpdate(pi, option) == 1) {
                VariationDAO vDAO = new VariationDAO();
                int index = 0;
                for (String[] pair : option) {
                    String variationID = vDAO.getVariationID(pair[0], String.valueOf(pi.getCategory().getParent()));
                    String newVariationOpID = vDAO.getVariationOpID(pair[1], variationID);
                    String oldVariationOpID = vDAO.getVariationOpID(ProItemVariation.get(index++)[1], variationID);
                    if (!oldVariationOpID.equals(newVariationOpID)) {
                        pDAO.updateProductItemVariation(pi, oldVariationOpID, newVariationOpID);
                    }
                }
            }
            pDAO.updateProductItem(pi, quantity, price);

            response.sendRedirect("/ProductController/Edit/" + pi.getPro_id());
        } else if (request.getParameter("btnAddNewProItem") != null) {
            String proItemID = request.getParameter("txtProItemID");
            String quantity = request.getParameter("txtProItemQuantity");
            String price = request.getParameter("txtProItemPrice");

            String productID = request.getParameter("txtProductID");
            ProductDAO pDAO = new ProductDAO();
            Product product = pDAO.getProduct(productID);
            String catParentID = String.valueOf(product.getCategory().getParent());
            ProductItemDAO piDAO = new ProductItemDAO();
            Product_item pi = new Product_item();
            pi.setItem_id(Integer.parseInt(proItemID));
            pi.setPro_id(product.getPro_id());
            pi.setItem_quan(Integer.parseInt(quantity));
            pi.setPrice(Long.parseLong(price));
            

            List<String[]> option = new ArrayList<>();

            CategoryDAO cDAO = new CategoryDAO();
            String catParentName = cDAO.getCatName(Integer.parseInt(catParentID)).getCat_name();
            if (catParentName.equals("Laptops")) {
                String Storage = request.getParameter("txtStorage");
                String RAM = request.getParameter("txtRAM");
                option.add(new String[]{"Storage", Storage});
                option.add(new String[]{"RAM", RAM});
            } else {
                String Storage = request.getParameter("txtStorage");
                String RAM = request.getParameter("txtRAM");
                String Color = request.getParameter("txtColor");
                option.add(new String[]{"Storage", Storage});
                option.add(new String[]{"RAM", RAM});
                option.add(new String[]{"Color", Color});
            }
            VariationDAO vDAO = new VariationDAO();
            Product_configurationDAO pcDAO = new Product_configurationDAO();
            if (piDAO.checkUpdate(pi, option) == 1) {
                int count = piDAO.addNewProductItem(pi);
                for (String[] pair : option) {
                    String VariationID = vDAO.getVariationID(pair[0], catParentID);
                    String VariationOPID = vDAO.getVariationOpID(pair[1], VariationID);
                    count = pcDAO.Addnew(String.valueOf(pi.getItem_id()), VariationOPID);
                }
            }
            response.sendRedirect("/ProductController/Edit/" + pi.getPro_id());
        }
        if (request.getParameter("btnSort") != null) {

            String price = request.getParameter("price");
            String type = request.getParameter("sortType");

            session.setAttribute("type", type);

            session.setAttribute("price", price);
            response.sendRedirect("/ProductController/Sort");

        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
