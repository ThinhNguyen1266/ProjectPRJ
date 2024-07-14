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
        <link
            href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
            rel="stylesheet">
    </head>
    <body class="bg-gray-100">
        <!-- Header -->
        <header class="bg-white shadow-md">
            <div
                class="container mx-auto px-4 py-4 flex justify-between items-center">
                <a href="/ProductController/List"
                   class="text-xl font-bold text-gray-800">ShopName</a>
            </div>
        </header>

        <!-- Login Form -->
        <section class="py-12">
            <div class="container mx-auto px-4 max-w-md">
                <h2
                    class="text-2xl font-bold text-gray-800 text-center">Login</h2>
                <form action="/CreateAccountController" method="post" class="bg-white shadow-md rounded-lg p-8 mt-8">
                    <%
                        if (request.getAttribute("error") != null) {
                    %>
                    <p style="color: red"><%= (String) request.getAttribute("error")%></p>
                    <%
                        }
                    %>

                    <div class="mb-6">
                        <h1>Please check your email to see your OTP code</h1>
                        <label
                            class="block text-gray-700 text-sm font-bold mb-2"
                            for="password">OTP Input</label>
                        <input
                            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline"
                            id="txtOtp" type="text"
                            name="txtOtp"/>
                    </div>
                    <div class="flex items-center justify-between">
                        <input
                            class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                            id="btnSendOTP" type="submit" name="btnSendOTP" value="SendOTP"
                            />
                    </div>
                </form>
            </div>
        </section>
    </body>
</html>
