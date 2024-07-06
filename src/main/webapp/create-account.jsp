<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProvinceDAO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Account</title>
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
            </div>
        </header>

        <!-- Create Account Form -->
        <section class="py-12 mt-16">
            <div class="container mx-auto px-4 max-w-md">
                <h2 class="text-2xl font-bold text-gray-800 text-center">Create Account</h2>
                <form action="CreateAccountController" method="post" class="bg-white shadow-md rounded-lg p-8 mt-8" onsubmit="return validateForm()">
                    <div class="mb-4">
                        <div class="mb-6">
                            <label class="block text-gray-700 text-sm font-bold mb-2" for="Username">Username</label>
                            <% if (request.getAttribute("UsernameError") != null) {%>
                            <p style="color: red"><%= (String) request.getAttribute("UsernameError")%></p>
                            <% }%>
                            <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" id="Username" type="text" name="txtUsername" placeholder="Username" value="<%= request.getAttribute("txtUsername") != null ? (String) request.getAttribute("txtUsername") : ""%>" required>
                        </div>
                        <div class="mb-6">
                            <label class="block text-gray-700 text-sm font-bold mb-2" for="password">Password</label>
                            <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" id="password" type="password" name="txtPassword" placeholder="Password" required>
                        </div>
                        <div class="mb-6">
                            <label class="block text-gray-700 text-sm font-bold mb-2" for="Confirm password">Confirm password</label>
                            <% if (request.getAttribute("PasswordError") != null) {%>
                            <p style="color: red"><%= (String) request.getAttribute("PasswordError")%></p>
                            <% }%>
                            <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" id="Confirm password" type="password" name="txtConfirmPassword" placeholder="Confirm password" required>
                        </div>
                        <div class="mb-4">
                            <label class="block text-gray-700 text-sm font-bold mb-2" for="email">Email</label>
                            <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="email" type="email" placeholder="Email" name="txtEmail" value="<%= request.getAttribute("txtEmail") != null ? (String) request.getAttribute("txtEmail") : ""%>" required>
                        </div>
                        <div class="mb-4">
                            <label class="block text-gray-700 text-sm font-bold mb-2" for="name">Name</label>
                            <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="name" type="text" placeholder="Name" name="txtName" value="<%= request.getAttribute("txtName") != null ? (String) request.getAttribute("txtName") : ""%>" required>
                        </div>
                        <div class="mb-4">
                            <label class="block text-gray-700 text-sm font-bold mb-2" for="Phone number">Phone number</label>
                            <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="Phone number" type="text" placeholder="Phone number" name="txtPhonenumber" value="<%= request.getAttribute("txtPhonenumber") != null ? (String) request.getAttribute("txtPhonenumber") : ""%>" required>
                        </div>
                        <div class="mb-4">
                            <label class="block text-gray-700 text-sm font-bold mb-2" for="Address">Address</label>
                            <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="Address" type="text" placeholder="Address" name="txtAddress" value="<%= request.getAttribute("txtAddress") != null ? (String) request.getAttribute("txtAddress") : ""%>" required>
                        </div>
                        <div class="mb-4">
                            <label class="block text-gray-700 text-sm font-bold mb-2">Province</label>
                            <select name="txtProvince" id="province" required>
                                <% ProvinceDAO provinceDao = new ProvinceDAO();
                                    ResultSet rs = provinceDao.getAll();
                                    while (rs.next()) {
                                        String provinceName = rs.getString("name");%>
                                <option value="<%= provinceName%>" <%= provinceName.equals(request.getAttribute("txtProvince")) ? "selected" : ""%>><%= provinceName%></option>
                                <% }%>
                            </select>
                        </div>
                        <div class="flex items-center justify-between">
                            <a href="/AccountController/Login" class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline inline-block text-center">Back</a>
                            <button class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline inline-block text-center" name="btnSignin">sign-in</button>
                        </div>
                    </div>
                </form>
            </div>
        </section>


        <!-- Footer -->
        <!--<footer class="bg-gray-800 text-white py-8">
            <div class="container mx-auto px-4 text-center">
                <p>&copy; 2024 ShopName. All rights reserved.</p>
                <div class="mt-4 space-x-4">
                    <a href="#" class="hover:text-gray-400">Privacy Policy</a>
                    <a href="#" class="hover:text-gray-400">Terms of Service</a>
                </div>
            </div>
        </footer>
        -->

    </body>
</html>
