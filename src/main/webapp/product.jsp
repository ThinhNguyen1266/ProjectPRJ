<%-- 
    Document   : product
    Created on : Jul 9, 2024, 3:27:08 AM
    Author     : Thinh
--%>

<%@page import="DAOs.ProductDAO"%>
<%@page import="Models.Category"%>
<%@page import="DAOs.CategoryDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProductItemDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Display</title>
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link
            href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
            rel="stylesheet">
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script
        src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <style>
            /* Existing styles */
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }
            .container {
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
                padding-top: 0;
                margin-top: 0;
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
            .details-container .quantity-selector {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }
            .details-container .stock-status {
                margin-left: 10px;
                color: #666;
            }
            .details-container .actions {
                display: flex;
                gap: 10px;
                margin-top: 20px; /* Add margin to separate from quantity selector */
            }
            .add-to-cart {
                display: flex;
                align-items: center;
                padding: 8px 12px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .option-group {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-top: 10px; /* Adjust margin to separate from other elements */
            }
            .option {
                padding: 8px 12px; /* Adjust padding for better spacing */
                border: 1px solid #ccc;
                border-radius: 5px;
                cursor: pointer;
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
                            var safeVariation = variation.replace(/\s+/g, '-'); // Thay thế khoảng trắng bằng dấu gạch ngang
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
                                $('#price').text(  response.price);
                            }
                            if (response.quan !== 0) {
                                $('#quan').text(response.quan + ' in storage')

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
        </script>
    </head>
    <body>
        <header class="bg-white shadow-md fixed top-0 left-0 w-full z-50">
            <div class="mx-auto px-4 py-4 flex justify-between items-center">
                <a href="/ProductController/List"
                   class="text-2xl font-bold text-gray-900">ShopName</a>

                <form method="post" class="search-container">
                    <input type="text" name="txtSearchName" placeholder="Search..">
                    <button type="submit" name="btnSearch"><i class="fa fa-search"></i></button>
                </form> 
                    <div class="flex space-x-4">
                        <a href="/ProductController/About-Contact"
                           class="text-gray-800 hover:text-gray-600">About/Contact</a>
                        <a href="/ProductController/Cart"
                           class="text-gray-800 hover:text-gray-600"><i
                                class='fas fa-shopping-cart'></i></a>
                            <%
                                String customerName = (String) session.getAttribute("customername");
                                if (customerName != null) {
                            %>

                        <div class="relative inline-block text-left">
                            <button onclick="toggleDropdown()"
                                    class="text-gray-800 hover:text-gray-600">
                                <i class='far fa-user-circle'></i> <%=customerName%>
                            </button>
                            <div id="dropdownMenu"
                                 class="dropdown-menu hidden absolute right-0 mt-2 w-48 bg-white border border-gray-200 rounded-md shadow-lg">
                                <a href="/AccountController/Profile"
                                   class="block px-4 py-2 text-gray-800 hover:bg-gray-100">Profile</a>
                                <a href="/AccountController/Logout"
                                   class="block px-4 py-2 text-gray-800 hover:bg-gray-100">Sign
                                    Out</a>
                            </div>
                        </div>

                        <% } else { %>
                        <a href="/AccountController/Login"
                           class="text-gray-800 hover:text-gray-600"><i
                                class='far fa-question-circle'></i> Login</a>
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
        <% 
         String id = (String) request.getAttribute("proId");
         CategoryDAO caDAO= new CategoryDAO();
         ProductDAO pDAO= new ProductDAO();
         Category obj;
         obj=caDAO.getCategorByProID(Integer.parseInt(id));
         String pro_name=pDAO.getProductName(id);
        %>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/ProductController/List">Home</a></li>
                <li class="breadcrumb-item"><a href="/ProductController/Category/<%= obj.getCat_id()%>"><%= obj.getCat_name()%></a></li>
                <li class="breadcrumb-item active" aria-current="page"><%= pro_name%></li>
            </ol>
        </nav>
        <%

            ProductItemDAO pidao = new ProductItemDAO();
           
            System.out.println(id);
            ResultSet rs = null;
            if (id != null) {
                rs = pidao.getProductView(id);
            } else {
                request.getRequestDispatcher("/").forward(request, response);
            }
            if (rs != null) {
        %>
        <div class="container">
            <div class="flex">
                <input type="hidden" id="product_ID" value="<%=id%>"/>
                <div class="img-container">
                    <img src="<%= rs.getString("image")%>"
                         alt="Product Image">
                </div>
                <div class="details-container h-96 mt-20">
                    <h3><%= rs.getString("pro_name")%></h3>
                    <div class="des"><%= rs.getString("description")%> </div>

                    <div id="variation">

                    </div>

                    <div class="price" id="price"><%= rs.getString("price")%></div>

                    <div class="quantity-selector flex items-center">
                        <label for="quantity" class="mr-2">Quantity</label>
                        <button type="button" onclick="minusNum1()"
                                class="px-2 py-1 border border-gray-300">-</button>
                        <input type="text" id="firstvalue" value="1"
                               class="w-12 text-center mx-2 border border-gray-300">
                        <button type="button" onclick="addNum1()"
                                class="px-2 py-1 border border-gray-300">+</button>
                        <div class="stock-status ml-4" id="quan"><%= rs.getString("quantity")%> in storage</div>
                    </div>
                    <script>
                        function addNum1() {
                            var newValue = Number(document.getElementById('firstvalue').value);
                            newValue += 1;
                            document.getElementById('firstvalue').value = newValue;
                        }

                        function minusNum1() {
                            var subNum = Number(document.getElementById('firstvalue').value);
                            if (subNum > 1) {
                                subNum -= 1;
                                document.getElementById('firstvalue').value = subNum;
                            }
                        }
                    </script>
                    <div class="actions">
                        <button type="button" class="add-to-cart">
                            <i class="fa fa-shopping-cart"></i>
                            Add to Cart
                        </button>

                        <button type="button" class="buy-now">Buy Now</button>
                    </div>
                </div>
            </div>
        </div>
        <%
            } else {
                request.getRequestDispatcher("/").forward(request, response);
            }
        %>
        <footer class="bg-gray-800 text-black py-8">
            <div class="container mx-auto px-4 text-center">
                <p>&copy; 2024 ShopName. All rights reserved.</p>
                <div class="mt-4 space-x-4">
                    <a href="#" class="hover:text-gray-400">Privacy
                        Policy</a>
                    <a href="#" class="hover:text-gray-400">Terms of
                        Service</a>
                </div>
            </div>
        </footer>
    </body>

</html>
