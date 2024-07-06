/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.AccountDAO;
import DAOs.ProvinceDAO;
import DAOs.UserDAO;
import Models.Account;
import Models.Address;
import Models.Province;
import Models.User;
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
        Cookie[] cookies = request.getCookies();
        HttpSession session = request.getSession();

        if (path.equals("/")) {
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("username")) {
                        session.setAttribute("customername", cookie.getValue());
                        break;
                    }
                }
            }
            request.getRequestDispatcher("/index.jsp").forward(request, response);

        } else if (path.equals("/Login") || path.equals("/AccountController/Login")) {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else if (path.equals("/Index") || path.equals("/AccountController/Index")) {
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } else if (path.equals("/Create_account") || path.equals("/AccountController/Create_account")) {
            request.getRequestDispatcher("/create-account.jsp").forward(request, response);
        } else if (path.equals("/Create_profile") || path.equals("/AccountController/Create_profile")) {
            request.getRequestDispatcher("/create-account-profile.jsp").forward(request, response);
        } else if (path.equals("/profile") || path.equals("/AccountController/Profile")) {
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
        } else if (path.equals("/Admin_profile") || path.equals("/AccountController/Admin_profile")) {
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if (c.getName().equals("adminName")) {
                        session.setAttribute("adminName", c.getValue());
                        request.getRequestDispatcher("/admin.jsp").forward(request, response);
                    }
                }
            }

        } else if (path.startsWith("/AccountController/Logout")) {

            session.invalidate();

            // Remove cookies
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("username") || cookie.getName().equals("adminName")) {
                        cookie.setValue(null);
                        cookie.setMaxAge(0);
                        cookie.setPath("/");
                        response.addCookie(cookie);
                    }
                }
            }

            // Redirect to login page
            response.sendRedirect("/");

        } else if (path.equals("/Search")) {
            request.getRequestDispatcher("/searched_product.jsp").forward(request, response);
        } else if  (path.startsWith("/AccountController/Edit")) {
            String[] s = path.split("/");
            String id = s[s.length - 1];
            AccountDAO dao = new AccountDAO();
            User user = null;
            user = new User();
             UserDAO userDAO = new UserDAO();
            user = userDAO.getUserWithId(id);
            session.setAttribute("userinformation", user);
           
            request.getRequestDispatcher("/editProfile.jsp").forward(request, response);
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
                Cookie adminCookie = new Cookie("adminName", username);
                adminCookie.setMaxAge(24 * 60 * 60 * 3); // Thời gian sống của cookie (ở đây là 3 ngày)
                adminCookie.setPath("/");
                response.addCookie(adminCookie);
                session.setAttribute("adminName", username);
                response.sendRedirect("/Admin_profile");
            } else {
                if (dao.login(acc)) {
                    // Tạo cookie cho username
                    Cookie usernameCookie = new Cookie("username", username);
                    usernameCookie.setMaxAge(24 * 60 * 60 * 3); // Thời gian sống của cookie (ở đây là 3 ngày)
                    usernameCookie.setPath("/");
                    response.addCookie(usernameCookie);
                    session.setAttribute("customername", username);
                    response.sendRedirect("/ProductController/List");
                } else {
                    request.setAttribute("error", "invalid username or password");
                    response.sendRedirect("/Create_profile");
                }

            }

        }
        if (request.getParameter("btnSearch") != null) {
            String name = request.getParameter("txtSearchName");
            session.setAttribute("Searchname", name);
            response.sendRedirect("/Search");
        }
        if (request.getParameter("btnSave") != null) {
            String id=request.getParameter("txtId");
            String email = request.getParameter("txtEmail");
            String name = request.getParameter("txtName");
            String phoneNumber = request.getParameter("txtPhonenumber");
             String addressDraw = request.getParameter("txtAddress");
            String provinceDraw = request.getParameter("txtProvince");
            ProvinceDAO provinceDAO = new ProvinceDAO();
            UserDAO uDAO= new UserDAO();
                int provinceID = Integer.parseInt(provinceDAO.getProvinceID(provinceDraw));
                Province province = new Province(provinceID, provinceDraw);
                String addressID=uDAO.getUserAddressID(id);
                Address address = new Address(Integer.parseInt(addressID), provinceID, addressDraw, province);
            
            User newinfo= new User(Integer.parseInt(id), email, name, phoneNumber, address);
            uDAO.editUser(Integer.parseInt(id), newinfo);
            uDAO.editUserEmail(Integer.parseInt(id), newinfo);
            uDAO.editUserAddress(address, newinfo);
            response.sendRedirect("/AccountController/Profile");
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
