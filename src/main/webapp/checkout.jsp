<%-- 
    Document   : checkout
    Created on : Jul 1, 2024, 9:32:17 PM
    Author     : AnhNLCE181837
--%>

<%@page import="DAOs.CategoryDAO"%>
<%@page import="Models.Province"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProvinceDAO"%>
<%@page import="Models.User"%>
<%@page import="Models.Product_item"%>
<%@page import="DAOs.ProductItemDAO"%>
<%@page import="DAOs.Cart_itemDAO"%>
<%@page import="Models.Cart_item"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="Models.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Checkout</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            .search-container {
                display: flex;
                align-items: center;
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 3px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }
            .search-container input[type="text"] {
                width: 400px;
                padding: 10px;
                border: none;
                outline: none;
                font-size: 16px;
            }
            .search-container button {
                padding: 10px 15px;
                border: none;
                background-color: #f8f8f8;
                cursor: pointer;
                border-left: 1px solid #ccc;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .search-container button:hover {
                background-color: #f0f0f0;
            }
            .search-container button i {
                font-size: 16px;
                color: #333;
            }
            .footer {
                padding: 20px;
                display: flex;
                justify-content: space-between;
                background-color: #2d3748;
                color: white;
            }
            .footer-column {
                flex: 1;
                margin: 0 10px;
            }
            .footer-column h3 {
                font-size: 1.2em;
                margin-bottom: 10px;
            }
            .footer-column ul {
                list-style-type: none;
                padding: 0;
            }
            .footer-column ul li {
                margin-bottom: 5px;
            }
            .footer-column ul li a {
                text-decoration: none;
                color: white;
            }
            .footer-column ul li a:hover {
                text-decoration: underline;
            }
            .payment-methods i {
                font-size: 24px;
                margin-right: 10px;
            }        </style>
    </head>
    <body class="bg-gray-100">
        <!-- Header -->
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
                    <% String customerName = (String) session.getAttribute("customername");
                        if (customerName != null) {%>
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
                    <% } %>
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
        <%
            User obj = (User) session.getAttribute("userinformation");

        %>

        <!-- Checkout Section -->
        <section class="py-12 mt-16">
            <div class="container mx-auto px-4">
                <h2 class="text-2xl font-bold text-gray-800 text-center">Checkout</h2>
                <div class="bg-white shadow-md rounded-lg overflow-hidden mt-8">
                    <div class="px-8 py-4">
                        <h3 class="text-xl font-bold text-gray-800 mb-4">Shipping Information</h3>
                        <form class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="name">Name</label>
                                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="name" type="text" placeholder="Name" name="txtName" value="<%= obj.getName()%>">
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="Phone number">Phone number</label>
                                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="Phone number" type="text" placeholder="Phone number" name="txtPhonenumber" value="<%= obj.getPhoneNumber()%>">
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="Address">Address</label>
                                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="Address" type="Address" placeholder="Address" name="txtAddress" value="<%= obj.getAddress().getAddress()%>">
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2">Province</label>
                                <select name="txtProvince" id="province">
                                    <%
                                        ProvinceDAO provinceDao = new ProvinceDAO();
                                        ResultSet rs = provinceDao.getAll();
                                        Province userProvince = provinceDao.getUserAddress(obj.getName());
                                        while (rs.next()) {
                                            String provinceName = rs.getString("name");
                                            boolean isSelected = userProvince != null && provinceName.equals(userProvince.getProvince_name());
                                    %>
                                    <option value="<%= provinceName%>" <%= isSelected ? "selected" : ""%>><%= provinceName%></option>
                                    <% }%>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="bg-white shadow-md rounded-lg overflow-hidden mt-8">
                    <div class="px-8 py-4">
                        <h3 class="text-xl font-bold text-gray-800 mb-4">Order Summary</h3>
                        <table class="min-w-full leading-normal">
                            <thead>
                                <tr>
                                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Product</th>
                                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Quantity</th>
                                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Price</th>
                                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (session.getAttribute("cartList") != null) {
                                        List<Cart_item> cartList = (List<Cart_item>) session.getAttribute("cartList");
                                        int index = 0;
                                        while (index < cartList.size()) {
                                            Cart_item cart_item;
                                            int id = cartList.get(index).getCart_item_id();
                                            int quantity = cartList.get(index).getQuantity();
                                            index++;
                                            Cart_itemDAO cart_itemDAO = new Cart_itemDAO();
                                            cart_item = cart_itemDAO.getCartItem(String.valueOf(id));
                                            ProductItemDAO piDAO = new ProductItemDAO();
                                            Product_item pItem = cart_item.getProduct_item();
                                %>
                                <tr>
                                    <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                        <div class="flex items-center">
                                            <div class="flex-shrink-0 w-10 h-10">
                                                <img class="w-full h-full rounded-full" src="<%= pItem.getPro_img()%>" alt="Product Image">
                                            </div>
                                            <div class="ml-3">
                                                <p class="text-gray-900 whitespace-no-wrap"><%= pItem.getPro_name()%></p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                        <input type="number" value="<%= cart_item.getQuantity()%>" disabled="" class="w-16 py-2 px-3 border rounded text-gray-700">
                                    </td>
                                    <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                        <p class="text-gray-900 whitespace-no-wrap"><%= pItem.getPrice()%></p>
                                    </td>
                                    <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                        <p class="text-gray-900 whitespace-no-wrap" id="totalPrice"><%= pItem.getPrice()%> VND</p>
                                    </td>
                            <script>
                                document.getElementById('quantity-input').addEventListener('input', updateTotalPrice);

                                function updateTotalPrice() {
                                    var quantity = document.getElementById('quantity-input').value;
                                    var price = parseFloat('<%= pItem.getPrice()%>');
                                    var totalPrice = quantity * price;
                                    document.getElementById('totalPrice').textContent = totalPrice.toFixed(2) + ' VND';
                                }

                                // Initialize the total price on page load
                                updateTotalPrice();
                            </script>
                            </tr>
                            <%
                                    }
                                }%>
                            </tbody>
                        </table>
                        <div class="mt-8 flex justify-end">
                            <a href="/ProductController/PlaceOrder" class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded">Place Orders</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <br><br><br><br><br><br><br><br><br><br>
        <!-- Footer -->
        <footer class="footer">
            <div class="footer-column">
                <h3>Product</h3>
                <ul>
                    <% CategoryDAO dao = new CategoryDAO();
                        rs = dao.getAllCategoriesNull();
                        while (rs.next()) {%>
                    <li><a href="/ProductController/Category/<%= rs.getInt("id")%>"><%= rs.getString("name")%></a></li>
                        <%}%>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Help</h3>
                <ul>
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Shipping</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>About</h3>
                <ul>
                    <li><a href="/ProductController/About-Contact">Contact Us</a></li>
                    <li><a href="/ProductController/About-Contact">About Us</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Payment method</h3>
                <div class="payment-methods">
                    <i class="fab fa-cc-visa"></i>
                    <i class="fab fa-cc-paypal"></i>
                    <i class="fab fa-cc-mastercard"></i>
                    <i class="fab fa-apple-pay"></i>
                </div>
            </div>
        </footer>
    </body>
</html>
