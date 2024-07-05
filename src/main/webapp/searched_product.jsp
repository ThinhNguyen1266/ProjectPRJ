<%-- 
    Document   : Category
    Created on : Jul 1, 2024, 9:30:50 PM
    Author     : AnhNLCE181837
--%>

<%@page import="DAOs.ProductDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.CategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Products</title>
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
            .product-card .flex {
                height: 200px;
            }
            .product-card img {
                width: 90%;
                height: 90%;
                object-fit: contain; /* Use 'contain' to ensure the image fits within the box without being cropped */
                max-height: 100%;
            }

            .product-card {
                display: flex;
                flex-direction: column;
                justify-content: center; /* Center content vertically */
                height: 100%;
            }

            .product-name {
                height: 2.5em; /* Adjust as needed */
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            .product-details {
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                justify-content: center; /* Center product details vertically */
                text-align: center; /* Center text horizontally */
            }

            .add-to-cart {
                align-self: center; /* Center button horizontally */
                margin-top: 1em; /* Add some margin to separate it from details */
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
        <section class="bg-white shadow-md py-4 mt-16">
            <div class="container mx-auto px-4">
                <div class="flex space-x-4">
                    <div>
                        <select id="sort" name="sort" class="filter-select">
                            <option value="default">Sắp xếp theo</option>
                        </select>
                    </div>
                    <div>
                        <select id="ram" name="ram" class="filter-select">
                            <option value="default">RAM</option>
                        </select>
                    </div>
                    <div>
                        <select id="cpu" name="cpu" class="filter-select">
                            <option value="default">CPU</option>
                        </select>
                    </div>
                    <div>
                        <select id="gpu" name="gpu" class="filter-select">
                            <option value="default">GPU</option>
                        </select>
                    </div>
                    <div>
                        <select id="price" name="price" class="filter-select">
                            <option value="default">Giá</option>
                        </select>
                    </div>
                </div>
            </div>
        </section>

        <style>
            .filter-select {
                padding: 0.5rem 1rem;
                border: 1px solid #ccc;
                border-radius: 4px;
                background-color: white;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                margin-top: 0.5rem;
            }
        </style>
        <!-- Products Section -->

        <section class="py-12">
            <div class="container mx-auto px-4">
                <h2 class="text-2xl font-bold text-gray-800 text-center">Our Products</h2>
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-8">
                    <%
                        ProductDAO dao = new ProductDAO();
                        String name = (String) session.getAttribute("Searchname");
                        ResultSet rs = dao.getAllProductByName(name); // Corrected to use category ID
                        while (rs.next()) {
                    %>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden product-card">
                        <div class="flex justify-center items-center h-48 w-full">
                            <img src="<%= rs.getString("image")%>" alt="Product Image" class="object-cover">
                        </div>
                        <div class="p-4 product-details">
                            <h3 class="text-lg font-semibold text-gray-800 product-name"><%= rs.getString("name")%></h3>
                            <p class="text-gray-600 mt-2">$40.00</p>
                        </div>
                        <a href="/ProductController/Cart/<%= rs.getString("id")%>" class="inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600 add-to-cart">Add to Cart</a>
                    </div>
                    <%
                        }
                    %>
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
