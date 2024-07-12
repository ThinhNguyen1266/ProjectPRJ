<%@page import="DAOs.ProductItemDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="DAOs.CategoryDAO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shopping Website Group1</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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
            .product-card {
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 16px;
                margin: 16px;
                text-align: center;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease;
            }

            .product-card:hover {
                transform: translateY(-5px);
            }
            .product-card img {
                width: 90%;
                height: 90%;
                object-fit: contain;
                max-height: 100%;
            }
            .product-card .product-name {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 8px;
            }

            .product-card {
                font-size: 25px;
                color: #333;
                margin-bottom: 16px;
            }
            .product-price {
                font-size: 1.5rem; /* Responsive font size */
                color: #444; /* Slightly darker color for better readability */
                margin-bottom: 16px; /* Consistent margin */
                font-weight: bold; /* Bold text for emphasis */
                line-height: 1.4; /* Improved line height for readability */
            }

            @media (max-width: 768px) {
                .product-price {
                    font-size: 1.25rem; /* Adjust font size for smaller screens */
                    margin-bottom: 12px; /* Adjust margin for smaller screens */
                }
            }
            .product-card .view-button {
                background-color: #007bff;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .product-card .view-button:hover {
                background-color: #0056b3;
            }
            .add-to-cart {
                margin-top: 1em;
                font-size: 20px; /* Makes the button text bigger */
                padding: 10px 50px; /* Adjusts padding for a larger button */
                background-color: #007bff; /* Adds a background color (blue in this case) */
                color: #fff; /* Changes the text color to white */
                border: none; /* Removes any default border */
                border-radius: 5px; /* Rounds the corners of the button */
                cursor: pointer; /* Changes the cursor to a pointer on hover */
                text-align: center; /* Centers the text inside the button */
                display: inline-block; /* Ensures the button is displayed inline */
            }

            .product-details {
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                justify-content: center;
                text-align: center;
            }
            .search-form {
                display: flex;
                align-items: center;
                margin: 2rem auto;
                max-width: 600px;
            }
            .search-input {
                flex-grow: 1;
                margin-right: 0.5rem;
            }
            .search-button {
                white-space: nowrap;
            }
            .bg-cover {
                background-size: cover;
                background-position: center;
            }
        </style>
    </head>
    <body class="bg-red-100">
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

        <!-- Hero Banner -->
        <section class="bg-cover bg-center h-96 mt-16" style="background-image: url('https://via.placeholder.com/1920x600');">
            <div class="container mx-auto h-full flex items-center justify-center text-center">
                <div class="bg-white bg-opacity-50 p-8 rounded">
                    <h1 class="text-4xl font-bold text-gray-800">Welcome to ShopName</h1>
                    <p class="mt-4 text-gray-600">Discover the best products at amazing prices.</p>
                    <a href="/Index" class="mt-4 inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600">Shop Now</a>
                </div>
            </div>
        </section>

        <!-- Categories Section -->
        <section class="py-12">
            <div class="container mx-auto px-4">
                <h2 class="text-2xl font-bold text-gray-800 text-center mb-8">Shop by Category</h2>
                <div class="flex flex-wrap justify-center gap-6">
                    <% CategoryDAO dao = new CategoryDAO();
                        ResultSet rs = dao.getAllCategoriesNull();
                        while (rs.next()) { %>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <div class="p-6 text-center">
                            <% if (rs.getString("name").equals("Laptops")) {%>
                            <h3 class="text-lg font-semibold text-gray-800">
                                <a href="/ProductController/Category/<%= rs.getInt("id")%>"><i class='fas fa-laptop'></i> <%= rs.getString("name")%></a>
                            </h3>
                            <% } else if (rs.getString("name").equals("Phones")) {%>
                            <h3 class="text-lg font-semibold text-gray-800">
                                <a href="/ProductController/Category/<%= rs.getInt("id")%>"><i class="material-icons">smartphone</i> <%= rs.getString("name")%></a>
                            </h3>
                            <% } else if (rs.getString("name").equals("Accessories")) {%>
                            <h3 class="text-lg font-semibold text-gray-800">
                                <a href="/ProductController/Category/<%= rs.getInt("id")%>"><i class="fas fa-cogs"></i> <%= rs.getString("name")%></a>
                            </h3>
                            <% } %>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </section>

        <!-- Featured Products Section -->
        <section class="py-12">
            <div class="container mx-auto px-4">
                <h2 class="text-2xl font-bold text-gray-800 text-center">Our Products</h2>
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-8">
                    <% ProductItemDAO pidao = new ProductItemDAO();
                        rs = pidao.getAllInMenu();
                        while (rs.next()) {
                            String price = rs.getString("price"); // Assuming price is fetched from ResultSet rs


                    %>
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

                    <div class="bg-white shadow-md rounded-lg overflow-hidden product-card">
                        <a href="/ProductController/View/<%= rs.getString("pro_id")%>">
                            <div class="flex justify-center items-center h-48 w-full">
                                <img src="<%= rs.getString("image")%>" alt="Product Image" class="object-cover">
                            </div>
                        </a>
                        <div class="p-4 product-details">
                            <h3 class="text-lg font-semibold text-gray-800 product-name"><%= rs.getString("pro_name")%></h3>
                            <p class="product-price text-gray-600 mt-2"><%= price%> vnd</p>
                        </div>
                        <a href="/ProductController/View/<%= rs.getString("pro_id")%>" class="inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600 add-to-cart">View</a>
                    </div>
                    <% }%>
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
