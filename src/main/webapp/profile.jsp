

<%-- 
    Document   : profile
    Created on : Jul 3, 2024, 9:27:35 PM
    Author     : AnhNLCE181837
--%>

<%@page import="DAOs.UserDAO"%>
<%@page import="Models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>User Profile</title>
        <link
            href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
            rel="stylesheet">
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css"
            rel="stylesheet">
        <style>
            body {
                background: #f5f5f5;
                margin-top: 20px;
            }

            .ui-w-80 {
                width : 80px !important;
                height: auto;
            }

            .btn-default {
                border-color: rgba(24, 28, 33, 0.1);
                background  : rgba(0, 0, 0, 0);
                color       : #4E5155;
            }

            label.btn {
                margin-bottom: 0;
            }

            .btn-outline-primary {
                border-color: #26B4FF;
                background  : transparent;
                color       : #26B4FF;
            }

            .btn {
                cursor: pointer;
            }

            .text-light {
                color: #babbbc !important;
            }

            .btn-facebook {
                border-color: rgba(0, 0, 0, 0);
                background  : #3B5998;
                color       : #fff;
            }

            .btn-instagram {
                border-color: rgba(0, 0, 0, 0);
                background  : #000;
                color       : #fff;
            }

            .card {
                background-clip: padding-box;
                box-shadow     : 0 1px 4px rgba(24, 28, 33, 0.012);
            }

            .row-bordered {
                overflow: hidden;
            }

            .account-settings-fileinput {
                position  : absolute;
                visibility: hidden;
                width     : 1px;
                height    : 1px;
                opacity   : 0;
            }

            .account-settings-links .list-group-item.active {
                font-weight: bold !important;
            }

            html:not(.dark-style) .account-settings-links .list-group-item.active {
                background: transparent !important;
            }

            .account-settings-multiselect~.select2-container {
                width: 100% !important;
            }

            .light-style .account-settings-links .list-group-item {
                padding     : 0.85rem 1.5rem;
                border-color: rgba(24, 28, 33, 0.03) !important;
            }

            .light-style .account-settings-links .list-group-item.active {
                color: #4e5155 !important;
            }

            .material-style .account-settings-links .list-group-item {
                padding     : 0.85rem 1.5rem;
                border-color: rgba(24, 28, 33, 0.03) !important;
            }

            .material-style .account-settings-links .list-group-item.active {
                color: #4e5155 !important;
            }

            .dark-style .account-settings-links .list-group-item {
                padding     : 0.85rem 1.5rem;
                border-color: rgba(255, 255, 255, 0.03) !important;
            }

            .dark-style .account-settings-links .list-group-item.active {
                color: #fff !important;
            }

            .light-style .account-settings-links .list-group-item.active {
                color: #4E5155 !important;
            }

            .light-style .account-settings-links .list-group-item {
                padding     : 0.85rem 1.5rem;
                border-color: rgba(24, 28, 33, 0.03) !important;
            }
        </style>
    </head>
    <body class="bg-ADBBDA-100">
        <header class="bg-white shadow-md fixed top-0 left-0 w-full z-50">
            <div class="mx-auto px-4 py-4 flex justify-between items-center">
                <a href="/ProductController/List" class="text-2xl font-bold text-gray-900">ShopName</a>
                <div class="flex space-x-4">
                    <a href="/ProductController/About-Contact" class="text-gray-800 hover:text-gray-600">About/Contact</a>
                    <a href="/ProductController/Cart" class="text-gray-800 hover:text-gray-600">Cart</a>
                    <%
                        String customerName = (String) session.getAttribute("customername");
                        User user = null;
                        if (customerName != null) {
                            user = new User();
                            UserDAO userDAO = new UserDAO();
                            user = userDAO.getUser(customerName);
                            user = new User();

                            user = userDAO.getUser(customerName);
                    %>
                    <div class="relative inline-block text-left">
                        <button onclick="toggleDropdown()" class="text-gray-800 hover:text-gray-600">
                            <%= customerName%>
                        </button>
                        <div id="dropdownMenu" class="dropdown-menu hidden absolute right-0 mt-2 w-48 bg-white border border-gray-200 rounded-md shadow-lg">
                            <a href="/AccountController/Profile" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">Profile</a>
                            <a href="/AccountController/Logout" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">Sign Out</a>
                        </div>
                    </div>

                    <% } else { %>
                    <a href="/AccountController/Login" class="text-gray-800 hover:text-gray-600">Login</a>
                    <% }%>
                </div>

                <script>
                    function toggleDropdown() {
                        var dropdownMenu = document.getElementById("dropdownMenu");
                        dropdownMenu.classList.toggle("hidden");
                    }

                    // Close the dropdown if the user clicks outside of it
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
        <div class="container light-style flex-grow-1 container-p-y">
            <h4 class="font-weight-bold py-3 mb-4">
                Account settings
            </h4>
            <div class="card overflow-hidden">
                <div class="row no-gutters row-bordered row-border-light">
                    <div class="col-md-3 pt-0">
                        <div
                            class="list-group list-group-flush account-settings-links">
                            <a
                                class="list-group-item list-group-item-action active"
                                data-toggle="list"
                                href="#account-general">General</a>
                            <a class="list-group-item list-group-item-action"
                               data-toggle="list"
                               href="#account-change-password">Change
                                password</a>
                            <a class="list-group-item list-group-item-action"
                               data-toggle="list"
                               href="#account-info">Info</a>
                            <a class="list-group-item list-group-item-action"
                               data-toggle="list"
                               href="#account-social-links">Social links</a>
                            <a class="list-group-item list-group-item-action"
                               data-toggle="list"
                               href="#account-connections">Connections</a>
                            <a class="list-group-item list-group-item-action"
                               data-toggle="list"
                               href="#account-notifications">Notifications</a>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="tab-content">
                            <div class="tab-pane fade active show"
                                 id="account-general">
                                <hr class="border-light m-0">
                                <div class="profile-section">
                                    <p><strong>Name:<%= (user == null) ? "" : user.getName()%></strong> <!-- User Name --></p>
                                    <p><strong>Email: :<%= (user == null) ? "" : user.getEmails()%></strong> <!-- User Email --></p>
                                    <p><strong>Phone Number: :<%= (user == null) ? "" : user.getPhoneNumber()%></strong> <!-- User Phone Number --></p>
                                    <p><strong>Default Address: :<%= (user == null) ? "" : user.getAddress().getAddress()%></strong>
                                </div>
                            </div>
                            <div class="tab-pane fade"
                                 id="account-change-password">
                                <div class="card-body pb-2">
                                    <div class="form-group">
                                        <label class="form-label">Current
                                            password</label>
                                        <input type="password"
                                               class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">New
                                            password</label>
                                        <input type="password"
                                               class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Repeat new
                                            password</label>
                                        <input type="password"
                                               class="form-control">
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="account-info">
                                <div class="card-body pb-2">
                                    <div class="form-group">
                                        <label class="form-label">Bio</label>
                                        <textarea class="form-control"
                                                  rows="5">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris nunc arcu, dignissim sit amet sollicitudin iaculis, vehicula id urna. Sed luctus urna nunc. Donec fermentum, magna sit amet rutrum pretium, turpis dolor molestie diam, ut lacinia diam risus eleifend sapien. Curabitur ac nibh nulla. Maecenas nec augue placerat, viverra tellus non, pulvinar risus.</textarea>
                                    </div>
                                    <div class="form-group">
                                        <label
                                            class="form-label">Birthday</label>
                                        <input type="text" class="form-control"
                                               value="May 3, 1995">
                                    </div>
                                    <div class="form-group">
                                        <label
                                            class="form-label">Country</label>
                                        <select class="custom-select">
                                            <option>USA</option>
                                            <option selected>Canada</option>
                                            <option>UK</option>
                                            <option>Germany</option>
                                            <option>France</option>
                                        </select>
                                    </div>
                                </div>
                                <hr class="border-light m-0">
                                <div class="card-body pb-2">
                                    <h6 class="mb-4">Contacts</h6>
                                    <div class="form-group">
                                        <label class="form-label">Phone</label>
                                        <input type="text" class="form-control"
                                               value="+0 (123) 456 7891">
                                    </div>
                                    <div class="form-group">
                                        <label
                                            class="form-label">Website</label>
                                        <input type="text" class="form-control"
                                               value>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade"
                                 id="account-social-links">
                                <div class="card-body pb-2">
                                    <div class="form-group">
                                        <label
                                            class="form-label">Twitter</label>
                                        <input type="text" class="form-control"
                                               value="https://twitter.com/user">
                                    </div>
                                    <div class="form-group">
                                        <label
                                            class="form-label">Facebook</label>
                                        <input type="text" class="form-control"
                                               value="https://www.facebook.com/user">
                                    </div>
                                    <div class="form-group">
                                        <label
                                            class="form-label">Google+</label>
                                        <input type="text" class="form-control"
                                               value>
                                    </div>
                                    <div class="form-group">
                                        <label
                                            class="form-label">LinkedIn</label>
                                        <input type="text" class="form-control"
                                               value>
                                    </div>
                                    <div class="form-group">
                                        <label
                                            class="form-label">Instagram</label>
                                        <input type="text" class="form-control"
                                               value="https://www.instagram.com/user">
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="account-connections">
                                <div class="card-body">
                                    <button type="button"
                                            class="btn btn-twitter">Connect to
                                        <strong>Twitter</strong></button>
                                </div>
                                <hr class="border-light m-0">
                                <div class="card-body">
                                    <h5 class="mb-2">
                                        <a href="javascript:void(0)"
                                           class="float-right text-muted text-tiny"><i
                                                class="ion ion-md-close"></i>
                                            Remove</a>
                                        <i
                                            class="ion ion-logo-google text-google"></i>
                                        You are connected to Google:
                                    </h5>
                                    <a href="/cdn-cgi/l/email-protection"
                                       class="__cf_email__"
                                       data-cfemail="f9979498818e9c9595b994989095d79a9694">[email&#160;protected]</a>
                                </div>
                                <hr class="border-light m-0">
                                <div class="card-body">
                                    <button type="button"
                                            class="btn btn-facebook">Connect to
                                        <strong>Facebook</strong></button>
                                </div>
                                <hr class="border-light m-0">
                                <div class="card-body">
                                    <button type="button"
                                            class="btn btn-instagram">Connect to
                                        <strong>Instagram</strong></button>
                                </div>
                            </div>
                            <div class="tab-pane fade"
                                 id="account-notifications">
                                <div class="card-body pb-2">
                                    <h6 class="mb-4">Activity</h6>
                                    <div class="form-group">
                                        <label class="switcher">
                                            <input type="checkbox"
                                                   class="switcher-input" checked>
                                            <span class="switcher-indicator">
                                                <span
                                                    class="switcher-yes"></span>
                                                <span
                                                    class="switcher-no"></span>
                                            </span>
                                            <span class="switcher-label">Email
                                                me when someone comments on my
                                                article</span>
                                        </label>
                                    </div>
                                    <div class="form-group">
                                        <label class="switcher">
                                            <input type="checkbox"
                                                   class="switcher-input" checked>
                                            <span class="switcher-indicator">
                                                <span
                                                    class="switcher-yes"></span>
                                                <span
                                                    class="switcher-no"></span>
                                            </span>
                                            <span class="switcher-label">Email
                                                me when someone answers on my
                                                forum
                                                thread</span>
                                        </label>
                                    </div>
                                    <div class="form-group">
                                        <label class="switcher">
                                            <input type="checkbox"
                                                   class="switcher-input">
                                            <span class="switcher-indicator">
                                                <span
                                                    class="switcher-yes"></span>
                                                <span
                                                    class="switcher-no"></span>
                                            </span>
                                            <span class="switcher-label">Email
                                                me when someone follows
                                                me</span>
                                        </label>
                                    </div>
                                </div>
                                <hr class="border-light m-0">
                                <div class="card-body pb-2">
                                    <h6 class="mb-4">Application</h6>
                                    <div class="form-group">
                                        <label class="switcher">
                                            <input type="checkbox"
                                                   class="switcher-input" checked>
                                            <span class="switcher-indicator">
                                                <span
                                                    class="switcher-yes"></span>
                                                <span
                                                    class="switcher-no"></span>
                                            </span>
                                            <span class="switcher-label">News
                                                and announcements</span>
                                        </label>
                                    </div>
                                    <div class="form-group">
                                        <label class="switcher">
                                            <input type="checkbox"
                                                   class="switcher-input">
                                            <span class="switcher-indicator">
                                                <span
                                                    class="switcher-yes"></span>
                                                <span
                                                    class="switcher-no"></span>
                                            </span>
                                            <span class="switcher-label">Weekly
                                                product updates</span>
                                        </label>
                                    </div>
                                    <div class="form-group">
                                        <label class="switcher">
                                            <input type="checkbox"
                                                   class="switcher-input" checked>
                                            <span class="switcher-indicator">
                                                <span
                                                    class="switcher-yes"></span>
                                                <span
                                                    class="switcher-no"></span>
                                            </span>
                                            <span class="switcher-label">Weekly
                                                blog digest</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-right mt-3">
                <a class="btn btn-secondary" href="/AccountController/Edit/<%= customerName%>">Edit</a>
                <button type="button" class="btn btn-default">Cancel</button>
            </div>
        </div>
        <script data-cfasync="false"
        src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
        <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
        <script type="text/javascript">

        </script>
    </body>

</html>
