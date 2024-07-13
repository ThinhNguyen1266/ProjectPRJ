<%@page import="Models.Product"%>
<%@page import="DAOs.VariationDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProductItemDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Product Item</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .container {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 400px;
            }

            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }

            label {
                display: block;
                font-weight: bold;
                color: #555;
                margin-bottom: 5px;
            }

            input[type="text"],
            input[type="number"],
            select {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
            }

            .btn {
                background: #007bff;
                color: #fff;
                border: none;
                padding: 10px 20px;
                cursor: pointer;
                font-size: 16px;
                border-radius: 4px;
                transition: background 0.3s ease;
                text-decoration: none;
                display: inline-block;
                text-align: center;
                width: 100%;
                margin-bottom: 10px;
            }

            .btn:hover {
                background: #0056b3;
            }

            .btn-back {
                background: #6c757d;
            }

            .btn-back:hover {
                background: #5a6268;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Create Product Item</h1>
            <form action="ProductController" method="post">
                <%
                    ProductItemDAO piDAO = new ProductItemDAO();
                    VariationDAO vDAO = new VariationDAO();

                    if (request.getAttribute("product") != null) {
                        int ProItemID = Integer.parseInt(piDAO.getProduct_itemID()) + 1;
                %>
                <label for="txtProItemID">Product Item ID:</label>
                <input type="number" name="txtProItemID" value="<%= ProItemID%>" readonly/>

                <%
                    Product obj = (Product) request.getAttribute("product");
                    String parentCatID = String.valueOf(obj.getCategory().getParent());
                    ResultSet rs = vDAO.getVariationIDByCatParentName(parentCatID);
                    while (rs.next()) {
                %>
                <label for="txt<%= rs.getString("name") %>"><%= rs.getString("name")%>:</label>
                <select name="txt<%= rs.getString("name")%>">
                    <%
                        ResultSet dropDownList = piDAO.getDropDownListVariation(rs.getString("id"));
                        while (dropDownList.next()) {
                    %>
                    <option value="<%= dropDownList.getString("value")%>"><%= dropDownList.getString("value")%></option>
                    <%
                        }
                    %>
                </select>
                <%
                    }
                %>
                <label for="txtProItemQuantity">Product Item Quantity:</label>
                <input type="number" name="txtProItemQuantity" min="1" required/>

                <label for="txtProItemPrice">Product Item Price:</label>
                <input type="number" name="txtProItemPrice" min="1" required/>

                <input type="hidden" value="<%= obj.getPro_id() %>" name="txtProductID"/>
                <a href="/ProductController/Edit/<%= obj.getPro_id()%>" class="btn">Back</a>
                <input type="submit" name="btnAddNewProItem" value="Create" class="btn"/>
                <% } %>
            </form>
        </div>
    </body>
</html>
