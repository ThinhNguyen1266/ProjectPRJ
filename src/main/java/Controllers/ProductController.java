/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.CartDAO;
import DAOs.Cart_itemDAO;
import DAOs.CategoryDAO;
import DAOs.ProductDAO;
import DAOs.ProductItemDAO;
import DAOs.UserDAO;
import Models.Cart;
import Models.Cart_item;
import Models.Category;
import Models.Product;
import Models.Product_item;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author AnhNLCE181837
 */
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
        if (path.equals("/") || path.equals("/ProductController/List")) {
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } else if (path.equals("/ProductController/About-Contact")) {
            request.getRequestDispatcher("/about-contact.jsp").forward(request, response);
        } else if (path.startsWith("/ProductController/Cart")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];
            ProductDAO pdao = new ProductDAO();
            Product obj = pdao.getProduct(id);
            session.setAttribute("product", obj);
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        } else if (path.equals("/ProductController/Checkout")) {
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        } else if (path.startsWith("/ProductController/Category")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];
            CategoryDAO dao = new CategoryDAO();
            Category obj = dao.getCatName(Integer.parseInt(id));
            String name = obj.getCat_name();
            session.setAttribute("category", name);
            session.setAttribute("categoryid", id);
            request.getRequestDispatcher("/category.jsp").forward(request, response);
        } else if (path.equals("/ProductController/Search")) {
            request.getRequestDispatcher("/searched_product.jsp").forward(request, response);
        } else if (path.startsWith("/ProductController/AddToCart")) {
            String[] url = path.split("/");
            String id = url[url.length - 1];
            response.sendRedirect("/ProductController/Cart/" + id);
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
        if (request.getParameter("btnAddToCart") != null) {
            HttpSession session = request.getSession();
            String pro_id = request.getParameter("productId");
            String quantity = request.getParameter("quantity");
            List<Cart_item> cartList = new ArrayList<Cart_item>();

            Cart_itemDAO cart_itemDAO = new Cart_itemDAO();
            String cart_itemID = cart_itemDAO.getCart_itemID();

            Product_item product_item = new Product_item();
            ProductItemDAO productItemDAO = new ProductItemDAO();
            String product_itemID = productItemDAO.getProduct_itemID();
            product_item = new Product_item(Integer.parseInt(product_itemID),Integer.parseInt(pro_id));

            Cart cart = null;
            CartDAO cartDAO = new CartDAO();
            UserDAO userDAO = new UserDAO();
            String cartID = cartDAO.getCartID();

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

            cart = new Cart((Integer.parseInt(cartID) + 1), user);

            count = productItemDAO.addNewProductItem(product_item);

            Cart_item cart_item = new Cart_item(Integer.parseInt(cart_itemID), product_item, (Integer.parseInt(cartID) + 1), user, Integer.parseInt(quantity));

            if (session.getAttribute("cartList") == null) {
                cartList.add(cart_item);
                count = cartDAO.addNewCart(cart);
                count = cart_itemDAO.addNewCart_Item(cart_item);

                session.setAttribute("cartList", cartList);
            } else {
                cartList = (List<Cart_item>) session.getAttribute("cartList");
                cartList.add(cart_item);
                count = cart_itemDAO.addNewCart_Item(cart_item);
            }
            
            ProductDAO pDAO = new ProductDAO();
            Product p = pDAO.getProduct(String.valueOf(cart_item.getProduct_item().getPro_id()));
            response.sendRedirect("/ProductController/List");
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
