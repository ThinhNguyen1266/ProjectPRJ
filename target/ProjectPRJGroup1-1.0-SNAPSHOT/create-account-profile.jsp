<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Account Profile</title>
        <link
            href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
            rel="stylesheet">
    </head>
    <body class="bg-gray-100">
        <!-- Header -->
        <header class="bg-white shadow-md fixed top-0 left-0 w-full z-40">
            <div class="mx-auto px-4 py-4 flex justify-between items-center">
                <a href="/Index"
                   class="text-xl font-bold text-gray-800">ShopName</a>
            </div>
        </header>
        <!-- Create Account Form -->
        <section class="py-12 mt-16">
            <div class="container mx-auto px-4 max-w-md">
                <h2 class="text-2xl font-bold text-gray-800 text-center">Create
                    Account</h2>
                <form class="bg-white shadow-md rounded-lg p-8 mt-8">
                    <div class="mb-4">

                        <label
                            class="block text-gray-700 text-sm font-bold mb-2"
                            for="name">Name</label>
                        <input
                            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                            id="name" type="text" placeholder="Name">
                    </div>
                    <div class="mb-4">
                        <label
                            class="block text-gray-700 text-sm font-bold mb-2"
                            for="email">Email</label>
                        <input
                            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                            id="email" type="email" placeholder="Email">
                    </div>
                    <div class="mb-4">
                        <label
                            class="block text-gray-700 text-sm font-bold mb-2"
                            for="Phone number">Phone number</label>
                        <input
                            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                            id="Phone number" type="email"
                            placeholder="Phone number">
                    </div>
                    <div class="mb-4">
                        <label
                            class="block text-gray-700 text-sm font-bold mb-2"
                            for="Address">Address</label>
                        <input
                            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                            id="Address" type="Address" placeholder="Address">
                    </div>

                    <div class="flex items-center justify-between">
                        <a href="/Index" class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline inline-block text-center">
                            sign-in</a>
                        </a>
                        <a href="/Login" class="bg-gray-800 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline inline-block text-center">
                            have an account? Login
                        </a>

                    </div>
                </form>
            </div>
        </section>

        <!-- Footer -->
        <!--<footer class="bg-gray-800 text-white py-8">
            <div class="container mx-auto px-4 text-center">
                <p>&copy; 2024 ShopName. All rights reserved.</p>
                <div class="mt-4 space-x-4">
                    <a href="#" class="hover:text-gray-400">Privacy Policy</a>
                    <a href="#" class="hover:text-gray-400">Terms of Service</a>
                </div>
            </div>
        </footer>-->
    </body>
</html>
