/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.CategoryDAO;
import DAOs.ProductDAO;
import Models.Category;
import Models.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
        } else if (path.equals("/ProductController/Cart")) {
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        } else if (path.equals("/ProductController/Checkout")) {
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
        } else if (path.startsWith("/ProductController/Category")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];

            // Validate if the ID is a number
            if (id.matches("\\d+")) {
                CategoryDAO dao = new CategoryDAO();
                Category obj = dao.getCatName(Integer.parseInt(id));

                if (obj != null) {
                    String name = obj.getCat_name();
                    session.setAttribute("category", name);
                    session.setAttribute("categoryid", id);
                    request.getRequestDispatcher("/Category.jsp").forward(request, response);
                } else {
                    // Handle case where category is not found
                    request.getRequestDispatcher("/404.jsp").forward(request, response);
                }
            } else {
                // Handle invalid category ID
                request.getRequestDispatcher("/404.jsp").forward(request, response);
            }
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
        processRequest(request, response);
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
