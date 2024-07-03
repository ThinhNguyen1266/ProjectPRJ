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
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <div class="p-6 text-center">
                            <h3 class="text-lg font-semibold text-gray-800">
                                <a href="/ProductController/Category">Category Name</a>
                            </h3>
                        </div>
                    </div>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <div class="p-6 text-center">
                            <h3 class="text-lg font-semibold text-gray-800">
                                <a href="/ProductController/Category">Category Name</a>
                            </h3>
                        </div>
                    </div>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <div class="p-6 text-center">
                            <h3 class="text-lg font-semibold text-gray-800">
                                <a href="/ProductController/Category">Category Name</a>
                            </h3>
                        </div>
                    </div>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <div class="p-6 text-center">
                            <h3 class="text-lg font-semibold text-gray-800">
                                <a href="/ProductController/Category">Category Name</a>
                            </h3>
                        </div>
                    </div>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <div class="p-6 text-center">
                            <h3 class="text-lg font-semibold text-gray-800">
                                <a href="/ProductController/Category">Category Name</a>
                            </h3>
                        </div>
                    </div>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <div class="p-6 text-center">
                            <h3 class="text-lg font-semibold text-gray-800">
                                <a href="/ProductController/Category">Category Name</a>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Featured Products Section -->
        <section class="py-12">
            <div class="container mx-auto px-4">
                <h2 class="text-2xl font-bold text-gray-800 text-center">Our Products</h2>
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-8">
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <img src="https://via.placeholder.com/300" alt="Product Image" class="w-full h-48 object-cover">
                        <div class="p-4">
                            <h3 class="text-lg font-semibold text-gray-800">Product 1</h3>
                            <p class="text-gray-600 mt-2">$10.00</p>
                            <a href="/ProductController/Cart" class="mt-4 inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600">Add to Cart</a>
                        </div>
                    </div>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <img src="https://via.placeholder.com/300" alt="Product Image" class="w-full h-48 object-cover">
                        <div class="p-4">
                            <h3 class="text-lg font-semibold text-gray-800">Product 2</h3>
                            <p class="text-gray-600 mt-2">$20.00</p>
                            <a href="/ProductController/Cart" class="mt-4 inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600">Add to Cart</a>
                        </div>
                    </div>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <img src="https://via.placeholder.com/300" alt="Product Image" class="w-full h-48 object-cover">
                        <div class="p-4">
                            <h3 class="text-lg font-semibold text-gray-800">Product 3</h3>
                            <p class="text-gray-600 mt-2">$30.00</p>
                            <a href="/ProductController/Cart" class="mt-4 inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600">Add to Cart</a>
                        </div>
                    </div>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <img src="https://via.placeholder.com/300" alt="Product Image" class="w-full h-48 object-cover">
                        <div class="p-4">
                            <h3 class="text-lg font-semibold text-gray-800">Product 4</h3>
                            <p class="text-gray-600 mt-2">$40.00</p>
                            <a href="/ProductController/Cart" class="mt-4 inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600">Add to Cart</a>
                        </div>
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
