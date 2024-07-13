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
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
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
                        <i class="fas fa-user"></i> About/ <i class="fas fa-envelope"></i> Contact
                    </a>
                    <a href="/ProductController/Cart" class="text-gray-800 hover:text-gray-600">
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
                            <i class="fa fa-user-circle-o"></i> <%= customerName%>
                        </button>
                        <div id="dropdownMenu" class="dropdown-menu hidden absolute right-0 mt-2 w-48 bg-white border border-gray-200 rounded-md shadow-lg">
                            <a href="/AccountController/Profile" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                                <i class='fas fa-user-alt'></i> Profile
                            </a>
                            <a href="/AccountController/Logout" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                                <i class="fa fa-sign-out"></i> Sign Out
                            </a>
                        </div>
                    </div>
                    <% } else { %>
                    <a href="/AccountController/Login" class="text-gray-800 hover:text-gray-600">
                        <i class="fa fa-sign-in"></i> Login
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

        <div class="container">
            <div class="header">
                <h1>User Profile</h1>
            </div>

            <!-- User Information Section -->
            <div class="profile-section">
                
                <div class="section-header">Profile Information</div>
                
                <a class="btn btn-secondary" href="/AccountController/Edit/<%= customerName%>">Edit</a>
                 <a class="btn btn-secondary" href="/AccountController/AddAddress/<%= customerName%>">Edit Address</a>
                <p><strong>Name:<%= (user==null) ? "": user.getName() %></strong> <!-- User Name --></p>
                <p><strong>Email: :<%= (user==null) ? "": user.getEmails() %></strong> <!-- User Email --></p>
                <p><strong>Phone Number: :<%= (user==null) ? "": user.getPhoneNumber()%></strong> <!-- User Phone Number --></p>
                <% 
                    UserDAO dao = new UserDAO();
                    String userID=dao.getUserID(customerName);
                     String address=dao.getUserDefaultAddress(Integer.parseInt(userID));
                %>
                <p><strong>Default Address: <%= address %></strong>
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
