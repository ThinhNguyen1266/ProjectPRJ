<%-- 
    Document   : edit
    Created on : Jul 5, 2024, 1:37:12 PM
    Author     : Thinh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
    </head>
    <body>
        <div id="manage-products" class="bg-white shadow-md rounded-lg overflow-hidden mb-8 p-8">
        <h3 class="text-xl font-bold text-gray-800">Manage Products</h3>
        <table class="min-w-full leading-normal mt-4">
            <thead>
                <tr>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Product ID</th>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Product Name</th>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Description</th>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Image</th>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Price</th>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Quantity</th>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Category</th>
                    <th class="px-5 py-3 border-b-2 border-gray-200 bg-gray-100 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Actions</th>
                </tr>
            </thead>
            <tbody>
                <!-- Placeholder for server-side generated content -->
                <tr>
                    <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">1</td>
                    <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">Product 1</td>
                    <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">Description 1</td>
                    <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm"><img src="image1.jpg" alt="Product 1 Image" class="w-16 h-16"></td>
                    <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">$10.00</td>
                    <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">100</td>
                    <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">Category 1</td>
                    <td class="px-5 py-5 border-b border-gray-200 bg-white text-sm">
                        <button class="bg-yellow-500 hover:bg-yellow-700 text-white font-bold py-1 px-2 rounded" onclick="openEditModal('1', 'Product 1', 'Description 1', 'image1.jpg', '$10.00', '100', 'Category 1')">Edit</button>
                        <button class="bg-red-500 hover:bg-red-700 text-white font-bold py-1 px-2 rounded">Delete</button>
                    </td>
                </tr>
                <!-- More rows as needed -->
            </tbody>
        </table>
    </div>

    <!-- Edit Modal -->
    <div id="edit-modal" class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full hidden">
        <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white">
            <h3 class="text-xl font-bold text-gray-800 mb-4">Edit Product</h3>
            <form id="edit-form">
                <input type="hidden" id="edit-product-id">
                <div class="mb-4">
                    <label for="edit-product-name" class="block text-gray-700 text-sm font-bold mb-2">Product Name:</label>
                    <input type="text" id="edit-product-name" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                </div>
                <div class="mb-4">
                    <label for="edit-product-description" class="block text-gray-700 text-sm font-bold mb-2">Description:</label>
                    <textarea id="edit-product-description" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"></textarea>
                </div>
                <div class="mb-4">
                    <label for="edit-product-image" class="block text-gray-700 text-sm font-bold mb-2">Image URL:</label>
                    <input type="text" id="edit-product-image" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                </div>
                <div class="mb-4">
                    <label for="edit-product-price" class="block text-gray-700 text-sm font-bold mb-2">Price:</label>
                    <input type="text" id="edit-product-price" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                </div>
                <div class="mb-4">
                    <label for="edit-product-quantity" class="block text-gray-700 text-sm font-bold mb-2">Quantity:</label>
                    <input type="text" id="edit-product-quantity" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                </div>
                <div class="mb-4">
                    <label for="edit-product-category" class="block text-gray-700 text-sm font-bold mb-2">Category:</label>
                    <input type="text" id="edit-product-category" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                </div>
                <div class="flex items-center justify-between">
                    <button type="button" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" onclick="saveEdit()">Save</button>
                    <button type="button" class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" onclick="closeEditModal()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openEditModal(id, name, description, image, price, quantity, category) {
            document.getElementById('edit-product-id').value = id;
            document.getElementById('edit-product-name').value = name;
            document.getElementById('edit-product-description').value = description;
            document.getElementById('edit-product-image').value = image;
            document.getElementById('edit-product-price').value = price;
            document.getElementById('edit-product-quantity').value = quantity;
            document.getElementById('edit-product-category').value = category;
            document.getElementById('edit-modal').classList.remove('hidden');
        }

        function closeEditModal() {
            document.getElementById('edit-modal').classList.add('hidden');
        }

        function saveEdit() {
            // Implement save functionality here
            closeEditModal();
        }
    </script>
    </body>
</html>
