<%@page import="Models.Category"%>
<%@page import="Models.Product"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="DAOs.ProductItemDAO"%>
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
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

            .footer {
                padding: 20px;
                display: flex;
                justify-content: space-between;
                background-color: #2d3748;
                color: white;
                position: relative;
                bottom: 0;
                width: 100%;
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
            }

            .main-content {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            .content {
                flex: 1;
                display: flex;
            }
        </style>
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
                    <a href="/CartController" class="text-gray-800 hover:text-gray-600">
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
        <div class="main-content">
            <div class="content container mx-auto px-4 py-8 mt-20">
                <aside class="fixed inset-y-0 left-0 w-60 bg-gray-800 text-white shadow-lg h-screen">
                    <div class="p-4" style="padding-top: 100px">
                        <h2 class="text-xl font-bold mb-4">Laptop Filters</h2>
                        <form id="filter-form" action="ProductController" method="post">
                            <ul class="space-y-4">
                                <li>
                                    <section class="bg-white shadow-md py-4">
                                        <div class="container mx-auto px-4">
                                            <h3 class="text-lg font-semibold text-black mb-2">Laptop Brands</h3>
                                            <ul class="space-y-2">
                                                <%
                                                    String id = "";
                                                    ResultSet rs = null, subCat = null;
                                                    if (session.getAttribute("resultsetCategory") != null) {
                                                        id = (String) session.getAttribute("resultsetCategory");
                                                    }

                                                    ProductItemDAO pidao = new ProductItemDAO();
                                                    ProductDAO pDAO = new ProductDAO();
                                                    CategoryDAO cDAO = new CategoryDAO();
                                                    Product p = new Product();
                                                    Category cat = cDAO.getCatName(Integer.parseInt(id));
                                                    if (!id.equals("300000") && !id.equals("301000") && !id.equals("302000")) {
                                                        rs = pDAO.getProductBySubCategory(cat.getCat_name(), String.valueOf(cat.getParent()));
                                                        subCat = cDAO.getAllSubCat(String.valueOf(cat.getParent()));
                                                    } else {
                                                        rs = pidao.getAllByCatParent(id);
                                                        subCat = cDAO.getAllSubCat(id);
                                                    }
                                                    session.removeAttribute("resultsetCategory");
                                                    while (subCat.next()) {
                                                %>
                                                <li>
                                                    <div class="flex items-center">
                                                        <input type="radio" name="brand" value="<%= subCat.getString("id")%>" class="mr-2">
                                                        <label class="text-black"><%= subCat.getString("name")%></label>
                                                    </div>
                                                </li>
                                                <% }%>
                                            </ul>
                                            <div class="mt-4">
                                                <input type="submit" value="Sort" name="btnSortProduct" class="btn btn-primary bg-blue-500 text-white px-4 py-2 rounded">
                                                <a href="/ProductController/Category/<%= cat.getParent()%>" class="ml-4 text-blue-500 underline">Show All</a>
                                            </div>
                                        </div>
                                    </section>
                                </li>
                            </ul>
                        </form>
                    </div>
                </aside>
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
                <section class="flex-grow ml-64 pl-8" >
                    <div class="container mx-auto px-4">
                        <h2 class="text-2xl font-bold text-gray-800 text-center">Our Products</h2>
                        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-8">
                            <%                            //}
                                while (rs.next()) {
                                    String price = rs.getString("price");
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

                            <div id="content" class="bg-white shadow-md rounded-lg overflow-hidden product-card">
                                <a href="/ProductController/View/<%= rs.getString("pro_id")%>">
                                    <div class="flex justify-center items-center h-48 w-full">
                                        <img src="<%= rs.getString("image")%>" alt="Product Image" class="object-cover">
                                    </div>
                                </a>
                                <div class="p-4 product-details">
                                    <h3 class="text-lg font-semibold text-gray-800 product-name"><%= rs.getString("pro_name")%></h3>
                                    <p class="product-price text-gray-600 mt-2"><%= price%> vnd</p>
                                </div>
                                <a href="/SortCategoryController/View/<%= rs.getString("pro_id")%>" class="inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600 add-to-cart">View</a>
                            </div>
                            <% }%>
                        </div>
                    </div>
                </section>
            </div>
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
        </div>
    </body>
</html>
