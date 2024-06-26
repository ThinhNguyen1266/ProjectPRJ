<%-- 
    Document   : checkout
    Created on : Jul 1, 2024, 9:32:17 PM
    Author     : AnhNLCE181837
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Checkout</title>
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

        <!-- Checkout Section -->
        <section class="py-12 mt-16">
            <div class="container mx-auto px-4">
                <h2
                    class="text-2xl font-bold text-gray-800 text-center">Checkout</h2>
                <div class="bg-white shadow-md rounded-lg overflow-hidden mt-8">
                    <div class="px-8 py-4">
                        <h3
                            class="text-xl font-bold text-gray-800 mb-4">Shipping
                            Information</h3>
                        <form class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div class="mb-4">
                                <label
                                    class="block text-gray-700 text-sm font-bold mb-2"
                                    for="first-name">First Name</label>
                                <input
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="first-name" type="text"
                                    placeholder="First Name">
                            </div>
                            <div class="mb-4">
                                <label
                                    class="block text-gray-700 text-sm font-bold mb-2"
                                    for="last-name">Last Name</label>
                                <input
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="last-name" type="text"
                                    placeholder="Last Name">
                            </div>
                            <div class="mb-4">
                                <label
                                    class="block text-gray-700 text-sm font-bold mb-2"
                                    for="address">Address</label>
                                <input
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="address" type="text"
                                    placeholder="Address">
                            </div>
                            <div class="mb-4">
                                <label
                                    class="block text-gray-700 text-sm font-bold mb-2"
                                    for="Province">Province</label>
                                <input
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="Province" type="text"
                                    placeholder="Province">
                            </div>
                            <div class="mb-4">
                                <label
                                    class="block text-gray-700 text-sm font-bold mb-2"
                                    for="phone number">Phone number </label>
                                <input
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="phone number" type="text"
                                    placeholder="phone number">
                            </div>

                        </form>
                    </div>
                </div>
                <div class="bg-white shadow-md rounded-lg overflow-hidden mt-8">
                    <div class="px-8 py-4">
                        <h3 class="text-xl font-bold text-gray-800 mb-4">Order
                            Summary</h3>
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
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td
                                        class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                        <p
                                            class="text-gray-900 whitespace-no-wrap">Product
                                            Name</p>
                                    </td>
                                    <td
                                        class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                        <p
                                            class="text-gray-900 whitespace-no-wrap">1</p>
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
                                </tr>
                                <!-- Repeat for other products -->
                            </tbody>
                        </table>
                        <div class="mt-8 flex justify-end">
                            <button
                                class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded">Place
                                Order</button>
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