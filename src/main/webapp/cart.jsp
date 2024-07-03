<%-- 
    Document   : cart
    Created on : Jul 1, 2024, 9:31:43 PM
    Author     : AnhNLCE181837
--%>

<%@page import="Models.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cart</title>
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
                    <select name="profileOptions" id="profileOptions" class="text-gray-800 hover:text-gray-600">
                        <option value="view" id="customerNameOption" selected><%= customerName%></option>
                        <option value="Profile">Profile</option>
                        <option value="logout">Logout</option>
                    </select>

                    <script>
                        document.getElementById('profileOptions').addEventListener('focus', function () {
                            document.getElementById('customerNameOption').style.display = 'none';
                        });
                        document.getElementById('profileOptions').addEventListener('blur', function () {
                            document.getElementById('customerNameOption').style.display = 'block';
                        });
                        const profileOptions = document.getElementById('profileOptions');
                        const customerNameOption = document.getElementById('customerNameOption');

                        profileOptions.addEventListener('change', function () {
                            const selectedValue = profileOptions.value;

                            // Reset the selected value to the customer's name
                            customerNameOption.selected = true;

                            // Perform the desired action based on the selected value
                            if (selectedValue === 'Profile') {
                                // Redirect to edit profile page or perform edit profile action
                                window.location.href = '/AccountController/Profile';
                            } else if (selectedValue === 'logout') {
                                // Perform logout action
                                window.location.href = '/logout';
                            }
                        });
                    </script>
                    <% } else { %>
                    <a href="/AccountController/Login" class="text-gray-800 hover:text-gray-600">Login</a>
                    <% }%>
                </div>
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
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Product</th>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Quantity</th>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Price</th>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Total</th>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0 w-10 h-10">
                                            <img
                                                class="w-full h-full rounded-full"
                                                src="https://via.placeholder.com/150"
                                                alt="Product Image">
                                        </div>
                                        <div class="ml-3">
                                            <%
                                            Product obj = null;
                                            if(session.getAttribute("product")!=null){
                                            obj = (Product) session.getAttribute("product");
                                                }
                                            %>
                                            <p
                                                class="text-gray-900 whitespace-no-wrap"><%= (obj==null)? "Product name" :  obj.getPro_name() %></p>
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
                            <!-- Repeat for other products -->
                        </tbody>
                    </table>
                </div>
                <div class="mt-8 flex justify-end">
                    <%
                        if (obj != null) {
                    %>
                    <a href="/ProductController/List"
                       style="margin-right: 10px"
                       class="bg-blue-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded">Add to cart</a>
                    <%}%>
                    <a href="/ProductController/Checkout"
                       class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded">Proceed
                        to Checkout</a>
                </div>
            </div>
        </section>
        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

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
