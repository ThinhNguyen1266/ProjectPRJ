<%--
Document : editProductItem
Created on : Jul 11, 2024, 5:19:05 PM
Author : AnhNLCE181837
--%>

<%@page import="Models.Product_item"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProductItemDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Product Item</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }
            .container {
                width: 50%;
                margin: 50px auto;
                background-color: #fff;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                color: #333;
            }
            form {
                display: flex;
                flex-direction: column;
            }
            label {
                margin-top: 10px;
                margin-bottom: 5px;
                font-weight: bold;
            }
            input[type="text"],
            input[type="number"],
            select {
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                width: 100%;
            }
            input[type="submit"] {
                padding: 10px;
                background-color: #5cb85c;
                border: none;
                border-radius: 5px;
                color: #fff;
                cursor: pointer;
            }
            input[type="submit"]:hover {
                background-color: #4cae4c;
            }
            .back-link {
                text-align: center;
                margin-top: 20px;
            }
            .back-link a {
                text-decoration: none;
                color: #5cb85c;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Edit Product Item</h1>
            <%
                String proItemID = (String) request.getAttribute("ProItemID");
                ProductItemDAO piDAO = new ProductItemDAO();
                Product_item pi = piDAO.getProductItem(proItemID);
            %>
            <form action="ProductController" method="post">
                <label for="TxtProItemID">Product Item ID:</label>
                <input type="text" id="TxtProItemID" name="TxtProItemID"
                       value="<%= pi.getItem_id()%>" readonly />

                <%
                    ResultSet rs
                            = piDAO.getProductVariance(String.valueOf(pi.getItem_id()));
                    while (rs.next()) {
                        if (rs.getString("variane_name").equals("Color")
                                || rs.getString("variane_name").equals("Storage")
                                || rs.getString("variane_name").equals("RAM")) {
                %>
                <label for="txt<%= rs.getString("variane_name")%>"><%=rs.getString("variane_name")%>:</label>
                <select id="txt<%= rs.getString("variane_name")%>" name="txt<%=rs.getString("variane_name")%>">
                    <%
                        ResultSet dropDownList
                                = piDAO.getDropDownListVariation(rs.getString("variationID"));
                        while (dropDownList.next()) {
                            String selected = "";
                            if (dropDownList.getString("value").equals(rs.getString("variance_value"))) {
                                selected = "selected";
                            }
                    %>
                    <option value="<%= dropDownList.getString("value")%>" <%=selected%> ><%=dropDownList.getString("value")%></option>
                    <%
                        }
                    %>
                </select>
                <%
                        }
                    }
                %>

                <label for="TxtQuantity">Quantity:</label>
                <input type="number" id="TxtQuantity" name="TxtQuantity" min="1"
                       value="<%= pi.getItem_quan()%>" />

                <label for="TxtPrice">Price:</label>
                <input type="number" id="TxtPrice" name="TxtPrice" min="1"
                       value="<%= pi.getPrice()%>" />

                <div class="back-link">
                    <a
                        href="/ProductController/Edit/<%= pi.getPro_id()%>">Back</a>
                </div>
                <input type="submit" name="btnEditProItem" value="Update" />
            </form>
        </div>
    </body>
</html>
