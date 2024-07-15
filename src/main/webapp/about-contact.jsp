<%@page import="java.sql.ResultSet"%>
<%@page import="DAOs.CategoryDAO"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>About & Contact</title>
        <!-- Font Awesome 5.15.4 -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        
        <!-- Tailwind CSS 2.2.19 -->
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">

        <!-- Bootstrap JS -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <!-- jQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

        <!-- Font Awesome Kit -->
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>

        <!-- Google Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        
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
            .dropdown-menu {
                display: none;
                position: absolute;
                right: 0;
                margin-top: 10px;
                width: 200px;
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 3px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                z-index: 1000;
            }
            .dropdown-menu.show {
                display: block;
            }
            .dropdown-menu a {
                display: block;
                padding: 10px;
                color: #333;
                text-decoration: none;
            }
            .dropdown-menu a:hover {
                background-color: #f0f0f0;
            }
            .footer {
                padding: 20px;
                display: flex;
                justify-content: space-between;
                background-color: #2d3748;
                color: white;
            }
            .footer-column {
                flex: 1;
                margin: 0 10px;
            }
            .footer-column h3 {
                font-size: 1.2em;
                margin-bottom: 10px;
            }
            .footer-column ul {
                list-style-type: none;
                padding: 0;
            }
            .footer-column ul li {
                margin-bottom: 5px;
            }
            .footer-column ul li a {
                text-decoration: none;
                color: white;
            }
            .footer-column ul li a:hover {
                text-decoration: underline;
            }
            .payment-methods i {
                font-size: 24px;
                margin-right: 10px;
            }
        </style>
    </head>
    <body class="bg-gray-100">
        <!-- Header -->
        <header class="bg-white shadow-md fixed top-0 left-0 w-full z-50">
            <div class="mx-auto px-4 py-4 flex justify-between items-center">
                <a href="/ProductController/List" class="text-2xl font-bold text-gray-900">Zootech</a>
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
                    <% }%>
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

        <!-- About Section -->
        <section class="py-12 mt-16">
            <div class="container mx-auto px-4">
                <h2 class="text-3xl font-bold text-gray-800 text-center mb-6">About Us</h2>
                <div class="text-center mb-8">
                    <h3 class="text-xl font-semibold">Welcome to Our Web!</h3>
                    <p class="text-gray-700 mt-2">At [Company Name], we are a close-knit team of four dedicated professionals, each bringing unique skills and perspectives to create innovative solutions. Meet our team:</p>
                </div>
                <div class="mb-8">
                    <h4 class="text-lg font-semibold">1. nguyen le anh - CEO & Founder</h4>
                    <p class="text-gray-700 mt-2">With over 15 years of experience in the industry, anh is the visionary leader behind our company. His expertise in strategic planning and business development has been instrumental in driving our success. anh is passionate about innovation and committed to fostering a culture of excellence and collaboration within our team.</p>
                </div>
                <div class="mb-8">
                    <h4 class="text-lg font-semibold">2. nguyen cuong thinh - Chief Technology Officer (CTO)</h4>
                    <p class="text-gray-700 mt-2">thinh is the tech genius who leads our development team. With a strong background in software engineering and a knack for solving complex problems, she ensures our products are not only cutting-edge but also reliable and user-friendly. His innovative mindset and technical expertise are the backbone of our technical endeavors.</p>
                </div>
                <div class="mb-8">
                    <h4 class="text-lg font-semibold">3. nguyen huynh duc - Head of Marketing</h4>
                    <p class="text-gray-700 mt-2">duc is the creative force behind our brand. His extensive experience in marketing and communication helps us effectively connect with our audience. He is responsible for developing and implementing our marketing strategies, ensuring that our message resonates with our customers and drives engagement.</p>
                </div>
                <div class="mb-8">
                    <h4 class="text-lg font-semibold">4. huynh quoc cuong - Customer Success Manager</h4>
                    <p class="text-gray-700 mt-2">cuong is our customer advocate, dedicated to ensuring that our clients have the best possible experience with our products and services. his exceptional interpersonal skills and customer-focused approach help us build strong, lasting relationships with our clients, ensuring their satisfaction and success.</p>
                </div>
                <div class="text-center mb-8">
                    <h3 class="text-xl font-semibold">Our Mission</h3>
                    <p class="text-gray-700 mt-2">We are committed to delivering high-quality solutions that meet the evolving needs of our clients. Our mission is to combine innovation, expertise, and dedication to create products that make a difference. We believe in the power of teamwork and are passionate about what we do.</p>
                </div>
                <div class="text-center mb-8">
                    <h3 class="text-xl font-semibold">Our Values</h3>
                    <p class="text-gray-700 mt-2"><strong>Innovation:</strong> We strive to stay ahead of the curve by embracing new ideas and technologies.</p>
                    <p class="text-gray-700 mt-2"><strong>Excellence:</strong> We are dedicated to delivering the highest quality in everything we do.</p>
                    <p class="text-gray-700 mt-2"><strong>Collaboration:</strong> We believe that teamwork and open communication are key to our success.</p>
                    <p class="text-gray-700 mt-2"><strong>Customer Focus:</strong> Our clients are at the heart of our business, and we are committed to their satisfaction.</p>
                </div>
                <div class="text-center mb-8">
                    <h3 class="text-xl font-semibold">Join Us on Our Journey</h3>
                    <p class="text-gray-700 mt-2">We are excited to continue growing and evolving, and we invite you to join us on this journey. Whether you are a client, partner, or team member, we are thrilled to have you with us. Together, we can achieve great things.</p>
                </div>
                <div class="mt-8">
                    <img src="imgDontTouch!/cool.png" alt="About Image" class="w-full h-64 object-cover rounded-lg shadow-md">
                </div>
            </div>
        </section>

        <!-- Contact Section -->
        <section class="py-12 bg-gray-100">
            <div class="container mx-auto px-4">
                <h2 class="text-3xl font-bold text-gray-800 text-center mb-6">Contact Us</h2>
                <form class="bg-white shadow-md rounded-lg p-8 mt-8 max-w-md mx-auto">
                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="name">Name</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="name" type="text" placeholder="Name">
                    </div>
                    <div class="mb-4">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="email">Email</label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="email" type="email" placeholder="Email">
                    </div>
                    <div class="mb-6">
                        <label class="block text-gray-700 text-sm font-bold mb-2" for="message">Message</label>
                        <textarea class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="message" rows="4" placeholder="Message"></textarea>
                    </div>
                    <div class="flex items-center justify-between">
                        <button class="bg-gray-900 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="button">Send Message</button>
                    </div>
                </form>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer">
            <div class="footer-column">
                <h3>Product</h3>
                <ul>
                    <% CategoryDAO dao = new CategoryDAO();
                        ResultSet rs = dao.getAllCategoriesNull();
                        while (rs.next()) {%>
                    <li><a href="/ProductController/Category/<%= rs.getInt("id")%>"><%= rs.getString("name")%></a></li>
                        <%}%>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Help</h3>
                <ul>
                    <li><a href="#">FAQ</a></li>
                    <li><a href="#">Shipping</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>About</h3>
                <ul>
                    <li><a href="/ProductController/About-Contact">Contact Us</a></li>
                    <li><a href="/ProductController/About-Contact">About Us</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>Payment method</h3>
                <div class="payment-methods">
                    <i class="fab fa-cc-visa"></i>
                    <i class="fab fa-cc-paypal"></i>
                    <i class="fab fa-cc-mastercard"></i>
                    <i class="fab fa-apple-pay"></i>
                </div>
            </div>
        </footer>
    </body>
</html>
