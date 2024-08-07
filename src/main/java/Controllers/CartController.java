/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.CartDAO;
import DAOs.Cart_itemDAO;
import DAOs.ProductItemDAO;
import Models.Cart;
import Models.Cart_item;
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
import java.io.BufferedReader;
import org.json.JSONObject;

/**
 *
 * @author Thinh
 */
public class CartController extends HttpServlet {

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
            out.println("<title>Servlet CartController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartController at " + request.getContextPath() + "</h1>");
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
        if (path.equals("/CartController")) {
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
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
            ProductItemDAO pidao = new ProductItemDAO();
            CartDAO cartDAO = new CartDAO();
            Cart_itemDAO cart_itemDAO = new Cart_itemDAO();
            String userID = request.getParameter("userID");
            String proItemID = request.getParameter("productItemID");
            int quan = Integer.parseInt(request.getParameter("quantity"));
            Product_item pi = pidao.getProductItem(proItemID);
            int cartID = cartDAO.getCartIDByUserID(userID);
            String tmpID = cart_itemDAO.contain(cartID, proItemID);
            if (tmpID == null) {
                User user = new User();
                user.setId(Integer.parseInt(userID));
                int id = Integer.parseInt(cart_itemDAO.getCart_itemID());
                id++;
                Cart_item cart_item = new Cart_item(id, pi, cartID, user, quan);
                cart_itemDAO.addNewCart_Item(cart_item);
            } else {
                cart_itemDAO.addQuantity(tmpID, quan);
            }
            response.sendRedirect("/CartController");
        } else if (request.getParameter("updateQuan") != null) {
            String cartItemID = request.getParameter("cartItemID");
            String newquan = request.getParameter("newQuantity");
            Cart_itemDAO cidao = new Cart_itemDAO();
            cidao.updateQuantity(cartItemID, newquan);
            response.getWriter().write("success");
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
