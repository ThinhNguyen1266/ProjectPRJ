<%-- 
    Document   : createProductItem
    Created on : Jul 12, 2024, 4:11:30 PM
    Author     : AnhNLCE181837
--%>

<%@page import="Models.Product"%>
<%@page import="DAOs.VariationDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.ProductItemDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Create Product Item</h1>
        <form action="ProductController" method="post">
            <%
                ProductItemDAO piDAO = new ProductItemDAO();
                VariationDAO vDAO = new VariationDAO();

                if (request.getAttribute("product") != null) {
                    int ProItemID = Integer.parseInt(piDAO.getProduct_itemID()) + 1;
            %>
            Product Item ID: <input type="number" name="txtProItemID" value="<%= ProItemID%>" readonly=""/> <br/>
            <%
                Product obj = (Product) request.getAttribute("product");
                String parentCatID = String.valueOf(obj.getCategory().getParent());
                ResultSet rs = vDAO.getVariationIDByCatParentName(parentCatID);
                while (rs.next()) {

            %>
            <%= rs.getString("name")%> <br/>
            <select name="txt<%= rs.getString("name")%>">
                <%
                    ResultSet dropDownList = piDAO.getDropDownListVariation(rs.getString("id"));
                    while (dropDownList.next()) {

                %>
                <option value="<%= dropDownList.getString("value")%>" ><%= dropDownList.getString("value")%></option>
                <%
                    }
                %>
            </select><br/><br/>
            <%
                }

            %>
            Product Item Quantity: <input type="number" name="txtProItemQuantity" min="1" required=""/> <br/>
            Product Item Price <input type="number" name="txtProItemPrice" min="1" required=""/> <br/>
            <a href="/ProductController/Edit/<%= obj.getPro_id()%>">Back</a>
            <input hidden="" type="" value="<%= obj.getPro_id() %>" name="txtProductID"/>
            <input type="submit" name="btnAddNewProItem" value="Create"/>
            <%    }

            %>
        </form>
    </body>
</html>
