/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.AccountDAO;
import DAOs.CartDAO;
import DAOs.CreateAccountDAO;
import DAOs.ProvinceDAO;
import DB.mailutil;
import Models.Account;
import Models.Address;
import Models.Cart;
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
import java.net.URLEncoder;
import java.net.URLDecoder;
import java.io.UnsupportedEncodingException;

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
        String path = request.getRequestURI();
        if (path.contains("/CreateAccountController/Verity")) {

            request.getRequestDispatcher("/otp_verity.jsp").forward(request, response);
        } else if (path.contains("/CreateAccountController/Forget")) {

            request.getRequestDispatcher("/email_input.jsp").forward(request, response);
        } else if (path.contains("/CreateAccountController/CreatePWD")) {

            request.getRequestDispatcher("/otp_verityF.jsp").forward(request, response);
        } else if (path.contains("/CreateAccountController/CreateNewPass")) {
            request.getRequestDispatcher("/create_new_pass.jsp").forward(request, response);
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

        if (request.getParameter("bCreateAccountDAtnSignin") != null) {
            AccountDAO accDAO = new AccountDAO();
            CreateAccountDAO caDAO = new CreateAccountDAO();
           
            HttpSession session = request.getSession();
            String username = request.getParameter("txtUsername");
            String password = request.getParameter("txtPassword");
            String confirmpassword = request.getParameter("txtConfirmPassword");
            String email = request.getParameter("txtEmail");
            String name = request.getParameter("txtName");
            String phoneNumber = request.getParameter("txtPhonenumber");
            String addressDraw = request.getParameter("txtAddress");
            String provinceDraw = request.getParameter("txtProvince");
             boolean Emailexist = accDAO.checkEmailExist(email);
            // Set all form values to request attributes
            request.setAttribute("txtUsername", username);
            request.setAttribute("txtEmail", email);
            request.setAttribute("txtName", name);
            request.setAttribute("txtPhonenumber", phoneNumber);
            request.setAttribute("txtAddress", addressDraw);
            request.setAttribute("txtProvince", provinceDraw);
          
            if (!caDAO.checkUsername(username)) {
                request.setAttribute("UsernameError", "Username has already existed");
                request.getRequestDispatcher("/create-account.jsp").forward(request, response);
            } else if (!password.equals(confirmpassword)) {
                request.setAttribute("PasswordError", "Passwords do not match");
                request.getRequestDispatcher("/create-account.jsp").forward(request, response);
            } else if (Emailexist==true) {
                request.setAttribute("EmailError", "Email has already existed");
                request.getRequestDispatcher("/create-account.jsp").forward(request, response);
            } else {
                // Proceed with account creation

                String encodedUsername = URLEncoder.encode(username, "UTF-8");
                String encodedPassword = URLEncoder.encode(password, "UTF-8");
                String encodedEmail = URLEncoder.encode(email, "UTF-8");
                String encodedName = URLEncoder.encode(name, "UTF-8");
                String encodedPhoneNumber = URLEncoder.encode(phoneNumber, "UTF-8");
                String encodedAddressDraw = URLEncoder.encode(addressDraw, "UTF-8");
                String encodedProvinceDraw = URLEncoder.encode(provinceDraw, "UTF-8");
                String otp = caDAO.generateRandomString();
                String cookieValue = encodedUsername + ":" + encodedPassword + ":" + encodedEmail + ":" + encodedName + ":" + encodedPhoneNumber + ":" + encodedAddressDraw + ":" + encodedProvinceDraw;
                Cookie userloginCookie = new Cookie("RegisterName", cookieValue);
                Cookie OtpCook = new Cookie("OTP", otp);
                userloginCookie.setMaxAge(60 * 3); // 3 days
                userloginCookie.setPath("/");
                response.addCookie(userloginCookie);
                OtpCook.setMaxAge(60 * 3); // 3 days
                OtpCook.setPath("/");
                response.addCookie(OtpCook);
                mailutil.sendVerificationEmail(email, otp);

                response.sendRedirect("/CreateAccountController/Verity");
            }
        }
        if (request.getParameter("btnSend") != null) {
            HttpSession session = request.getSession();
            String inputOtp = request.getParameter("txtOtp");
            Cookie[] cookies = request.getCookies();
            String accountInfo = null;
            String CorrectOTP = null;
            CreateAccountDAO caDAO = new CreateAccountDAO();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("OTP")) {
                        CorrectOTP = cookie.getValue();
                        break;
                    }
                }
            }
            if (CorrectOTP.equals(inputOtp)) {
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("RegisterName")) {
                            accountInfo = cookie.getValue();
                            break;
                        }
                    }
                    if (accountInfo != null) {
                        try {
                            String[] userInfo = accountInfo.split(":");

                            String username = URLDecoder.decode(userInfo[0], "UTF-8");
                            String password = URLDecoder.decode(userInfo[1], "UTF-8");
                            String email = URLDecoder.decode(userInfo[2], "UTF-8");
                            String name = URLDecoder.decode(userInfo[3], "UTF-8");
                            String phoneNumber = URLDecoder.decode(userInfo[4], "UTF-8");
                            String addressDraw = URLDecoder.decode(userInfo[5], "UTF-8");
                            String provinceDraw = URLDecoder.decode(userInfo[6], "UTF-8");

                            String id = caDAO.getAccountID();
                            AccountDAO accDAO = new AccountDAO();
                            Account acc = new Account(username, accDAO.getMD5Hash(password), (Integer.parseInt(id) + 1), email);
                            String userId = caDAO.getUserID();
                            ProvinceDAO provinceDAO = new ProvinceDAO();
                            int provinceID = Integer.parseInt(provinceDAO.getProvinceID(provinceDraw));
                            Province province = new Province(provinceID, provinceDraw);
                            String addressIDDraw = caDAO.getAddressID();
                            int addressID = Integer.parseInt(addressIDDraw) + 1;
                            Address address = new Address(addressID, provinceID, addressDraw, province);
                            User user = new User(Integer.parseInt(userId) + 1, name, phoneNumber, address, acc.getUsername(), acc.getPassword(), acc.getAccount_id(), acc.getEmails());

                            int count = caDAO.addNewAccount(acc);
                            count = caDAO.addNewUser(user);
                            count = caDAO.addNewAddress(address);
                            count = caDAO.addNewUserAddress(address, acc);
                            CartDAO cartDAO = new CartDAO();

                            String cartID = cartDAO.getCartID();

                            Cart cart = new Cart((Integer.parseInt(cartID) + 1), user);

                            cartDAO.addNewCart(cart);

                            if (cookies != null) {
                                for (Cookie cookie : cookies) {
                                    if (cookie.getName().equals("RegisterName")) {
                                        cookie.setValue(null);
                                        cookie.setMaxAge(0);
                                        cookie.setPath("/");
                                        response.addCookie(cookie);
                                    }
                                }
                                for (Cookie cookie : cookies) {
                                    if (cookie.getName().equals("OTP")) {
                                        cookie.setValue(null);
                                        cookie.setMaxAge(0);
                                        cookie.setPath("/");
                                        response.addCookie(cookie);
                                    }
                                }
                            }

                        } catch (UnsupportedEncodingException e) {
                            e.printStackTrace();
                        }
                    }
                    response.sendRedirect("/ProductController/List");
                }
            } else {
                response.sendRedirect("/AccountController/Login");
            }

        }//Check Email and send otp
        if (request.getParameter("btnSendF") != null) {
            String inputEmail = request.getParameter("txtEmail");
            AccountDAO accDAO = new AccountDAO();
            CreateAccountDAO caDAO = new CreateAccountDAO();
            boolean Emailexist = accDAO.checkEmailExist(inputEmail);
            if (Emailexist == true) {
                String otp = caDAO.generateRandomString();
                Cookie OtpCook = new Cookie("OTP", otp);
                Cookie Email = new Cookie("FEmail", inputEmail);
                OtpCook.setMaxAge(60 * 3); // 3 days
                OtpCook.setPath("/");
                response.addCookie(OtpCook);
                Email.setMaxAge(60 * 60 * 3); // 3 days
                Email.setPath("/");
                response.addCookie(Email);
                mailutil.sendVerificationEmailForget(inputEmail, otp);

                response.sendRedirect("/CreateAccountController/CreatePWD");
            } else {
                response.sendRedirect("/CreateAccountController/Forget");
            }

        }//Check otp for Email
        if (request.getParameter("btnSendOTP") != null) {

            String inputOtp = request.getParameter("txtOtp");
            Cookie[] cookies = request.getCookies();

            String CorrectOTP = null;
            CreateAccountDAO caDAO = new CreateAccountDAO();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("OTP")) {
                        CorrectOTP = cookie.getValue();
                        break;
                    }
                }
            }
            if (inputOtp.equals(CorrectOTP)) {
                if (cookies != null) {

                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("OTP")) {
                            cookie.setValue(null);
                            cookie.setMaxAge(0);
                            cookie.setPath("/");
                            response.addCookie(cookie);
                            break;
                        }
                    }
                }
                response.sendRedirect("/CreateAccountController/CreateNewPass");
            } else {
                response.sendRedirect("/CreateAccountController/CreatePWD");
            }
        }//Create new Password
        if (request.getParameter("btnSendP") != null) {
            String password = request.getParameter("txtPassword");
            String confirmpassword = request.getParameter("txtConfirmPassword");
            Cookie[] cookies = request.getCookies();
            if (password.equals(confirmpassword)) {
                String email = null;
                AccountDAO accDAO = new AccountDAO();
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("FEmail")) {
                            email = cookie.getValue();
                            break;
                        }
                    }
                }
                int count = accDAO.CreateNewPass(password, email);
                if (count != 0) {

                    if (cookies != null) {

                        for (Cookie cookie : cookies) {
                            if (cookie.getName().equals("FEmail")) {
                                cookie.setValue(null);
                                cookie.setMaxAge(0);
                                cookie.setPath("/");
                                response.addCookie(cookie);
                                break;
                            }
                        }
                    }

                    response.sendRedirect("/AccountController/Login");
                } else {
                    response.sendRedirect("/CreateAccountController/CreateNewPass");
                }
            } else {
                response.sendRedirect("/CreateAccountController/CreateNewPass");
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
