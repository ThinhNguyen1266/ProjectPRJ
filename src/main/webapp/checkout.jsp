<%-- 
    Document   : checkout
    Created on : Jul 1, 2024, 9:32:17 PM
    Author     : AnhNLCE181837
--%>

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
        </style>
    </head>
    <body class="bg-gray-100">
        <!-- Header -->
        <header class="bg-white shadow-md fixed top-0 left-0 w-full z-50">
            <div class="mx-auto px-4 py-4 flex justify-between items-center">
                <a href="/ProductController/List" class="text-2xl font-bold text-gray-900">ShopName</a>
                <form method="post" class="search-container">
                    <input type="text" name="txtSearchName" placeholder="Search..">
                    <button type="submit" name="btnSearch"><i class="fa fa-search"></i></button>
                </form>
                <div class="flex space-x-4">
                    <a href="/ProductController/About-Contact" class="text-gray-800 hover:text-gray-600">About/Contact</a>
                    <a href="/ProductController/Cart" class="text-gray-800 hover:text-gray-600">Cart</a>
                    <%
                        String customerName = (String) session.getAttribute("customername");
                        if (customerName != null) {
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
    </header>

    <!-- Checkout Section -->
    <section class="py-12 mt-16">
        <div class="container mx-auto px-4">
            <h2
                class="text-2xl font-bold text-gray-800 text-center">Checkout</h2>
            <div class="bg-white shadow-md rounded-lg overflow-hidden mt-8">
                <div class="px-8 py-4">
                    <h3
                        class="text-xl font-bold text-gray-800 mb-4">Shipping
                        Information</h3>
                    <form class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div class="mb-4">
                            <label
                                class="block text-gray-700 text-sm font-bold mb-2"
                                for="first-name">First Name</label>
                            <input
                                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                id="first-name" type="text"
                                placeholder="First Name">
                        </div>
                        <div class="mb-4">
                            <label
                                class="block text-gray-700 text-sm font-bold mb-2"
                                for="last-name">Last Name</label>
                            <input
                                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                id="last-name" type="text"
                                placeholder="Last Name">
                        </div>
                        <div class="mb-4">
                            <label
                                class="block text-gray-700 text-sm font-bold mb-2"
                                for="address">Address</label>
                            <input
                                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                id="address" type="text"
                                placeholder="Address">
                        </div>
                        <div class="mb-4">
                            <label
                                class="block text-gray-700 text-sm font-bold mb-2"
                                for="Province">Province</label>
                            <input
                                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                id="Province" type="text"
                                placeholder="Province">
                        </div>
                        <div class="mb-4">
                            <label
                                class="block text-gray-700 text-sm font-bold mb-2"
                                for="phone number">Phone number </label>
                            <input
                                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                id="phone number" type="text"
                                placeholder="phone number">
                        </div>

                    </form>
                </div>
            </div>
            <div class="bg-white shadow-md rounded-lg overflow-hidden mt-8">
                <div class="px-8 py-4">
                    <h3 class="text-xl font-bold text-gray-800 mb-4">Order
                        Summary</h3>
                    <table class="min-w-full leading-normal">
                        <thead>
                            <tr>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Product</th>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Quantity</th>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Price</th>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (session.getAttribute("cart") != null) {
                                    List<Product> cart = (List<Product>) session.getAttribute("cart");
                                    int index = 0;
                                    while (index < cart.size()) {
                                        Product p;
                                        int id = cart.get(index).getPro_id();
                                        index++;
                                        ProductDAO pDAO = new ProductDAO();

                                        p = pDAO.getProduct(String.valueOf(id));
                            %>
                            <tr>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0 w-10 h-10">
                                            <img
                                                class="w-full h-full rounded-full"
                                                src="<%= p.getPro_img()%>"
                                                alt="Product Image">
                                        </div>
                                        <div class="ml-3">

                                            <p
                                                class="text-gray-900 whitespace-no-wrap"><%= p.getPro_name()%></p>
                                        </div>
                                    </div>
                                </td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                    <input type="number" value="1"
                                           class="w-16 py-2 px-3 border rounded text-gray-700">
                                </td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                    <p
                                        class="text-gray-900 whitespace-no-wrap">$10.00</p>
                                </td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                    <p
                                        class="text-gray-900 whitespace-no-wrap">$10.00</p>
                                </td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm text-right">
                                    <button
                                        class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">Remove</button>
                                </td>
                            </tr>
                            <%
                                        }
                                    }%>
                            <!-- Repeat for other products -->
                        </tbody>
                    </table>
                    <div class="mt-8 flex justify-end">
                        <button
                            class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded">Place
                            Order</button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-8">
        <div class="container mx-auto px-4 text-center">
            <p>&copy; 2024 ShopName. All rights reserved.</p>
            <div class="mt-4 space-x-4">
                <a href="#" class="hover:text-gray-400">Privacy Policy</a>
                <a href="#" class="hover:text-gray-400">Terms of Service</a>
            </div>
        </div>
    </footer>
</body>
</html>