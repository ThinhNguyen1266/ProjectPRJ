<%-- 
    Document   : admin
    Created on : Jul 1, 2024, 9:48:25 PM
    Author     : AnhNLCE181837
--%>

<%@page import="DAOs.UserDAO"%>
<%@page import="DAOs.CategoryDAO"%>
<%@page import="Models.Category"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProductDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Page</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <style>
            .hidden {
                display: none;
            }
        </style>
    </head>

    <body class="bg-gray-100">
        <c:if test="${sessionScope.adminName ==null}"> <c:redirect url="/Admin_profile"></c:redirect> </c:if>
                <!-- Header -->
                <header class="bg-white shadow-md fixed top-0 left-0 w-full z-50">
                    <div class="mx-auto px-4 py-4 flex justify-between items-center">
                        <a href="index.html" class="text-xl font-bold text-gray-800">ShopName</a>
                        <div class="flex space-x-4">
                            <a href="/" class="text-gray-800 hover:text-gray-600">Home</a>
                            <a href="about-contact.html" class="text-gray-800 hover:text-gray-600">About/Contact</a>
                            <a href="cart.html" class="text-gray-800 hover:text-gray-600">Cart</a>
                            <h1>${sessionScope.adminName}</h1>

                    <a href="/AccountController/Logout" class="btn btn-danger">Sign Out</a>
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
                    <form class="mt-4" method="post" action="/ProductController" enctype='multipart/form-data'>

                        <label class="block text-gray-700 text-sm font-bold mb-2" for="product-name">Product Name</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3" id="product-name" type="text" placeholder="Product Name" name="proName">

                        <label class="block text-gray-700 text-sm font-bold mb-2" for="product-description">Product Description</label>
                        <textarea class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3" id="product-description" placeholder="Product Description" name="proDes"></textarea>

                        <label class="block text-gray-700 text-sm font-bold mb-2" for="product-quantity">Product Quantity</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3" id="product-quantity" type="number" placeholder="Product Quantity" name="proQuan">

                        <div class="flex flex-wrap -mx-3 mb-6">
                            <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="product-category">Product Category</label>
                                <select class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3" id="product-category" data-nextcombo="#product-subcategory">

                                    <%
                                        CategoryDAO catDAO = new CategoryDAO();
                                        ResultSet rs = catDAO.getAllCategoriesNull();
                                    %>
                                    <option value="">Select Category</option>
                                    <% while (rs.next()) {%>
                                    <option value="<%= rs.getString("id")%>" data-id="<%= rs.getString("id")%>" data-option="-1"><%= rs.getString("name")%></option>

                                    <% } %>
                                </select>
                            </div>  

                        </div>
                        <div class="w-full md:w-1/2 px-3">
                            <label class="block text-gray-700 text-sm font-bold mb-2" for="product-subcategory">Product Subcategory</label>
                            <select class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3" id="product-subcategory" name="proCat" disabled>
                                <option value="">Select Subcategory</option>
                                <%
                                    rs = catDAO.getAllCategoriesNull();
                                    while (rs.next()) {
                                %>
                                <%
                                    ResultSet subcat = catDAO.getAllSubCat(rs.getString("id"));
                                    while (subcat.next()) {
                                %>
                                <option value="<%= subcat.getString("id")%>"  data-option="<%= rs.getString("id")%>"><%= subcat.getString("name")%></option>
                                <!--                                    <option value="2" data-id="2" data-option="1">Subcategory 1-2</option>
                                                                    <option value="3" data-id="3" data-option="2">Subcategory 2-1</option>
                                                                    <option value="4" data-id="4" data-option="3">Subcategory 3-1</option>-->
                                <% } %>
                                <% } %>
                            </select>
                        </div>
                </div>


                <script>
                    function jq_ChainCombo(el) {
                        var selected = $(el).find(':selected').data('id'); // get parent selected options' data-id attribute

                        // get next combo (data-nextcombo attribute on parent select)
                        var next_combo = $(el).data('nextcombo');

                        // now if this 2nd combo doesn't have the old options list stored in it, make it happen
                        if (!$(next_combo).data('store'))
                            $(next_combo).data('store', $(next_combo).find('option')); // store data

                        // now include data stored in attribute for use...
                        var options2 = $(next_combo).data('store');

                        // update combo box with filtered results
                        $(next_combo).empty().append(
                                options2.filter(function () {
                                    return $(this).data('option') === selected;
                                })
                                );

                        // now enable in case disabled... 
                        $(next_combo).prop('disabled', false);
                    }

                    // quick little jquery plugin to apply jq_ChainCombo to all selects with a data-nextcombo on them
                    jQuery.fn.chainCombo = function () {
                        // find all selects with a data-nextcombo attribute
                        $('[data-nextcombo]').each(function (i, obj) {
                            $(this).change(function () {
                                jq_ChainCombo(this);
                            });
                        });
                    }();
                </script>


                <label class="block text-gray-700 text-sm font-bold mb-2" for="product-image">Product Image</label>
                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3" id="product-image" type="file" accept="image/*" name="proImg">

                <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" type="submit" name="createBtn">Add Product</button>
                </form>
        </div>



        <!-- Manage Products -->
        <div id="manage-products" class="bg-white shadow-md rounded-lg overflow-hidden mb-8 p-8 hidden">
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
                        rs = pdao.getAllProductAdmin();
                        while (rs.next()) {
                    %>
                    <tr>
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= rs.getString("id")%></td>
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= rs.getString("name")%></td>
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= rs.getString("description")%></td>
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><img src="<%= rs.getString("image")%>" alt="Product 1 Image" class="w-16 h-16"></td>
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">$10.00</td>
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= rs.getString("quantity")%></td>
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= rs.getString("name")%></td>
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                            <button class="bg-yellow-500 hover:bg-yellow-700 text-white font-bold py-1 px-2 rounded">Edit</button>
                            <button class="bg-red-500 hover:bg-red-700 text-white font-bold py-1 px-2 rounded">Delete</button>
                        </td>
                    </tr>
                    <!-- More rows as needed -->
                    <% }%>
                </tbody>
            </table>
        </div>


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
                    <%
                        UserDAO ud = new UserDAO();
                        rs = ud.getAll();
                        while (rs.next()) {
                    %>
                    <tr>
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= rs.getString("account_id")%></td>
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><a href="profile.html"><%= rs.getString("name")%></a></td>                            
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= rs.getString("email")%></td>
                        <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><%= rs.getString("phone_number")%></td>
                        </td>
                    </tr>
                    <% }%>
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

    <br><br><br><br><br><br><br><br>
    <br><br><br><br><br><br><br><br>
    <br><br><br><br><br><br><br><br>
    <br><br><br><br><br><br><br><br>

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


