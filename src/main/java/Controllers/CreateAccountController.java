/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.AccountDAO;
import DAOs.CreateAccountDAO;
import DAOs.ProvinceDAO;
import Models.Account;
import Models.Address;
import Models.Province;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author AnhNLCE181837
 */
public class CreateAccountController extends HttpServlet {

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
            out.println("<title>Servlet CreateAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateAccount at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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

        if (request.getParameter("btnSignin") != null) {

            String username = request.getParameter("txtUsername");
            String password = request.getParameter("txtPassword");
            String confirmpassword = request.getParameter("txtConfirmPassword");
            String email = request.getParameter("txtEmail");

            if (password.equals(confirmpassword)) {
                CreateAccountDAO caDAO = new CreateAccountDAO();
                String id = caDAO.getAccountID();
                AccountDAO accDAO = new AccountDAO();
                Account acc = new Account(username, accDAO.getMD5Hash(password), (Integer.parseInt(id) + 1), email);
                String name = request.getParameter("txtName");
                String phoneNumber = request.getParameter("txtPhonenumber");
                String addressDraw = request.getParameter("txtAddress");
                String provinceDraw = request.getParameter("txtProvince");

                String userId = caDAO.getUserID();

                ProvinceDAO provinceDAO = new ProvinceDAO();
                int provinceID = Integer.parseInt(provinceDAO.getProvinceID(provinceDraw));
                Province province = new Province(provinceID, provinceDraw);
                String addressIDDraw = caDAO.getAddressID();
                int addressID = Integer.parseInt(addressIDDraw)+1;

                Address address = new Address(addressID, provinceID, addressDraw, province);

                User user = new User(Integer.parseInt(userId) + 1, name, phoneNumber, address, acc.getUsername(), acc.getPassword(), acc.getAccount_id(), acc.getEmails());
                // Add code to save user or further processing

                int count = caDAO.addNewAccount(acc);
                count = caDAO.addNewUser(user);
                count = caDAO.addNewAddress(address);
                count = caDAO.addNewUserAddress(address, acc);

                response.sendRedirect("/AccountController/Login");
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
