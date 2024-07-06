<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Product</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }
            .container {
                width: 80%;
                margin: 20px auto;
                overflow: hidden;
            }
            .form-container {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                display: flex;
                gap: 20px;
            }
            .form-container h3 {
                margin-bottom: 20px;
                font-size: 24px;
                color: #333;
            }
            .form-container label {
                display: block;
                font-weight: bold;
                color: #555;
                margin-bottom: 5px;
            }
            .form-container input,
            .form-container textarea,
            .form-container select {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
            }
            .form-container input[type="number"] {
                width: calc(100% - 22px);
            }
            .form-container button {
                background: #007bff;
                color: #fff;
                border: none;
                padding: 10px 20px;
                cursor: pointer;
                font-size: 16px;
                border-radius: 4px;
                transition: background 0.3s ease;
            }
            .form-container button:hover {
                background: #0056b3;
            }
            .flex {
                display: flex;
                justify-content: space-between;
            }
            .flex > div {
                flex: 1;
                margin-right: 10px;
            }
            .flex > div:last-child {
                margin-right: 0;
            }
            .img-container {
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
            }
            .img-container img {
                max-width: 100%;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .form-content {
                flex: 2;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="form-container">
                <div class="img-container">
                    <img src="https://via.placeholder.com/600" alt="Product Image">
                </div>
                <div class="form-content">
                    <h3>Edit Product</h3>
                    <form method="post" action="/ProductController">
                        <label for="product-ID">Product ID</label>
                        <input id="product-ID" type="text" placeholder="Product ID" name="proID" value="Pre-filled Product ID" readonly>

                        <label for="product-name">Product Name</label>
                        <input id="product-name" type="text" placeholder="Product Name" name="proName" value="Pre-filled Product Name">

                        <label for="product-description">Product Description</label>
                        <textarea id="product-description" placeholder="Product Description" name="proDes">Pre-filled Product Description</textarea>

                        <label for="product-quantity">Product Quantity</label>
                        <input id="product-quantity" type="number" placeholder="Product Quantity" name="proQuan" value="Pre-filled Product Quantity">

                        <div class="flex">
                            <div>
                                <label for="product-category">Product Category</label>
                                <select id="product-category" data-nextcombo="#product-subcategory">
                                    <option value="">Select Category</option>
                                    <option value="1" data-id="1" data-option="-1">Category 1</option>
                                    <option value="2" data-id="2" data-option="-1">Category 2</option>
                                    <option value="3" data-id="3" data-option="-1">Category 3</option>
                                </select>
                            </div>
                            <div>
                                <label for="product-subcategory">Product Subcategory</label>
                                <select id="product-subcategory" disabled>
                                    <option value="">Select Subcategory</option>
                                    <option value="1" data-id="1" data-option="1">Subcategory 1-1</option>
                                    <option value="2" data-id="2" data-option="1">Subcategory 1-2</option>
                                    <option value="3" data-id="3" data-option="2">Subcategory 2-1</option>
                                    <option value="4" data-id="4" data-option="3">Subcategory 3-1</option>
                                </select>
                            </div>
                        </div>
                        <button type="submit">Update Product</button>
                    </form>
                </div>
            </div>
        </div>

        <script>
            document.getElementById('product-category').addEventListener('change', function () {
                var category = this.value;
                var subcategorySelect = document.getElementById('product-subcategory');
                subcategorySelect.disabled = false;
                var options = subcategorySelect.options;
                for (var i = 0; i < options.length; i++) {
                    if (options[i].getAttribute('data-option') == category) {
                        options[i].style.display = 'block';
                    } else {
                        options[i].style.display = 'none';
                    }
                }
            });

            // Pre-select category and subcategory if values are known
            document.getElementById('product-category').value = "Pre-filled Category ID";
            document.getElementById('product-category').dispatchEvent(new Event('change'));
            document.getElementById('product-subcategory').value = "Pre-filled Subcategory ID";
        </script>
    </body>
</html>
