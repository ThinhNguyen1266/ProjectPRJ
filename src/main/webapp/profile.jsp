<%-- 
    Document   : profile
    Created on : Jul 3, 2024, 9:27:35 PM
    Author     : AnhNLCE181837
--%>

<%@page import="DAOs.UserDAO"%>
<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>User Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: #f5f5f5;
                margin-top: 20px;
            }
            .ui-w-80 {
                width: 80px !important;
                height: auto;
            }
            .btn-outline-primary {
                border-color: #26B4FF;
                background: transparent;
                color: #26B4FF;
            }
            .text-light {
                color: #babbbc !important;
            }
            .card {
                background-clip: padding-box;
                box-shadow: 0 1px 4px rgba(24, 28, 33, 0.1);
            }
            .account-settings-fileinput {
                position: absolute;
                visibility: hidden;
                width: 1px;
                height: 1px;
                opacity: 0;
            }
            .account-settings-links .list-group-item.active {
                font-weight: bold !important;
                background-color: #e9ecef !important;
            }
            .dropdown-menu {
                right: 0;
                left: auto;
            }
            .profile-section p {
                margin-bottom: 0.5rem;
            }
            .profile-section strong {
                display: block;
                margin-bottom: 0.25rem;
            }
        </style>
    </head>
    <body class="bg-gray-100">
        <header class="bg-white shadow-md fixed top-0 left-0 w-full z-50">
            <div class="mx-auto px-4 py-4 flex justify-between items-center">
                <a href="/ProductController/List" class="text-2xl font-bold text-gray-900">ShopName</a>
                <div class="flex space-x-4">
                    <a href="/ProductController/About-Contact" class="text-gray-800 hover:text-gray-600">About/Contact</a>
                    <a href="/ProductController/Cart" class="text-gray-800 hover:text-gray-600">Cart</a>
                    <%
                        String customerName = (String) session.getAttribute("customername");
                        User user = null;
                        if (customerName != null) {
                            UserDAO userDAO = new UserDAO();
                            user = userDAO.getUser(customerName);
                    %>
                    <div class="relative inline-block text-left">
                        <button onclick="toggleDropdown()" class="text-gray-800 hover:text-gray-600">
                            <%= customerName%>
                        </button>
                        <div id="dropdownMenu" class="dropdown-menu hidden absolute mt-2 w-48 bg-white border border-gray-200 rounded-md shadow-lg">
                            <a href="/AccountController/Profile" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">Profile</a>
                            <a href="/AccountController/Logout" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">Sign Out</a>
                        </div>
                    </div>
                    <% } else { %>
                    <a href="/AccountController/Login" class="text-gray-800 hover:text-gray-600">Login</a>
                    <% }%>
                </div>
            </div>
        </header>
        <div class="container light-style flex-grow-1 container-p-y mt-20">
            <h4 class="font-weight-bold py-3 mb-4">Account settings</h4>
            <div class="card overflow-hidden">
                <div class="row no-gutters row-bordered row-border-light">
                    <div class="col-md-3 pt-0">
                        <div class="list-group list-group-flush account-settings-links">
                            <a class="list-group-item list-group-item-action active" data-toggle="list" href="#account-general">General</a>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="tab-content">
                            <div class="tab-pane fade active show" id="account-general">
                                <hr class="border-light m-0">
                                <div class="profile-section p-4">
                                    <p><strong>Name:</strong><%= (user == null) ? "" : user.getName()%></p>
                                    <p><strong>Email:</strong><%= (user == null) ? "" : user.getEmails()%></p>
                                    <p><strong>Phone Number:</strong><%= (user == null) ? "" : user.getPhoneNumber()%></p>
                                    <p><strong>Default Address:</strong><%= (user == null) ? "" : user.getAddress().getAddress()%></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="text-right mt-3 p-4">
                    <a class="btn btn-secondary" href="/AccountController/Edit/<%= customerName%>">Edit</a>
                    <button type="button" class="btn btn-default"><a href="/ProductController/List">Cancel</a></button>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
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
    </body>
</html>
