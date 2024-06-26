<%-- 
    Document   : cart
    Created on : Jul 1, 2024, 9:31:43 PM
    Author     : AnhNLCE181837
--%>

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
                                            <p
                                                class="text-gray-900 whitespace-no-wrap">Product
                                                Name</p>
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
                    <a href="/ProductController/Checkout"
                        class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded">Proceed
                        to Checkout</a>
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
