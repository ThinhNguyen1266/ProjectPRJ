<%-- 
    Document   : admin
    Created on : Jul 1, 2024, 9:48:25 PM
    Author     : AnhNLCE181837
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Page</title>
        <link
            href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
            rel="stylesheet">
        <style>
        .hidden {
            display: none;
        }
    </style>
    </head>
    <body class="bg-gray-100">
        <!-- Header -->
        <header class="bg-white shadow-md fixed top-0 left-0 w-full z-50">
            <div class="mx-auto px-4 py-4 flex justify-between items-center">
                <a href="index.html"
                    class="text-xl font-bold text-gray-800">ShopName</a>
                <div class="flex space-x-4">
                    <a href="index.html"
                        class="text-gray-800 hover:text-gray-600">Home</a>
                    <a href="about-contact.html"
                        class="text-gray-800 hover:text-gray-600">About/Contact</a>
                    <a href="cart.html"
                        class="text-gray-800 hover:text-gray-600">Cart</a>
                    <a href="login.html"
                        class="text-gray-800 hover:text-gray-600">Login</a>
                </div>
            </div>
        </header>

        <div class="container mx-auto px-4 py-8 flex mt-16">
            <!-- Sidebar -->
            <aside class="w-1/4 bg-white shadow-md rounded-lg p-4">
                <h2 class="text-xl font-bold text-gray-800 mb-4">Admin
                    Abilities</h2>
                <ul class="space-y-2">
                    <li><a id="link-add-product" href="javascript:void(0)"
                            class="text-gray-800 hover:text-gray-600">Add New
                            Product</a></li>
                    <li><a id="link-manage-products" href="javascript:void(0)"
                            class="text-gray-800 hover:text-gray-600">Manage
                            Products</a></li>
                    <li><a id="link-view-orders" href="javascript:void(0)"
                            class="text-gray-800 hover:text-gray-600">View
                            Orders</a></li>
                    <li><a id="link-manage-users" href="javascript:void(0)"
                            class="text-gray-800 hover:text-gray-600">Manage
                            Users</a></li>
                    <li><a id="link-settings" href="javascript:void(0)"
                            class="text-gray-800 hover:text-gray-600">Settings</a></li>
                </ul>
            </aside>

            <!-- Main Content -->
            <section class="w-3/4 pl-8">
                <div id="add-product"
                    class="bg-white shadow-md rounded-lg overflow-hidden mb-8 p-8 hidden">
                    <h3 class="text-xl font-bold text-gray-800">Add New
                        Product</h3>
                    <form class="mt-4">
                        <label
                            class="block text-gray-700 text-sm font-bold mb-2"
                            for="product-name">Product Name</label>
                        <input
                            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3"
                            id="product-name" type="text"
                            placeholder="Product Name">
                        <label
                            class="block text-gray-700 text-sm font-bold mb-2"
                            for="product-description">Product
                            Description</label>
                        <textarea
                            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3"
                            id="product-description"
                            placeholder="Product Description"></textarea>
                        <label
                            class="block text-gray-700 text-sm font-bold mb-2"
                            for="product-price">Product Price</label>
                        <input
                            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3"
                            id="product-price" type="text"
                            placeholder="Product Price">
                        <button
                            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
                            type="button">Add Product</button>
                    </form>
                </div>
                <div id="manage-products"
                    class="bg-white shadow-md rounded-lg overflow-hidden mb-8 p-8 hidden">
                    <h3 class="text-xl font-bold text-gray-800">Manage
                        Products</h3>
                    <table class="min-w-full leading-normal mt-4">
                        <thead>
                            <tr>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Product
                                    Name</th>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Price</th>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">Product
                                    1</td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">$10.00</td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                    <button
                                        class="bg-yellow-500 hover:bg-yellow-700 text-white font-bold py-1 px-2 rounded">Edit</button>
                                    <button
                                        class="bg-red-500 hover:bg-red-700 text-white font-bold py-1 px-2 rounded">Delete</button>
                                </td>
                            </tr>
                            <!-- More rows as needed -->
                        </tbody>
                    </table>
                </div>
                <div id="view-orders"
                    class="bg-white shadow-md rounded-lg overflow-hidden mb-8 p-8 hidden">
                    <h3 class="text-xl font-bold text-gray-800">View Orders</h3>
                    <table class="min-w-full leading-normal mt-4">
                        <thead>
                            <tr>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Order
                                    ID</th>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Customer</th>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Total</th>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">001</td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">John
                                    Doe</td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">$50.00</td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">Shipped</td>
                            </tr>
                            <!-- More rows as needed -->
                        </tbody>
                    </table>
                </div>
                <div id="manage-users"
                    class="bg-white shadow-md rounded-lg overflow-hidden mb-8 p-8 hidden">
                    <h3 class="text-xl font-bold text-gray-800">Manage
                        Users</h3>
                    <table class="min-w-full leading-normal mt-4">
                        <thead>
                            <tr>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">User
                                    ID</th>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Name</th>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Email</th>
                                <th
                                    class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">U001</td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">Alice
                                    Smith</td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">alice@example.com</td>
                                <td
                                    class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                    <button
                                        class="bg-yellow-500 hover:bg-yellow-700 text-white font-bold py-1 px-2 rounded">Edit</button>
                                    <button
                                        class="bg-red-500 hover:bg-red-700 text-white font-bold py-1 px-2 rounded">Delete</button>
                                </td>
                            </tr>
                            <!-- More rows as needed -->
                        </tbody>
                    </table>
                </div>
                <div id="settings"
                    class="bg-white shadow-md rounded-lg overflow-hidden mb-8 p-8 hidden">
                    <h3 class="text-xl font-bold text-gray-800">Settings</h3>
                    <form class="mt-4">
                        <label
                            class="block text-gray-700 text-sm font-bold mb-2"
                            for="site-name">Site Name</label>
                        <input
                            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3"
                            id="site-name" type="text" placeholder="Site Name">
                        <label
                            class="block text-gray-700 text-sm font-bold mb-2"
                            for="admin-email">Admin Email</label>
                        <input
                            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3"
                            id="admin-email" type="email"
                            placeholder="Admin Email">
                        <button
                            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
                            type="button">Save Settings</button>
                    </form>
                </div>
            </section>
        </div>

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

        <script>
        document.getElementById('link-add-product').onclick = function() {
            toggleSection('add-product');
        }
        document.getElementById('link-manage-products').onclick = function() {
            toggleSection('manage-products');
        }
        document.getElementById('link-view-orders').onclick = function() {
            toggleSection('view-orders');
        }
        document.getElementById('link-manage-users').onclick = function() {
            toggleSection('manage-users');
        }
        document.getElementById('link-settings').onclick = function() {
            toggleSection('settings');
        }

        function toggleSection(id) {
            var sections = document.querySelectorAll('section > div');
            sections.forEach(section => section.classList.add('hidden'));
            document.getElementById(id).classList.remove('hidden');
        }
    </script>
    </body>
</html>