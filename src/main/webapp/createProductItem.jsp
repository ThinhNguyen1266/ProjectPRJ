<%-- 
    Document   : createProductItem
    Created on : Jul 12, 2024, 4:11:30 PM
    Author     : AnhNLCE181837
--%>

<%@page import="DAOs.ProductItemDAO"%>
<%@page import="Models.Product"%>
<%@page import="DAOs.VariationDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProvinceDAO"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Product Item</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                padding: 20px;
            }
            .container {
                background-color: #ffffff;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
                max-width: 600px;
                margin: auto;
            }
            h1 {
                margin-bottom: 20px;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <h1 class="text-center">Create Product Item</h1>
            <form action="ProductController" method="post">
                <%
                    ProductItemDAO piDAO = new ProductItemDAO();
                    VariationDAO vDAO = new VariationDAO();

                    if (request.getAttribute("product") != null) {
                        int ProItemID = Integer.parseInt(piDAO.getProduct_itemID()) + 1;
                %>
                <div class="form-group">
                    <label for="txtProItemID">Product Item ID</label>
                    <input type="number" id="txtProItemID" name="txtProItemID" class="form-control" value="<%= ProItemID%>" readonly/>
                </div>

                <%
                    Product obj = (Product) request.getAttribute("product");
                    String parentCatID = String.valueOf(obj.getCategory().getParent());
                    ResultSet rs = vDAO.getVariationIDByCatParentName(parentCatID);
                    while (rs.next()) {
                %>
                <div class="form-group">
                    <label for="txt<%= rs.getString("name") %>"><%= rs.getString("name") %></label>
                    <select id="txt<%= rs.getString("name") %>" name="txt<%= rs.getString("name") %>" class="form-control">
                        <%
                            ResultSet dropDownList = piDAO.getDropDownListVariation(rs.getString("id"));
                            while (dropDownList.next()) {
                        %>
                        <option value="<%= dropDownList.getString("value") %>"><%= dropDownList.getString("value") %></option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <%
                    }
                %>

                <div class="form-group">
                    <label for="txtProItemQuantity">Product Item Quantity</label>
                    <input type="number" id="txtProItemQuantity" name="txtProItemQuantity" class="form-control" min="1" required/>
                </div>

                <div class="form-group">
                    <label for="txtProItemPrice">Product Item Price</label>
                    <input type="number" id="txtProItemPrice" name="txtProItemPrice" class="form-control" min="1" required/>
                </div>

                <input type="hidden" name="txtProductID" value="<%= obj.getPro_id() %>"/>
                <a href="/ProductController/Edit/<%= obj.getPro_id() %>" class="btn btn-secondary">Back</a>
                <button type="submit" name="btnAddNewProItem" class="btn btn-primary">Create</button>
                <% } %>
            </form>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>

</html>
