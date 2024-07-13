<%@page import="DAOs.UserDAO"%>
<%@page import="Models.Province"%>
<%@page import="Models.User"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProvinceDAO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Account Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
     
    </head>
    <body class="bg-gray-100">
        <%
            User obj = (User) session.getAttribute("userinformation");
        %>
        <!-- Header -->
        <header class="bg-white shadow-md fixed top-0 left-0 w-full z-40">
            <div class="mx-auto px-4 py-4 flex justify-between items-center">
                <a href="/ProductController/List" class="text-xl font-bold text-gray-800">ShopName</a>
            </div>
        </header>

      
        <!-- Create Account Form -->
        <section class="py-12">
            <div class="container mx-auto px-4 max-w-md">
                <h2 class="text-2xl font-bold text-gray-800 text-center">Add Address</h2>
                <form action="AccountController" method="post" class="bg-white shadow-md rounded-lg p-8 mt-8">
                    <input id="Id" type="hidden" name="txtId" value="<%= obj.getId()%>">

                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="name">Name</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="name" type="text" placeholder="Name" name="txtName" disabled value="<%= obj.getName()%>">
                    </div>

                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="Address">Address</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="Address" type="text" placeholder="Address" name="txtAddress">
                    </div>

                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2">Province</label>
                        <select name="txtProvince" id="province" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            <%
                                ProvinceDAO provinceDao = new ProvinceDAO();
                                ResultSet rs = provinceDao.getAll();
                                while (rs.next()) {
                                    String provinceName = rs.getString("name");
                            %>
                            <option value="<%= provinceName%>"><%= provinceName%></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="flex items-center justify-between">
                        <a href="/AccountController/Profile" class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline inline-block text-center">Back</a>
                        <button class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline inline-block text-center" name="btnSaveAddress">Save</button>
                    </div>
                </form>
            <form action="AccountController" method="post" class="bg-white shadow-md rounded-lg p-8 mt-8">
              
            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2">Set Default Address</label>
                <select name="txtAddressID" id="AddressID" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                    <%
                        UserDAO dao = new UserDAO();
                        ResultSet brs = dao.getAllUserAddress(obj.getId());
                        int default_id=dao.getUserDefault(obj.getId());
                        while (brs.next()) {
                            String address = brs.getString("address");
                            String name = brs.getString("name");
                            int address_id = brs.getInt("address_id");
                            
                            boolean isSelected=address_id==default_id;
                    %>
                    <option value="<%= address_id%>"<%= isSelected ? "selected" : "" %>><%= address%>,<%= name%></option>
                    <% }%>
                      <input id="Id" type="hidden" name="txtDefault_Id" value="<%= default_id%>">
                </select>
            </div>
            <div class="flex items-center justify-between">
                <button class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline inline-block text-center" name="btnSetDefault">Set</button>
            </div>
        </form>

            </div>
        </section>
        

    </body>
</html>
