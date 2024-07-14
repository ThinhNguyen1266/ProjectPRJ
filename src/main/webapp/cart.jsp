<%-- 
    Document   : cart
    Created on : Jul 1, 2024, 9:31:43 PM
    Author     : AnhNLCE181837
--%>

<%@page import="DAOs.CategoryDAO"%>
<%@page import="DAOs.ProductItemDAO"%>
<%@page import="Models.Product_item"%>
<%@page import="java.sql.ResultSet"%>
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
        <title>Cart</title>
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

        <!-- Cart Section -->
        <section class="py-12 mt-16">
            <div class="container mx-auto px-4">
                <h2 class="text-2xl font-bold text-gray-800 text-center">Your
                    Cart</h2>
                <div class="bg-white shadow-md rounded-lg overflow-hidden mt-8">
                    <table class="min-w-full leading-normal">
                        <thead>
                            <tr>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">.</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Product</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Quantity</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Price</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                Cart_itemDAO cidao = new Cart_itemDAO();
                                String userId = (String) session.getAttribute("customerID");
                                ResultSet rs = cidao.getAllCartProductItem(userId);
                                while (rs.next()) {
                            %>
                            <tr>

                                <td>
                                    <input type="checkbox" 
                                           class="form-check-input" 
                                           data-userId="<%=userId%>" 
                                           data-price="<%= rs.getString("price")%>" 
                                           data-id="<%= rs.getString("cart_item_id")%>"
                                           data-pro-item-id ="<%= rs.getString("pro_item_id")%>">
                                </td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0 w-10 h-10">
                                            <img
                                                class="w-full h-full rounded-full"
                                                src="<%= rs.getString("image")%>"
                                                alt="Product Image">
                                        </div>
                                        <div class="ml-3">
                                            <p
                                                class="text-gray-900 whitespace-no-wrap"><%= rs.getString("pro_name")%></p>
                                        </div>
                                    </div>
                                </td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                    <input type="number" value="<%= rs.getString("quantity")%>"
                                           class="w-16 py-2 px-3 border rounded text-gray-700 quantity" >
                                </td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                    <p
                                        class="text-gray-900 whitespace-no-wrap" ><%= rs.getString("price")%></p>
                                </td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm text-right">
                                    <button
                                        class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">Remove</button>
                                </td>
                            </tr>
                            <% }%>
                            <!-- Repeat for other products -->
                        </tbody>
                    </table>
                </div>
                <div class="mt-8 flex justify-end">
                    <h4 class="text-xl font-bold">Total: <span id="totalPrice">0</span></h4>
                    <input type="hidden" value="" name="totalCartPrice" id="totalCartPrice">
                    <button class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded ml-4" 
                            id="proceedToCheckout">Proceed to Checkout</button>
                </div>
            </div>
        </section>
        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>

                    $(document).ready(() => {
                        updateTotalPrice();
                        function updateTotalPrice() {
                            let total = 0;
                            $('input[type="checkbox"]:checked').each(function () {
                                const $checkbox = $(this);
                                const price = parseInt($checkbox.data('price'));
                                const quantity = parseInt($checkbox.closest('tr').find('.quantity').val());
                                total += price * quantity;
                            });
                            $('#totalPrice').text(total);
                            $('#totalCartPrice').val(total);
                        }

                        $('input[type="checkbox"]').on('change', function () {
                            updateTotalPrice();
                        });

                        $('input.quantity').on('change', function () {
                            const tr = $(this).closest('tr');
                            const  id = tr.find(':checkbox').data('id');
                            const quan = $(this).val();
                            $.ajax({
                                url: '/CartController',
                                type: 'POST',
                                data: {
                                    updateQuan: 'updateQuan',
                                    cartItemID: id,
                                    newQuantity: quan
                                },
                                success: function (response) {
                                    console.log("nice");
                                }
                            });
                            updateTotalPrice();
                        });



                        $('#proceedToCheckout').click(function () {
                            let selectedProducts = [];
                            $('input[type="checkbox"]:checked').each(function () {
                                const $checkbox = $(this);
                                const proItemID = $checkbox.data('pro-item-id');
                                const price = parseInt($checkbox.data('price'));
                                const quantity = parseInt($checkbox.closest('tr').find('.quantity').val());
                                selectedProducts.push({ proItemID: proItemID, price: price, quantity: quantity});
                            });
                            const form = $('<form action="/OrderController" method="GET"></form>');
                            form.append($('<input type="hidden" name="selectedProducts" />').val(JSON.stringify(selectedProducts)));
                            $('body').append(form);
                            form.submit();
                        });


                    });


    </script>
</html>
