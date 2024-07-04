<%-- 
    Document   : about-contact
    Created on : Jul 1, 2024, 9:31:20 PM
    Author     : AnhNLCE181837
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>About & Contact</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <style>
            #search_bar input[type=text] {
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
                <form method="post">
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

        <!-- About Section -->
        <section class="py-12 mt-16">
            <div class="container mx-auto px-4">
                <h2 class="text-2xl font-bold text-gray-800 text-center">About Us</h2>
                <p class="mt-4 text-gray-600 text-center">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent vel tortor facilisis, efficitur purus vitae, scelerisque lorem.</p>
                <div class="mt-8">
                    <img src="https://via.placeholder.com/800x400" alt="About Image" class="w-full h-64 object-cover rounded-lg shadow-md">
                </div>
            </div>
        </section>

        <!-- Contact Section -->
        <section class="py-12 bg-gray-100">
            <div class="container mx-auto px-4">
                <h2 class="text-2xl font-bold text-gray-800 text-center">Contact Us</h2>
                <form class="bg-white shadow-md rounded-lg p-8 mt-8 max-w-md mx-auto">
                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="name">Name</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="name" type="text" placeholder="Name">
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="email">Email</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="email" type="email" placeholder="Email">
                    </div>
                    <div class="mb-6">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="message">Message</label>
                        <textarea class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="message" rows="4" placeholder="Message"></textarea>
                    </div>
                    <div class="flex items-center justify-between">
                        <button class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="button">Send Message</button>
                    </div>
                </form>
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
