<%-- 
    Document   : login
    Created on : Jun 30, 2024, 10:48:25 AM
    Author     : AnhNLCE181837
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <!-- Header -->
    <header class="bg-white shadow-md">
        <div class="container mx-auto px-4 py-4 flex justify-between items-center">
            <a href="/ProductController/List" class="text-xl font-bold text-gray-800">ShopName</a>
        </div>
    </header>

    <!-- Login Form -->
    <section class="py-12">
        <div class="container mx-auto px-4 max-w-md">
            <h2 class="text-3xl font-bold text-gray-800 text-center mb-6">Reset Password</h2>
            <form action="/CreateAccountController" method="post" class="bg-white shadow-md rounded-lg p-8">
                <% if (request.getAttribute("error") != null) { %>
                    <p class="text-red-600 mb-4"><%= (String) request.getAttribute("error") %></p>
                <% } %>
                
                <div class="mb-6">
                    <h3 class="text-lg font-medium text-gray-700 mb-2">Please input new password</h3>
                    <label for="password" class="block text-gray-700 mb-1">Password</label>
                    <input id="password" type="password" name="txtPassword" placeholder="Password" required class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-gray-600">
                    
                    <label for="Confirm password" class="block text-gray-700 mt-4 mb-1">Confirm password</label>
                    <% if (request.getAttribute("PasswordError") != null) { %>
                        <p class="text-red-600 mb-2"><%= (String) request.getAttribute("PasswordError") %></p>
                    <% } %>
                    <input id="Confirm password" type="password" name="txtConfirmPassword" placeholder="Confirm password" required class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-gray-600">
                </div>
                
                <div class="flex items-center justify-between">
                    <input class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" id="btnSendP" type="submit" name="btnSendP" value="SendP">
                </div>
            </form>
        </div>
    </section>
</body>
</html>
