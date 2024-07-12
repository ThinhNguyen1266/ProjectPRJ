<%-- 
    Document   : editProductItem
    Created on : Jul 11, 2024, 5:19:05 PM
    Author     : AnhNLCE181837
--%>

<%@page import="Models.Product_item"%>
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
        <h1>Edit Product Item!</h1>
        <%
            String proItemID = (String) request.getAttribute("ProItemID");
            ProductItemDAO piDAO = new ProductItemDAO();
            Product_item pi = piDAO.getProductItem(proItemID);
        %>
        <form action="ProductController" method="post">
            Product Item ID: <input type="txt" name="TxtProItemID" value="<%= pi.getItem_id()%>" readonly=""/> <br/>
            <%
                ResultSet rs = piDAO.getProductVariance(String.valueOf(pi.getItem_id()));
                while (rs.next()) {
                    if (rs.getString("variane_name").equals("Color") || rs.getString("variane_name").equals("Storage") || rs.getString("variane_name").equals("RAM")) {

            %>
            <%= rs.getString("variane_name")%> :
            <select name="txt<%= rs.getString("variane_name")%>" > 
                <%

                    ResultSet dropDownList = piDAO.getDropDownListVariation(rs.getString("variationID"));
                    while (dropDownList.next()) {
                        String selected = "";
                        if (dropDownList.getString("value").equals(rs.getString("variance_value"))) {
                            selected = "selected";
                        }

                %>
                <option value="<%= dropDownList.getString("value")%>" <%= selected%> ><%= dropDownList.getString("value")%></option>
                <%
                    }
                %>
            </select> <br/> <br/>

            <%}
                }%>

            Quantity: <input type="number" min="1" name="TxtQuantity" value="<%= pi.getItem_quan()%>"/> <br/>
            Price: <input type="number" min="1" name="TxtPrice" value="<%= pi.getPrice()%>"/> <br/>

            <a href="/ProductController/Edit/<%= pi.getPro_id()%>">Back</a>
            <input type="submit" name="btnEditProItem" value="update"/>
        </form>

    </body>
</html>
