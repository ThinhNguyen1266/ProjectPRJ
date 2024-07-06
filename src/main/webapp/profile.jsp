<%-- 
    Document   : profile
    Created on : Jul 3, 2024, 9:27:35 PM
    Author     : AnhNLCE181837
--%>

<%@page import="DAOs.UserDAO"%>
<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>User Profile</title>
        <link
            href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
            rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }
            .container {
                width: 80%;
                margin: auto;
            }
            .header {
                text-align: center;
                padding: 20px;
                background-color: #f4f4f4;
            }
            .profile-section, .order-section, .cart-section {
                margin: 20px 0;
            }
            .section-header {
                font-size: 1.5em;
                margin-bottom: 10px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td {
                border: 1px solid #ddd;
            }
            th, td {
                padding: 8px;
                text-align: left;
            }
        </style>
    </head>
    <body class="bg-ADBBDA-100">
        <header class="bg-white shadow-md fixed top-0 left-0 w-full z-50">
            <div class="mx-auto px-4 py-4 flex justify-between items-center">
                <a href="/ProductController/List" class="text-2xl font-bold text-gray-900">ShopName</a>
                <div class="flex space-x-4">
                    <a href="/ProductController/About-Contact" class="text-gray-800 hover:text-gray-600">About/Contact</a>
                    <a href="/ProductController/Cart" class="text-gray-800 hover:text-gray-600">Cart</a>
                    <%
                        String customerName = (String) session.getAttribute("customername");
                        User user = null;
                        if (customerName != null) {
                            user = new User();
                            UserDAO userDAO = new UserDAO();
                            user = userDAO.getUser(customerName);
                        user = new User();
                        
                        user = userDAO.getUser(customerName);
                    %>
                    <div class="relative inline-block text-left">
                        <button onclick="toggleDropdown()" class="text-gray-800 hover:text-gray-600">
                            <%= customerName%>
                        </button>
                        <div id="dropdownMenu" class="dropdown-menu hidden absolute right-0 mt-2 w-48 bg-white border border-gray-200 rounded-md shadow-lg">
                            <a href="/AccountController/Profile" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">Profile</a>
                            <a href="/AccountController/Logout" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">Sign Out</a>
                        </div>
                    </div>

                    <% } else { %>
                    <a href="/AccountController/Login" class="text-gray-800 hover:text-gray-600">Login</a>
                    <% }%>
                </div>

                <script>
                    function toggleDropdown() {
                        var dropdownMenu = document.getElementById("dropdownMenu");
                        dropdownMenu.classList.toggle("hidden");
                    }

                    // Close the dropdown if the user clicks outside of it
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
        <div class="container">
            <div class="header">
                <h1>User Profile</h1>
            </div>

            <!-- User Information Section -->
            <div class="profile-section">
                
                <div class="section-header">Profile Information</div>
                
                <a class="btn btn-secondary" href="/AccountController/Edit/<%= customerName%>">Edit</a>
                <p><strong>Name:<%= (user==null) ? "": user.getName() %></strong> <!-- User Name --></p>
                <p><strong>Email: :<%= (user==null) ? "": user.getEmails() %></strong> <!-- User Email --></p>
                <p><strong>Phone Number: :<%= (user==null) ? "": user.getPhoneNumber()%></strong> <!-- User Phone Number --></p>
                <p><strong>Default Address: :<%= (user==null) ? "": user.getAddress().getAddress() %></strong>
                    <!-- User Default Address --></p>
            </div>

            <!-- Order Information Section -->
            <div class="order-section">
                <div class="section-header">Recent Orders</div>
                <table>
                    <tr>
                        <th>Order ID</th>
                        <th>Order Date</th>
                        <th>Total Price</th>
                        <th>Shipping Address</th>
                        <th>Status</th>
                    </tr>
                    <!-- Loop through orders -->
                    <tr>
                        <td><!-- Order ID --></td>
                        <td><!-- Order Date --></td>
                        <td><!-- Total Price --></td>
                        <td><!-- Shipping Address --></td>
                        <td><!-- Order Status --></td>
                    </tr>
                    <!-- End loop -->
                </table>
            </div>

            <!-- Cart Information Section -->
            <div class="cart-section">
                <div class="section-header">Cart Items</div>
                <table>
                    <tr>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                    </tr>
                    <!-- Loop through cart items -->
                    <tr>
                        <td><!-- Product Name --></td>
                        <td><!-- Quantity --></td>
                        <td><!-- Price --></td>
                    </tr>
                    <!-- End loop -->
                </table>
            </div>
        </div>
    </body>
</html>
