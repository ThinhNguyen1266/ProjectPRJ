<%-- 
    Document   : product
    Created on : Jul 9, 2024, 3:27:08 AM
    Author     : Thinh
--%>

<%@page import="Models.Product"%>
<%@page import="Models.Category"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="DAOs.CategoryDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProductItemDAO"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Display</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!-- Tailwind CSS 2.2.19 -->
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">

        <!-- Bootstrap JS -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <!-- jQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

        <!-- Font Awesome 5.15.4 -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>

        <!-- Google Material Icons -->
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
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }
            .container {
                max-width: 1200px;
                margin: auto;
                padding: 20px;
                background: #fff;
            }
            .img-container {
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
                flex: 1;
            }
            .img-container img {
                max-width: 100%;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .details-container {
                flex: 2;
                padding: 20px;
            }
            .details-container h3 {
                font-size: 28px;
                color: #333;
                margin-bottom: 10px;
            }
            .details-container .price {
                font-size: 24px;
                color: #e60023;
                margin-bottom: 20px;
            }
            .quantity-selector {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }
            .stock-status {
                margin-left: 10px;
                color: #666;
            }
            .actions {
                display: flex;
                gap: 10px;
                margin-top: 20px;
            }
            .add-to-cart, .buy-now {
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                text-transform: uppercase;
                transition: background-color 0.3s ease;
            }
            .add-to-cart:hover, .buy-now:hover {
                background-color: #0056b3;
            }
            .option-group {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-top: 10px;
            }
            .option {
                padding: 8px 12px;
                border: 1px solid #ccc;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .option.selected {
                background-color: #007bff;
                color: #fff;
            }
            .option.disabled {
                background-color: #e9ecef;
                color: #6c757d;
                cursor: not-allowed;
            }
            .option-group label {
                display: block;
                margin-bottom: 5px;
            }
            .breadcrumb-container {
                margin-top: 15px;
                margin-left: 20px;
            }
            .product-card {
                display: flex;
                flex-direction: column;
                justify-content: center;
                height: 100%;
                background-color: #fff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .product-card img {
                width: 90%;
                height: 90%;
                object-fit: contain;
                max-height: 100%;
                margin: auto;
            }
            .product-name {
                height: 2.5em;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }
            .product-details {
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                justify-content: center;
                text-align: center;
                padding: 10px;
            }
            .add-to-cart {
                align-self: center;
                margin-top: 1em;
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
            }
        </style>

        <script>
            $(document).ready(function () {
                var product_ID = $('#product_ID').val();
                $.ajax({
                    url: "/GetProductOptions",
                    type: 'GET',
                    data: {
                        product_ID: product_ID
                    },
                    success: function (response) {
                        Object.keys(response).forEach(function (variation) {
                            var safeVariation = variation.replace(/\s+/g, '-');
                            var group = $('<div class="option-group" id="' + safeVariation + '-group"></div>');
                            group.append('<label for="' + safeVariation + '-group">' + variation + ':</label> ');
                            response[variation].forEach(function (option) {
                                group.append('<div class="option" data-type="' + safeVariation + '" data-value="' + option + '">' + option + '</div>');
                            });
                            $('#variation').append(group);
                        });
                        bindOptionClickEvents();
                    }
                });

            });

            function formatPrice(price) {
                let parts = price.toString().split(".");
                parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                return parts.join(".");
            }

            function bindOptionClickEvents() {
                $('.option').off('click').on('click', function () {
                    var product_ID = $('#product_ID').val();
                    if ($(this).hasClass('disabled'))
                        return;

                    var type = $(this).data('type');
                    var value = $(this).data('value');

                    if ($(this).hasClass('selected')) {
                        $(this).removeClass('selected');
                    } else {
                        $('.option[data-type=' + type + ']').removeClass('selected');
                        $(this).addClass('selected');
                    }
                    var numOfOp = $('.option-group label').length;
                    var selectedOptions = {};
                    $('.option.selected').each(function () {
                        selectedOptions[$(this).data('type')] = $(this).data('value');
                    });
                    $.ajax({
                        url: "/UpdateOptions",
                        type: 'POST',
                        data: {
                            productID: product_ID,
                            selectedOptions: JSON.stringify(selectedOptions),
                            numOfOp: numOfOp
                        },
                        success: function (response) {
                            updateOptions(response)
                            if (response.price !== 0) {
                                let formattedPrice = formatPrice(response.price);
                                $('#price').text(formattedPrice);
                            }
                            if (response.quan !== 0) {
                                $('#quan').text(response.quan + ' in storage')
                            }
                            if (response.id !== "") {
                                $('#cartProductID').attr("value", response.id);
                                $('#orderProductID').attr("value", response.id);
                            }
                        }
                    });
                });
            }

            function updateOptions(response) {
                Object.keys(response).forEach(function (type) {
                    if (type !== "price" && type !== "quan") {
                        var safeType = type.replace(/\s+/g, '-'); // Thay thế khoảng trắng bằng dấu gạch ngang
                        $('.option[data-type=' + safeType + ']').each(function () {
                            var value = $(this).data('value');
                            if (response[type].includes(value)) {
                                $(this).removeClass('disabled');
                            } else {
                                $(this).addClass('disabled');
                            }
                        });
                    }
                });
            }

            function showLoginAlert() {
                alert("Login before order or add to cart");
                location.href = "/AccountController/Login"
            }
        </script>
    </head>
    <body>
        <header class="bg-white shadow-md fixed top-0 left-0 w-full z-50">
            <div class="mx-auto px-4 py-4 flex justify-between items-center">
                <a href="/ProductController/List" class="text-2xl font-bold text-gray-900">ShopName</a>         

                <form method="post" class="search-container">


                    <form method="post" class="search-container" action="/ProductController/Search">

                        <input type="text" name="txtSearchName" placeholder="Search..">
                        <button type="submit" name="btnSearch"><i class="fa fa-search"></i></button>
                    </form>          
                    <div class="flex space-x-4">
                        <a href="/ProductController/About-Contact" class="text-gray-800 hover:text-gray-600"><i class="fas fa-user"></i> About/ <i class="fas fa-envelope"></i> Contact</a>
                        <a href="/CartController" class="text-gray-800 hover:text-gray-600"><i class="fa fa-shopping-cart"></i> Cart</a>
                        <%
                            String customerName = (String) session.getAttribute("customername");
                            if (customerName != null) {
                        %>

                        <div class="relative inline-block text-left">
                            <button onclick="toggleDropdown()" class="text-gray-800 hover:text-gray-600">
                                <i class="fa fa-user-circle-o"></i> <%= customerName%>
                            </button>
                            <div id="dropdownMenu" class="dropdown-menu hidden absolute right-0 mt-2 w-48 bg-white border border-gray-200 rounded-md shadow-lg">
                                <a href="/AccountController/Profile" class="block px-4 py-2 text-gray-800 hover:bg-gray-100"><i class='fas fa-user-alt'></i> Profile</a>
                                <a href="/AccountController/Logout" class="block px-4 py-2 text-gray-800 hover:bg-gray-100"><i class="fa fa-sign-out"></i> Sign Out</a>
                            </div>
                        </div>

                        <% } else { %>
                        <a href="/AccountController/Login" class="text-gray-800 hover:text-gray-600"><i class="fa fa-sign-in"></i> Login</a>
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
        <br><br><br>
        <div class="breadcrumb-container" style="padding: 10px">
            <%
                String id = (String) request.getAttribute("proId");
                CategoryDAO caDAO = new CategoryDAO();
                ProductDAO pDAO = new ProductDAO();
                Category obj;
                obj = caDAO.getCategorByProID(Integer.parseInt(id));
                String pro_name = pDAO.getProductName(id);
            %>
            <nav aria-label="breadcrumb">
                <dev><a href="/ProductController/List">Home</a>/<a href="/ProductController/Category/<%= obj.getCat_id()%>"><%= obj.getCat_name()%></a>/<%= pro_name%></a></dev>
            </nav>
        </div>
        <main class="pt-10">
            <div class="container" style="padding: 10px">
                <%
                    ProductItemDAO pidao = new ProductItemDAO();
                    ResultSet rs = null;
                    if (id != null) {
                        rs = pidao.getProductView(id);
                    } else {
                        request.getRequestDispatcher("/").forward(request, response);
                    }
                    if (rs != null) {
                        String moreprice = rs.getString("price");
                %>
                <script>
                    function formatPrice(price) {
                        let parts = price.toString().split(".");
                        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        return parts.join(".");
                    }

                    document.addEventListener("DOMContentLoaded", function () {
                        let priceElements = document.querySelectorAll('.product-price');
                        priceElements.forEach(function (priceElement) {
                            let priceText = priceElement.innerText.trim();
                            let formattedPrice = formatPrice(priceText);
                            priceElement.innerText = formattedPrice;
                        });
                    });
                </script>

                <div class="flex">
                    <input type="hidden" id="product_ID" value="<%= id%>" />
                    <div class="img-container">
                        <img src="<%= rs.getString("image")%>" alt="Product Image">
                    </div>
                    <div class="details-container">
                        <h3><%= rs.getString("pro_name")%></h3>
                        <div class="des mb-4"><%= rs.getString("description")%></div>

                        <div id="variation">
                            <!-- Add variations here if any -->
                        </div>

                        <div class="price product-price" id="price"><%= moreprice%></div>

                        <div class="quantity-selector flex items-center">
                            <label for="quantity" class="mr-2">Quantity</label>
                            <button type="button" onclick="minusNum1()" class="px-2 py-1 border border-gray-300">-</button>
                            <input type="text" id="firstvalue" value="1" class="w-12 text-center mx-2 border border-gray-300">
                            <button type="button" onclick="addNum1()" class="px-2 py-1 border border-gray-300">+</button>
                            <div class="stock-status ml-4" id="quan"><%= rs.getString("quantity")%> in storage</div>
                        </div>
                        <script>
                            function addNum1() {
                                var newValue = Number(document.getElementById('firstvalue').value);
                                newValue += 1;
                                document.getElementById('firstvalue').value = newValue;
                                document.getElementById('cartQuan').value = newValue;
                                document.getElementById('orderQuan').value = newValue;
                            }

                            function minusNum1() {
                                var subNum = Number(document.getElementById('firstvalue').value);
                                if (subNum > 1) {
                                    subNum -= 1;
                                    document.getElementById('firstvalue').value = subNum;
                                    document.getElementById('cartQuan').value = subNum;
                                    document.getElementById('orderQuan').value = subNum;
                                }
                            }
                        </script>
                        <%
                            if (customerName != null) {
                        %>
                        <div style="display: inline-block; margin-right: 10px;">
                            <form action="/CartController" method="post">
                                <input type="hidden" name="productItemID" id="cartProductID" value="<%= rs.getString("pro_item_id")%>" />
                                <input type="hidden" id="cartQuan" name="quantity" value="1">
                                <input type="hidden" id="userID" name="userID" value="<%= session.getAttribute("customerID")%>">
                                <button type="submit" class="add-to-cart" name="btnAddToCart"><i class="fa fa-shopping-cart"></i>Add to Cart</button>
                            </form>
                        </div>
                        <div style="display: inline-block; margin-right: 10px;">
                            <form action="/OrderController" method="post">
                                <input type="hidden" name="productItemID" id="orderProductID" value="<%= rs.getString("pro_item_id")%>" />
                                <input type="hidden" id="orderQuan" name="quantity" value="1">
                                <input type="hidden" id="orderPrice" name="price" value="<%= rs.getString("price")%>">
                                <button type="submit" class="buy-now" name="BuyNow">Buy Now</button>
                            </form>
                        </div>
                        <% } else { %>
                        <div style="display: inline-block; margin-right: 10px;">
                            <button type="submit" class="add-to-cart" onclick="showLoginAlert()"><i class="fa fa-shopping-cart"></i>Add to Cart</button>
                        </div>
                        <div style="display: inline-block; margin-right: 10px;">
                            <button type="button" class="buy-now" onclick="showLoginAlert()">Buy Now</button>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
            <%
                } else {
                    request.getRequestDispatcher("/").forward(request, response);
                }
            %>
        </main>

        <section class="py-12">
            <div class="container mx-auto px-4">
                <h2 class="text-2xl font-bold text-gray-800 text-center">Recommended Products</h2>
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-8">
                    <%
                        pidao = new ProductItemDAO();
                        rs = pidao.getAllInMenu();
                        List<Map<String, String>> products = new ArrayList<>();
                        while (rs.next()) {
                            Map<String, String> product = new HashMap<>();
                            product.put("pro_id", rs.getString("pro_id"));
                            product.put("image", rs.getString("image"));
                            product.put("pro_name", rs.getString("pro_name"));
                            product.put("price", rs.getString("price"));
                            products.add(product);
                        }

                        Collections.shuffle(products); // Shuffle the list to get random products
                        for (int i = 0; i < 4 && i < products.size(); i++) {
                            Map<String, String> product = products.get(i);
                            String pro_id = product.get("pro_id");
                            String price = product.get("price");
                    %>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden product-card">
                        <a href="/ProductController/View/<%= pro_id%>">
                            <div class="flex justify-center items-center h-48 w-full">
                                <img src="<%= product.get("image")%>" alt="Product Image" class="object-cover">
                            </div>
                        </a>
                        <div class="p-4 product-details">
                            <h3 class="text-lg font-semibold text-gray-800 product-name"><%= product.get("pro_name")%></h3>
                            <p class="text-gray-600 mt-2 product-price"><%= price%>vnd</p>
                        </div>
                        <a href="/ProductController/View/<%= pro_id%>" class="inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600 add-to-cart">View</a>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </section>
        <script>
            function formatPrice(price) {
                let parts = price.toString().split(".");
                parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                return parts.join(".");
            }

            document.addEventListener("DOMContentLoaded", function () {
                let priceElements = document.querySelectorAll('.product-price');
                priceElements.forEach(function (priceElement) {
                    let priceText = priceElement.innerText.trim();
                    let formattedPrice = formatPrice(priceText);
                    priceElement.innerText = formattedPrice;
                });
            });
        </script>

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
