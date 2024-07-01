<%-- 
    Document   : Category
    Created on : Jul 1, 2024, 9:30:50 PM
    Author     : AnhNLCE181837
--%>

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
    </head>
    <body class="bg-gray-100">
        <!-- Header -->
        <header class="bg-white shadow-md fixed top-0 left-0 w-full z-40">
            <div class="mx-auto px-4 py-4 flex justify-between items-center">
                <a href="/ProductController/List"
                    class="text-xl font-bold text-gray-800">ShopName</a>
                <div class="flex space-x-4">
                    <a href="/ProductController/List"
                        class="text-gray-800 hover:text-gray-600">Home</a>
                    <a href="/ProductController/About-Contact"
                        class="text-gray-800 hover:text-gray-600">About/Contact</a>
                    <a href="/ProductController/Cart"
                        class="text-gray-800 hover:text-gray-600">Cart</a>
                    <a href="/AccountController/Login"
                        class="text-gray-800 hover:text-gray-600">Login</a>
                </div>
            </div>
        </header>

        <!-- Products Section -->
        <section class="py-12 mt-16">
            <div class="container mx-auto px-4">
                <h2
                    class="text-2xl font-bold text-gray-800 text-center">Category
                    Name</h2>
                <div
                    class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-8">
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <img src="https://via.placeholder.com/300"
                            alt="Product Image"
                            class="w-full h-48 object-cover">
                        <div class="p-4">
                            <h3
                                class="text-lg font-semibold text-gray-800">Product
                                1</h3>
                            <p class="text-gray-600 mt-2">$10.00</p>
                            <a href="/ProductController/Cart"
                                class="mt-4 inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600">Add
                                to Cart</a>
                        </div>
                    </div>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <img src="https://via.placeholder.com/300"
                            alt="Product Image"
                            class="w-full h-48 object-cover">
                        <div class="p-4">
                            <h3
                                class="text-lg font-semibold text-gray-800">Product
                                2</h3>
                            <p class="text-gray-600 mt-2">$20.00</p>
                            <a href="/ProductController/Cart"
                                class="mt-4 inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600">Add
                                to Cart</a>
                        </div>
                    </div>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <img src="https://via.placeholder.com/300"
                            alt="Product Image"
                            class="w-full h-48 object-cover">
                        <div class="p-4">
                            <h3
                                class="text-lg font-semibold text-gray-800">Product
                                3</h3>
                            <p class="text-gray-600 mt-2">$30.00</p>
                            <a href="/ProductController/Cart"
                                class="mt-4 inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600">Add
                                to Cart</a>
                        </div>
                    </div>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <img src="https://via.placeholder.com/300"
                            alt="Product Image"
                            class="w-full h-48 object-cover">
                        <div class="p-4">
                            <h3
                                class="text-lg font-semibold text-gray-800">Product
                                4</h3>
                            <p class="text-gray-600 mt-2">$40.00</p>
                            <a href="/ProductController/Cart"
                                class="mt-4 inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600">Add
                                to Cart</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="py-12">
            <div class="container mx-auto px-4">
                <div
                    class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-8">
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <img src="https://via.placeholder.com/300"
                            alt="Product Image"
                            class="w-full h-48 object-cover">
                        <div class="p-4">
                            <h3
                                class="text-lg font-semibold text-gray-800">Product
                                5</h3>
                            <p class="text-gray-600 mt-2">$50.00</p>
                            <a href="/ProductController/Cart"
                                class="mt-4 inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600">Add
                                to Cart</a>
                        </div>
                    </div>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <img src="https://via.placeholder.com/300"
                            alt="Product Image"
                            class="w-full h-48 object-cover">
                        <div class="p-4">
                            <h3
                                class="text-lg font-semibold text-gray-800">Product
                                6</h3>
                            <p class="text-gray-600 mt-2">$60.00</p>
                            <a href="/ProductController/Cart"
                                class="mt-4 inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600">Add
                                to Cart</a>
                        </div>
                    </div>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <img src="https://via.placeholder.com/300"
                            alt="Product Image"
                            class="w-full h-48 object-cover">
                        <div class="p-4">
                            <h3
                                class="text-lg font-semibold text-gray-800">Product
                                7</h3>
                            <p class="text-gray-600 mt-2">$70.00</p>
                            <a href="/ProductController/Cart"
                                class="mt-4 inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600">Add
                                to Cart</a>
                        </div>
                    </div>
                    <div class="bg-white shadow-md rounded-lg overflow-hidden">
                        <img src="https://via.placeholder.com/300"
                            alt="Product Image"
                            class="w-full h-48 object-cover">
                        <div class="p-4">
                            <h3
                                class="text-lg font-semibold text-gray-800">Product
                                8</h3>
                            <p class="text-gray-600 mt-2">$80.00</p>
                            <a href="/ProductController/Cart"
                                class="mt-4 inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600">Add
                                to Cart</a>
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