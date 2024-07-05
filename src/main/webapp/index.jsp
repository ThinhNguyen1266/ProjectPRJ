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
        </style>

    </head>
    <body class="bg-gray-100">
        <!-- Header -->
        <header class="bg-white shadow-md fixed top-0 left-0 w-full z-50">
            <div class="mx-auto px-4 py-4 flex justify-between items-center">
                <a href="/ProductController/List" class="text-2xl font-bold text-gray-900">ShopName</a>         
                <form method="post" action="/ProductController/Search">
                    <input type="text" name="txtSearchName" placeholder="Search.." />
                    <button type="submit" name="btnSearch">Search</button>
                </form>           
                <div class="flex space-x-4">
                    <a href="/ProductController/About-Contact" class="text-gray-800 hover:text-gray-600">About/Contact</a>
                    <a href="/ProductController/Cart" class="text-gray-800 hover:text-gray-600">Cart</a>
                    <%
                        String customerName = (String) session.getAttribute("customername");
                        if (customerName != null) {
                    %>
                    <a href="/AccountController/Profile" class="text-gray-800 hover:text-gray-600">Hello: <%= customerName%></a>
                    <a href="/AccountController/Logout" class="btn btn-danger">Sign Out</a>
                    <% } else { %>
                    <a href="/AccountController/Login" class="text-gray-800 hover:text-gray-600">Login</a>
                    <% } %>
                </div>
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
                    <!-- Category Item -->
                    <%
                        CategoryDAO dao = new CategoryDAO();
                        ResultSet rs = dao.getAllCategoriesNull();
                        while (rs.next()) {
                    %>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <div class="p-6 text-center">
                            <h3 class="text-lg font-semibold text-gray-800">
                                <a href="/ProductController/Category/<%=rs.getInt("id")%>"><%=rs.getString("name")%></a>
                            </h3>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </section>

        <!-- Featured Products Section -->
        <section class="py-12">
            <div class="container mx-auto px-4">
                <h2 class="text-2xl font-bold text-gray-800 text-center">Our Products</h2>
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-8">
                    <%
                        ProductDAO pDAO = new ProductDAO();
                        rs = pDAO.getAll();
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
