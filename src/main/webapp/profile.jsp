<%-- 
    Document   : profile
    Created on : Jul 3, 2024, 9:27:35 PM
    Author     : AnhNLCE181837
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.OrderDAO"%>
<%@page import="DAOs.UserDAO"%>
<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>User Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <style>
            body {
                background: #f5f5f5;
                margin-top: 20px;
            }
            .card {
                background-clip: padding-box;
                box-shadow: 0 1px 4px rgba(24, 28, 33, 0.1);
            }
            .account-settings-links .list-group-item.active {
                font-weight: bold !important;
                background-color: #e9ecef !important;
            }
            .dropdown-menu {
                right: 0;
                left: auto;
            }
            .profile-section p {
                margin-bottom: 0.5rem;
            }
            .profile-section strong {
                display: block;
                margin-bottom: 0.25rem;
            }
        </style>
    </head>
    <body class="bg-gray-100">
        <header class="bg-white shadow-md fixed top-0 left-0 w-full z-50">
            <div class="mx-auto px-4 py-4 flex justify-between items-center">
                <a href="/ProductController/List" class="text-2xl font-bold text-gray-900">ShopName</a>
                <form method="post" class="search-container" action="/ProductController/Search">
                    <input type="text" name="txtSearchName" placeholder="Search..">
                    <button type="submit" name="btnSearch"><i class="fa fa-search"></i></button>
                </form>
                <div class="flex space-x-4">
                    <a href="/ProductController/About-Contact" class="text-gray-800 hover:text-gray-600">
                        <i class="fas fa-info-circle"></i> About/Contact
                    </a>
                    <a href="/CartController" class="text-gray-800 hover:text-gray-600">
                        <i class="fa fa-shopping-cart"></i> Cart
                    </a>
                    <%
                        String customerName = (String) session.getAttribute("customername");
                        User user = null;
                        if (customerName != null) {
                            UserDAO userDAO = new UserDAO();
                            user = userDAO.getUser(customerName);
                    %>
                    <div class="relative inline-block text-left">
                        <button onclick="toggleDropdown()" class="text-gray-800 hover:text-gray-600">
                            <i class="fa fa-user-circle"></i> <%= customerName%>
                        </button>
                        <div id="dropdownMenu" class="dropdown-menu hidden absolute right-0 mt-2 w-48 bg-white border border-gray-200 rounded-md shadow-lg">
                            <a href="/AccountController/Profile" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                                <i class='fas fa-user-alt'></i> Profile
                            </a>
                            <a href="/AccountController/Logout" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                                <i class="fa fa-sign-out-alt"></i> Sign Out
                            </a>
                        </div>
                    </div>
                    <% } else { %>
                    <a href="/AccountController/Login" class="text-gray-800 hover:text-gray-600">
                        <i class="fa fa-sign-in-alt"></i> Login
                    </a>
                    <% }%>
                </div>
                <script>
                    function toggleDropdown() {
                        var dropdownMenu = document.getElementById("dropdownMenu");
                        dropdownMenu.classList.toggle("hidden");
                    }
                    window.onclick = function (event) {
                        if (!event.target.matches('button')) {
                            var dropdowns = document.getElementsByClassName("dropdown-menu");
                            for (var i = 0; i < dropdowns.length; i++) {
                                var openDropdown = dropdowns[i];
                                if (!openDropdown.classList.contains('hidden')) {
                                    openDropdown.classList.add('hidden');
                                }
                            }
                        }
                    }
                </script>
            </div>
        </header>
        <div class="container mx-auto mt-24">
            <div class="bg-white shadow-lg rounded-lg p-6">
                <h4 class="text-xl font-semibold mb-4">Account settings</h4>
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
                    <div class="col-span-1">
                        <div class="list-group list-group-flush account-settings-links">
                            <a class="list-group-item list-group-item-action active" href="/AccountController/Edit/<%= customerName%>">Profile Edit</a>
                        </div>
                        <div class="list-group list-group-flush account-settings-links">
                            <a class="list-group-item list-group-item-action active" href="/AccountController/AddAddress/<%= customerName%>">Address Setting</a>
                        </div>
                    </div>
                    <div class="col-span-3">
                        <div class="tab-content">
                            <div class="tab-pane fade active show" id="account-general">
                                <hr class="border-light m-0">
                                <div class="profile-section p-4">
                                    <p><strong>Name:<%= (user == null) ? "" : user.getName()%></strong> <!-- User Name --></p>
                                    <p><strong>Email: <%= (user == null) ? "" : user.getEmails()%></strong> <!-- User Email --></p>
                                    <p><strong>Phone Number: <%= (user == null) ? "" : user.getPhoneNumber()%></strong> <!-- User Phone Number --></p>
                                    <%
                                        UserDAO dao = new UserDAO();
                                        String userID = dao.getUserID(customerName);
                                        String address = dao.getUserDefaultAddress(Integer.parseInt(userID));
                                    %>
                                    <p><strong>Default Address: <%= address%></strong>
                                        <!-- User Default Address --></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="flex justify-end mt-4">
                    <a class="btn btn-secondary mr-2" style="padding-right: 20px" href="/AccountController/Edit/<%= customerName%>">Edit</a>
                    <a class="btn btn-default" href="/ProductController/List">Cancel</a>
                </div>
            </div>

            <div id="view-orders" class="bg-white shadow-md rounded-lg overflow-hidden mb-8 p-8">
                <h3 class="text-xl font-bold text-gray-800">View Orders</h3>
                <table class="min-w-full leading-normal mt-4">
                    <thead>
                        <tr>
                            <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">No</th>
                            <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Order Date</th>
                            <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Total</th>
                            <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Status</th>
                        </tr>
                    </thead>
                    <script>
                        function formatPrice(price) {
                            let parts = price.toString().split(".");
                            parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                            return parts.join(".");
                        }

                        document.addEventListener("DOMContentLoaded", function () {
                            // This will run when the page is fully loaded
                            let priceElements = document.querySelectorAll('.product-price');
                            priceElements.forEach(function (priceElement) {
                                let priceText = priceElement.innerText.trim(); // Assuming price is in innerText
                                let formattedPrice = formatPrice(priceText);
                                priceElement.innerText = formattedPrice;
                            });
                        });
                    </script>
                    <tbody>
                        <%
                            OrderDAO oDAO = new OrderDAO();
                            ResultSet orderList = oDAO.getOrderByUser(userID);
                            int no = 1;
                            while (orderList.next()) {
                                String currentStatus = orderList.getString("status");
                                String price = orderList.getString("total_price");
                        %>

                        <tr id="order">
                            <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= no++%></td>
                            <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= orderList.getString("order_date")%></td>
                            <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm product-price"><%= price%></td>
                            <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= currentStatus%></td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function toggleDropdown() {
                var dropdownMenu = document.getElementById("dropdownMenu");
                dropdownMenu.classList.toggle("hidden");
            }
            window.onclick = function (event) {
                if (!event.target.matches('button')) {
                    var dropdowns = document.getElementsByClassName("dropdown-menu");
                    for (var i = 0; i < dropdowns.length; i++) {
                        var openDropdown = dropdowns[i];
                        if (!openDropdown.classList.contains('hidden')) {
                            openDropdown.classList.add('hidden');
                        }
                    }
                }
            }
        </script>
    </body>
</html>
