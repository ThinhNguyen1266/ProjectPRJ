<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProvinceDAO"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Account</title>
        <link rel="stylesheet" href="styles.css">

        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }

            .container {
                width: 100%;
                margin: 20px auto;
                overflow: hidden;
            }

            .content-container {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            .form-container {
                background: #fff;
                width: 50%;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .form-container h3 {
                margin-bottom: 20px;
                font-size: 24px;
                color: #333;
            }

            .form-container label {
                display: block;
                font-weight: bold;
                color: #555;
                margin-bottom: 5px;
            }

            .form-container input,
            .form-container select {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
            }

            .form-container button {
                background: #007bff;
                color: #fff;
                border: none;
                padding: 10px 20px;
                cursor: pointer;
                font-size: 16px;
                border-radius: 4px;
                transition: background 0.3s ease;
            }

            .form-container button:hover {
                background: #0056b3;
            }

            .flex {
                display: flex;
                justify-content: space-between;
                gap: 10px;
            }

            .flex-container {
                display: flex;
                gap: 10px;
            }

            label {
                display: block;
                margin-bottom: 5px;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <div class="content-container">
                <div class="form-container">
                    <h3>Create Account</h3>
                    <form action="CreateAccountController" method="post" onsubmit="return validateForm()">
                        <label for="Username">Username</label>
                        <% if (request.getAttribute("UsernameError") != null) {%>
                        <p style="color: red"><%= (String) request.getAttribute("UsernameError")%></p>
                        <% }%>
                        <input id="Username" type="text" name="txtUsername" placeholder="Username"
                               value="<%= request.getAttribute("txtUsername") != null ? (String) request.getAttribute("txtUsername") : ""%>"
                               required>

                        <label for="password">Password</label>
                        <input id="password" type="password" name="txtPassword" placeholder="Password" required>

                        <label for="Confirm password">Confirm password</label>
                        <% if (request.getAttribute("PasswordError") != null) {%>
                        <p style="color: red"><%= (String) request.getAttribute("PasswordError")%></p>
                        <% }%>
                        <input id="Confirm password" type="password" name="txtConfirmPassword" placeholder="Confirm password"
                               required>

                        <label for="email">Email</label>
                        <input id="email" type="email" placeholder="Email" name="txtEmail"
                               value="<%= request.getAttribute("txtEmail") != null ? (String) request.getAttribute("txtEmail") : ""%>"
                               required>

                        <label for="name">Name</label>
                        <input id="name" type="text" placeholder="Name" name="txtName"
                               value="<%= request.getAttribute("txtName") != null ? (String) request.getAttribute("txtName") : ""%>"
                               required>

                        <label for="Phone number">Phone number</label>
                        <input id="Phone number" type="text" placeholder="Phone number" name="txtPhonenumber"
                               value="<%= request.getAttribute("txtPhonenumber") != null ? (String) request.getAttribute("txtPhonenumber") : ""%>"
                               required>

                        <label for="Address">Address</label>
                        <input id="Address" type="text" placeholder="Address" name="txtAddress"
                               value="<%= request.getAttribute("txtAddress") != null ? (String) request.getAttribute("txtAddress") : ""%>"
                               required>

                        <label>Province</label>
                        <select name="txtProvince" id="province" required>
                            <% ProvinceDAO provinceDao = new ProvinceDAO();
                                ResultSet rs = provinceDao.getAll();
                                while (rs.next()) {
                                    String provinceName = rs.getString("name");%>
                            <option value="<%= provinceName%>"
                                    <%= provinceName.equals(request.getAttribute("txtProvince")) ? "selected" : ""%>>
                                <%= provinceName%></option>
                                <% }%>
                        </select>

                        <div class="flex">
                            <a href="/AccountController/Login"
                               class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded inline-block text-center">Back</a>
                            <button type="submit" name="btnSignin">Sign In</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>

</html>
