<%-- 
    Document   : Category
    Created on : Jul 1, 2024, 9:30:50 PM
    Author     : AnhNLCE181837
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.CategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Products</title>
        <link
            href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
            rel="stylesheet">
        <style>
            input[type=text] {
                width: 500px;
                box-sizing: border-box;
                border: 2px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
                background-color: white;
                background-image: url('https://www.w3schools.com/howto/searchicon.png');
                background-position: 10px 10px;
                background-repeat: no-repeat;
                padding: 12px 20px 12px 40px;
            }
        </style>
    </head>
    <body class="bg-gray-100">
        <!-- Header -->
        <header class="bg-white shadow-md fixed top-0 left-0 w-full z-50">
            <div class="mx-auto px-4 py-4 flex justify-between items-center">
                <a href="/ProductController/List" class="text-2xl font-bold text-gray-900">ShopName</a>
                <form class="flex-grow mx-2">
                    <input type="text" name="search" placeholder="Search..">
                </form>
                <div class="flex space-x-4">
                    <a href="/ProductController/About-Contact" class="text-gray-800 hover:text-gray-600">About/Contact</a>
                    <a href="/ProductController/Cart" class="text-gray-800 hover:text-gray-600">Cart</a>
                    <%
                        String customerName = (String) session.getAttribute("customername");
                        if (customerName != null) {
                    %>
                    <a href="/AccountController/Profile" class="text-gray-800 hover:text-gray-600">Hello, <%= customerName%></a>
                    <% } else { %>
                    <a href="/AccountController/Login" class="text-gray-800 hover:text-gray-600">Login</a>
                    <% }%>
                </div>
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
        <section class="py-12 mt-16">
    <div class="container mx-auto px-4">
        <h2 class="text-2xl font-bold text-gray-800 text-center">
            <%= session.getAttribute("category") %>
        </h2>
        <div class="flex flex-wrap justify-center gap-6">
            <%
                CategoryDAO dao = new CategoryDAO();
                String name = (String) session.getAttribute("category");
                ResultSet rs = dao.getAllProductCat(name); // Corrected to use category ID
                while (rs.next()) {
            %>
            <div class="bg-white shadow-md rounded-lg overflow-hidden w-64"> <!-- Adjust width as needed -->
                <img src="https://via.placeholder.com/300" alt="Product Image" class="w-full h-48 object-cover">
                <div class="p-4">
                    <h3 class="text-lg font-semibold text-gray-800"><%= rs.getString("name") %></h3>
                    <p class="text-gray-600 mt-2">$10.00</p>
                    <a href="/ProductController/Cart" class="mt-4 inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600">Add to Cart</a>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</section>


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