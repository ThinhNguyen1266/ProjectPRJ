<%-- 
    Document   : admin
    Created on : Jul 1, 2024, 9:48:25 PM
    Author     : AnhNLCE181837
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProductDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Page</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
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
                <a href="index.html" class="text-xl font-bold text-gray-800">ShopName</a>
                <div class="flex space-x-4">
                    <a href="index.html" class="text-gray-800 hover:text-gray-600">Home</a>
                    <a href="about-contact.html" class="text-gray-800 hover:text-gray-600">About/Contact</a>
                    <a href="cart.html" class="text-gray-800 hover:text-gray-600">Cart</a>
                    <h1>Hello: <%= session.getAttribute("adminname")%></h1>
                </div>
            </div>
        </header>

        <div class="container mx-auto px-4 py-8 flex mt-20">
            <!-- Sidebar -->
            <aside class="fixed inset-y-0 left-0 w-60 bg-gray-800 text-white shadow-lg h-screen">
                <div class="p-4">
                    <h2 class="text-xl font-bold mb-4">Admin Abilities</h2>
                    <ul class="space-y-2">
                        <li><a id="link-add-product" href="javascript:void(0)" class="hover:text-gray-400">Add New Product</a></li>
                        <li><a id="link-manage-products" href="javascript:void(0)" class="hover:text-gray-400">Manage Products</a></li>
                        <li><a id="link-view-orders" href="javascript:void(0)" class="hover:text-gray-400">View Orders</a></li>
                        <li><a id="link-manage-users" href="javascript:void(0)" class="hover:text-gray-400">View Users</a></li>
                        <li><a id="link-settings" href="javascript:void(0)" class="hover:text-gray-400">Settings</a></li>
                    </ul>
                </div>
            </aside>

            <!-- Main Content -->
            <section class="flex-grow ml-64 pl-8">
                <!-- Add New Product -->
                <div id="add-product" class="bg-white shadow-md rounded-lg overflow-hidden mb-8 p-8 hidden">
                    <h3 class="text-xl font-bold text-gray-800">Add New Product</h3>
                    <form class="mt-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="product-ID">Product ID</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3" id="product-ID" type="text" placeholder="Product ID">

                        <label class="block text-gray-700 text-sm font-bold mb-2" for="product-name">Product Name</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3" id="product-name" type="text" placeholder="Product Name">

                        <label class="block text-gray-700 text-sm font-bold mb-2" for="product-description">Product Description</label>
                        <textarea class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3" id="product-description" placeholder="Product Description"></textarea>

                        <label class="block text-gray-700 text-sm font-bold mb-2" for="product-price">Product Price</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3" id="product-price" type="text" placeholder="Product Price">

                        <label class="block text-gray-700 text-sm font-bold mb-2" for="product-quantity">Product Quantity</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3" id="product-quantity" type="text" placeholder="Product Quantity">

                        <label class="block text-gray-700 text-sm font-bold mb-2" for="product-category">Product Category</label>
                        <select class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3" id="product-category">
                            <option value="">Select Category</option>
                            <option value="1">Category 1</option>
                            <option value="2">Category 2</option>
                            <option value="3">Category 3</option>
                            <!-- Add more options as needed -->
                        </select>

                        <label class="block text-gray-700 text-sm font-bold mb-2" for="product-image">Product Image</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3" id="product-image" type="file" accept="image/*">

                        <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" type="button">Add Product</button>
                    </form>
                </div>



                <!-- Manage Products -->
                <div id="manage-products" class="bg-white shadow-md rounded-lg overflow-hidden mb-8 p-8">
                    <h3 class="text-xl font-bold text-gray-800">Manage Products</h3>
                    <table class="min-w-full leading-normal mt-4">
                        <thead>
                            <tr>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Product ID</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Product Name</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Description</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Image</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Price</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Quantity</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Category</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ProductDAO pdao = new ProductDAO();
                                ResultSet rs = pdao.getAllProductAdmin();
                                while (rs.next()) {
                            %>
                            <tr>
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= rs.getString("id")%></td>
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= rs.getString("name")%></td>
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= rs.getString("description")%></td>
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><img src="<%= rs.getString("image")%>" alt="Product 1 Image" class="w-16 h-16"></td>
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">$10.00</td>
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= rs.getString("quantity")%></td>
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= rs.getString("category")%></td>
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                                    <button class="bg-yellow-500 hover:bg-yellow-700 text-white font-bold py-1 px-2 rounded" onclick="openEditModal('<%= rs.getString("id")%>', '<%= rs.getString("name")%>', '<%= rs.getString("description")%>', '<%= rs.getString("image")%>', '$10.00', '<%= rs.getString("quantity")%>', '<%= rs.getString("category")%>')">Edit</button>
                                    <button class="bg-red-500 hover:bg-red-700 text-white font-bold py-1 px-2 rounded">Delete</button>
                                </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>

                <!-- Edit Modal -->
                <div id="edit-modal" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full hidden">
                    <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
                        <h3 class="text-xl font-bold text-gray-800 mb-4">Edit Product</h3>
                        <form id="edit-form">
                            <input type="hidden" id="edit-product-id">
                            <div class="mb-4">
                                <label for="edit-product-name" class="block text-gray-700 text-sm font-bold mb-2">Product Name:</label>
                                <input type="text" id="edit-product-name" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            </div>
                            <div class="mb-4">
                                <label for="edit-product-description" class="block text-gray-700 text-sm font-bold mb-2">Description:</label>
                                <textarea id="edit-product-description" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"></textarea>
                            </div>
                            <div class="mb-4">
                                <label for="edit-product-image" class="block text-gray-700 text-sm font-bold mb-2">Image URL:</label>
                                <input type="text" id="edit-product-image" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            </div>
                            <div class="mb-4">
                                <label for="edit-product-price" class="block text-gray-700 text-sm font-bold mb-2">Price:</label>
                                <input type="text" id="edit-product-price" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            </div>
                            <div class="mb-4">
                                <label for="edit-product-quantity" class="block text-gray-700 text-sm font-bold mb-2">Quantity:</label>
                                <input type="text" id="edit-product-quantity" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            </div>
                            <div class="mb-4">
                                <label for="edit-product-category" class="block text-gray-700 text-sm font-bold mb-2">Category:</label>
                                <input type="text" id="edit-product-category" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            </div>
                            <div class="flex items-center justify-between">
                                <button type="button" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" onclick="saveEdit()">Save</button>
                                <button type="button" class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" onclick="closeEditModal()">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>

                <script>
                    function openEditModal(id, name, description, image, price, quantity, category) {
                        document.getElementById('edit-product-id').value = id;
                        document.getElementById('edit-product-name').value = name;
                        document.getElementById('edit-product-description').value = description;
                        document.getElementById('edit-product-image').value = image;
                        document.getElementById('edit-product-price').value = price;
                        document.getElementById('edit-product-quantity').value = quantity;
                        document.getElementById('edit-product-category').value = category;
                        document.getElementById('edit-modal').classList.remove('hidden');
                    }

                    function closeEditModal() {
                        document.getElementById('edit-modal').classList.add('hidden');
                    }

                    function saveEdit() {
                        // Implement save functionality here
                        closeEditModal();
                    }
                </script>


                <!-- View Orders -->
                <div id="view-orders" class="bg-white shadow-md rounded-lg overflow-hidden mb-8 p-8 hidden">
                    <h3 class="text-xl font-bold text-gray-800">View Orders</h3>
                    <table class="min-w-full leading-normal mt-4">
                        <thead>
                            <tr>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Order ID</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Customer</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Total</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">001</td>
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">John Doe</td>
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">$50.00</td>
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">Shipped</td>
                            </tr>
                            <!-- More rows as needed -->
                        </tbody>
                    </table>
                </div>

                <!-- Manage Users -->
                <div id="manage-users" class="bg-white shadow-md rounded-lg overflow-hidden mb-8 p-8 hidden">
                    <h3 class="text-xl font-bold text-gray-800">Manage Users</h3>
                    <table class="min-w-full leading-normal mt-4">
                        <thead>
                            <tr>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">User ID</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Name</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Email</th>
                                <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Phone Number</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">U001</td>
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><a href="profile.html">Alice Smith</a></td>                            
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">alice@example.com</td>
                                <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">123-456-7890</td>
                                </td>
                            </tr>
                            <!-- More rows as needed -->
                        </tbody>
                    </table>
                </div>
                <!-- Settings -->
                <div id="settings" class="bg-white shadow-md rounded-lg overflow-hidden mb-8 p-8 hidden">
                    <h3 class="text-xl font-bold text-gray-800">Settings</h3>
                    <form class="mt-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="site-name">Site Name</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3" id="site-name" type="text" placeholder="Site Name">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="admin-email">Admin Email</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3" id="admin-email" type="email" placeholder="Admin Email">
                        <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" type="button">Save Settings</button>
                    </form>
                </div>
            </section>
        </div>
        <br><br><br><br><br><br><br><br>
        <br><br><br><br><br><br><br><br>
        <br><br><br><br><br><br><br><br>
        <br><br><br><br><br><br><br><br>

        <!-- Footer -->
        <!-- Footer -->
        <footer class="bg-gray-800 text-white py-8 mt-auto">
            <div class="container mx-auto px-4 text-center">
                <p>&copy; 2024 ShopName. All rights reserved.</p>
                <div class="mt-4 space-x-4">
                    <a href="#" class="hover:text-gray-400">Privacy Policy</a>
                    <a href="#" class="hover:text-gray-400">Terms of Service</a>
                </div>
            </div>
        </footer>


        <script>
            document.getElementById('link-add-product').onclick = function () {
                toggleSection('add-product');
            }
            document.getElementById('link-manage-products').onclick = function () {
                toggleSection('manage-products');
            }
            document.getElementById('link-view-orders').onclick = function () {
                toggleSection('view-orders');
            }
            document.getElementById('link-manage-users').onclick = function () {
                toggleSection('manage-users');
            }
            document.getElementById('link-settings').onclick = function () {
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
