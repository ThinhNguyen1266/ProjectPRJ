/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.AccountDAO;
import Models.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author AnhNLCE181837
 */
public class AccountController extends HttpServlet {

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
            out.println("<title>Servlet AccountController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AccountController at " + request.getContextPath() + "</h1>");
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
        if (path.equals("/")) {
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } else if (path.equals("/Login") || path.equals("/AccountController/Login")) {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else if (path.equals("/Index") || path.equals("/AccountController/Index")) {
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } else if (path.equals("/Create_account") || path.equals("/AccountController/Create_account")) {
            request.getRequestDispatcher("/create-account.jsp").forward(request, response);
        } else if (path.equals("/profile") || path.equals("/AccountController/Profile")) {
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
        } else if (path.equals("/Admin_profile") || path.equals("/AccountController/Admin_profile")) {
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
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
        if (request.getParameter("btnLogin") != null) {
            String username = request.getParameter("txtUsername");
            String password = request.getParameter("txtPassword");

            Account acc = new Account();
            acc.setUsername(username);
            acc.setPassword(password);
            AccountDAO dao = new AccountDAO();
            if (dao.loginAdmin(acc)) {
                Cookie adminCookie = new Cookie("username", username);
                adminCookie.setMaxAge(24 * 60 * 60 * 3); // Thời gian sống của cookie (ở đây là 3 ngày)
                response.addCookie(adminCookie);
                session.setAttribute("adminname", username);
                response.sendRedirect("/Admin_profile");
            } else {
                if (dao.login(acc)) {
                    // Tạo cookie cho username
                    Cookie usernameCookie = new Cookie("username", username);
                    usernameCookie.setMaxAge(24 * 60 * 60 * 3); // Thời gian sống của cookie (ở đây là 3 ngày)
                    response.addCookie(usernameCookie);
                    session.setAttribute("customername", username);
                    response.sendRedirect("/ProductController/List");
                } else {
                    request.setAttribute("error", "invalid username or password");
                    response.sendRedirect("/Create_account");
                }

            }
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
