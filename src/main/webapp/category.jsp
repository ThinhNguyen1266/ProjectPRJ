<%-- 
    Document   : Category
    Created on : Jul 1, 2024, 9:30:50 PM
    Author     : AnhNLCE181837
--%>

<%@page import="DAOs.ProductItemDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.CategoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Products</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            .search-container {
                display: flex;
                align-items: center;
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 3px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }
            .search-container input[type="text"] {
                width: 400px;
                padding: 10px;
                border: none;
                outline: none;
                font-size: 16px;
            }
            .search-container button {
                padding: 10px 15px;
                border: none;
                background-color: #f8f8f8;
                cursor: pointer;
                border-left: 1px solid #ccc;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .search-container button:hover {
                background-color: #f0f0f0;
            }
            .search-container button i {
                font-size: 16px;
                color: #333;
            }
            .product-card .flex {
                height: 200px;
            }
            .product-card img {
                width: 90%;
                height: 90%;
                object-fit: contain; /* Use 'contain' to ensure the image fits within the box without being cropped */
                max-height: 100%;
            }

            .product-card {
                display: flex;
                flex-direction: column;
                justify-content: center; /* Center content vertically */
                height: 100%;
            }

            .product-name {
                height: 2.5em; /* Adjust as needed */
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            .product-details {
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                justify-content: center; /* Center product details vertically */
                text-align: center; /* Center text horizontally */
            }

            .add-to-cart {
                align-self: center; /* Center button horizontally */
                margin-top: 1em; /* Add some margin to separate it from details */
            }
        </style>
    </head>
    <body class="bg-gray-100">
        <!-- Header -->
        <header class="bg-white shadow-md fixed top-0 left-0 w-full z-50">
            <div class="mx-auto px-4 py-4 flex justify-between items-center">
                <a href="/ProductController/List" class="text-2xl font-bold text-gray-900">ShopName</a>
                <form method="post" class="search-container" action="/ProductController/Search">
                    <input type="text" name="txtSearchName" placeholder="Search..">
                    <button type="submit" name="btnSearch"><i class="fa fa-search"></i></button>
                </form>
                <div class="flex space-x-4">
                    <a href="/ProductController/About-Contact" class="text-gray-800 hover:text-gray-600">
                        <i class="fas fa-user"></i> About/ <i class="fas fa-envelope"></i> Contact
                    </a>
                    <a href="/ProductController/Cart" class="text-gray-800 hover:text-gray-600">
                        <i class="fa fa-shopping-cart"></i> Cart
                    </a>
                    <% String customerName = (String) session.getAttribute("customername");
                        if (customerName != null) {%>
                    <div class="relative inline-block text-left">
                        <button onclick="toggleDropdown()" class="text-gray-800 hover:text-gray-600">
                            <i class="fa fa-user-circle-o"></i> <%= customerName%>
                        </button>
                        <div id="dropdownMenu" class="dropdown-menu hidden absolute right-0 mt-2 w-48 bg-white border border-gray-200 rounded-md shadow-lg">
                            <a href="/AccountController/Profile" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                                <i class='fas fa-user-alt'></i> Profile
                            </a>
                            <a href="/AccountController/Logout" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                                <i class="fa fa-sign-out"></i> Sign Out
                            </a>
                        </div>
                    </div>
                    <% } else { %>
                    <a href="/AccountController/Login" class="text-gray-800 hover:text-gray-600">
                        <i class="fa fa-sign-in"></i> Login
                    </a>
                    <% } %>
                </div>
                <script>
                    function toggleDropdown() {
                        var dropdownMenu = document.getElementById("dropdownMenu");
                        dropdownMenu.classList.toggle("hidden");
                    }
                    window.onclick = function (event) {
                        if (!event.target.matches('button')) {
                            var dropdowns = document.getElementsByClassName("dropdown-menu");
                            for (var i = 0; i < dropdowns.length; i++) {
                                var openDropdown = dropdowns[i];
                                if (!openDropdown.classList.contains('hidden')) {
                                    openDropdown.classList.add('hidden');
                                }
                            }
                        }
                    }
                </script>
            </div>
        </header>
        <div class="container mx-auto px-4 py-8 mt-20">
            <aside class="fixed inset-y-0 left-0 w-60 bg-gray-800 text-black shadow-lg h-screen">
                <div class="p-4">
                    <h2 class="text-xl font-bold mb-4">Laptop Filters</h2>
                    <ul class="space-y-2">
                        <li>
                            <section class="bg-white shadow-md py-4 mt-16">
                                <div class="container mx-auto px-4">
                                    <ul class="space-y-4">
                                        <li>
                                            <label for="sort" class="block text-black">Sắp xếp theo</label>
                                            <select id="sort" name="sort" class="filter-select" onchange="showSortValue()">
                                                <option value="default">Sắp xếp theo</option>
                                                <option value="asc">Ascending</option>
                                                <option value="desc">Descending</option>
                                            </select>
                                        </li>
                                        <li>
                                            <label class="block text-black">RAM</label>
                                            <div>
                                                <input type="checkbox" id="ram-8GB" name="ram" value="8GB" onchange="showFilterValue('ram')">
                                                <label for="ram-8GB">8GB</label>
                                            </div>
                                            <div>
                                                <input type="checkbox" id="ram-16GB" name="ram" value="16GB" onchange="showFilterValue('ram')">
                                                <label for="ram-16GB">16GB</label>
                                            </div>
                                            <div>
                                                <input type="checkbox" id="ram-32GB" name="ram" value="32GB" onchange="showFilterValue('ram')">
                                                <label for="ram-32GB">32GB</label>
                                            </div>
                                        </li>
                                        <li>
                                            <label class="block text-black">CPU</label>
                                            <div>
                                                <input type="checkbox" id="cpu-i5" name="cpu" value="i5" onchange="showFilterValue('cpu')">
                                                <label for="cpu-i5">Intel i5</label>
                                            </div>
                                            <div>
                                                <input type="checkbox" id="cpu-i7" name="cpu" value="i7" onchange="showFilterValue('cpu')">
                                                <label for="cpu-i7">Intel i7</label>
                                            </div>
                                            <div>
                                                <input type="checkbox" id="cpu-i9" name="cpu" value="i9" onchange="showFilterValue('cpu')">
                                                <label for="cpu-i9">Intel i9</label>
                                            </div>
                                        </li>
                                        <li>
                                            <label class="block text-black">GPU</label>
                                            <div>
                                                <input type="checkbox" id="gpu-GTX1650" name="gpu" value="GTX1650" onchange="showFilterValue('gpu')">
                                                <label for="gpu-GTX1650">NVIDIA GTX 1650</label>
                                            </div>
                                            <div>
                                                <input type="checkbox" id="gpu-RTX2060" name="gpu" value="RTX2060" onchange="showFilterValue('gpu')">
                                                <label for="gpu-RTX2060">NVIDIA RTX 2060</label>
                                            </div>
                                            <div>
                                                <input type="checkbox" id="gpu-RTX3080" name="gpu" value="RTX3080" onchange="showFilterValue('gpu')">
                                                <label for="gpu-RTX3080">NVIDIA RTX 3080</label>
                                            </div>
                                        </li>
                                        <li>
                                            <label class="block text-black">Giá</label>
                                            <div>
                                                <input type="checkbox" id="price-0-1000" name="price" value="0-1000" onchange="showFilterValue('price')">
                                                <label for="price-0-1000">0-1000</label>
                                            </div>
                                            <div>
                                                <input type="checkbox" id="price-1000-2000" name="price" value="1000-2000" onchange="showFilterValue('price')">
                                                <label for="price-1000-2000">1000-2000</label>
                                            </div>
                                            <div>
                                                <input type="checkbox" id="price-2000-3000" name="price" value="2000-3000" onchange="showFilterValue('price')">
                                                <label for="price-2000-3000">2000-3000</label>
                                            </div>
                                        </li>
                                    </ul>
                                    <div id="sort-value" class="mt-4 text-sm font-semibold text-black"></div>
                                    <div id="filter-values" class="mt-4 text-sm font-semibold text-black"></div>
                                </div>
                            </section>
                        </li>
                    </ul>
                </div>
            </aside>
            <script>
                function showSortValue() {
                    const sortSelect = document.getElementById('sort');
                    const sortValue = sortSelect.options[sortSelect.selectedIndex].text;
                    document.getElementById('sort-value').innerText = 'Sắp xếp theo: ' + sortValue;
                }

                function showFilterValue(filterId) {
                    const checkboxes = document.querySelectorAll(`input[name=${filterId}]:checked`);
                    const selectedValues = Array.from(checkboxes).map(cb => cb.nextSibling.textContent.trim());
                    const filterDisplay = document.getElementById('filter-values');

                    let existingFilters = filterDisplay.innerText.split(', ').filter(Boolean);
                    const filterText = filterId.charAt(0).toUpperCase() + filterId.slice(1) + ': ' + selectedValues.join(', ');

                    const existingIndex = existingFilters.findIndex(f => f.startsWith(filterId.charAt(0).toUpperCase() + filterId.slice(1)));
                    if (existingIndex > -1) {
                        existingFilters[existingIndex] = filterText;
                    } else {
                        existingFilters.push(filterText);
                    }

                    filterDisplay.innerText = existingFilters.join(', ');
                }
            </script>
            <style>
                .filter-select {
                    padding: 0.5rem 1rem;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                    background-color: white;
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                    margin-top: 0.5rem;
                }
            </style>

            <!-- Products Section -->
            <section class="flex-grow ml-64 pl-8" >
                <div class="container mx-auto px-4">
                    <h2 class="text-2xl font-bold text-gray-800 text-center">Our Products</h2>
                    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-8">
                        <%
                            ProductItemDAO pidao = new ProductItemDAO();
                            String id = (String) session.getAttribute("categoryid");
                            ResultSet rs = pidao.getAllByCatParent(id); // Corrected to use category ID
                            while (rs.next()) {
                                String price = rs.getString("price");
                        %>
                        <script>
                            function formatPrice(price) {
                                let parts = price.toString().split(".");
                                parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                return parts.join(".");
                            }

                            document.addEventListener("DOMContentLoaded", function () {
                                // This will run when the page is fully loaded
                                let priceElements = document.querySelectorAll('.product-price');
                                priceElements.forEach(function (priceElement) {
                                    let priceText = priceElement.innerText.trim(); // Assuming price is in innerText
                                    let formattedPrice = formatPrice(priceText);
                                    priceElement.innerText = formattedPrice;
                                });
                            });
                        </script>

                        <div class="bg-white shadow-md rounded-lg overflow-hidden product-card">
                            <a href="/ProductController/View/<%= rs.getString("pro_id")%>">
                                <div class="flex justify-center items-center h-48 w-full">
                                    <img src="<%= rs.getString("image")%>" alt="Product Image" class="object-cover">
                                </div>
                            </a>
                            <div class="p-4 product-details">
                                <h3 class="text-lg font-semibold text-gray-800 product-name"><%= rs.getString("pro_name")%></h3>
                                <p class="product-price text-gray-600 mt-2"><%= price%> vnd</p>
                            </div>
                            <a href="/ProductController/View/<%= rs.getString("pro_id")%>" class="inline-block bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-600 add-to-cart">View</a>
                        </div>
                        <% }%>
                    </div>
                </div>
            </section>
        </div>

        <br><br><br><br><br><br><br><br>
        <br><br><br><br><br><br><br><br>
        <br><br><br><br><br><br><br><br>
        <br><br><br><br><br><br><br><br>

        <!-- Footer -->
        <footer class="bg-gray-800 text-white py-8">
            <div class="container mx-auto px-4 text-center">
                <p>&copy; 2024 ShopName. All rights reserved.</p>
                <div class="mt-4 space-x-4">
                    <a href="#" class="hover:text-gray-400">Privacy Policy</a>
                    <a href="#" class="hover:text-gray-400">Terms of Service</a>
                </div>
            </div>
        </footer>
    </body>
</html>
