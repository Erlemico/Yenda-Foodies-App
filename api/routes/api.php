<?php

// routes/api.php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductsController;
use App\Http\Controllers\CustomersController;
use App\Http\Controllers\StaffController;
use App\Http\Controllers\CartController;


// API Staff
Route::get('/staff', [StaffController::class, 'getAllStaff']);

// staff sign in
Route::post('/staff/signin', [StaffController::class, 'signin']);

// staff forgot password
Route::post('/staff/forgot-password/verify-email', [StaffController::class, 'verifyEmail']);
Route::post('/staff/forgot-password/reset-password', [StaffController::class, 'resetPassword']);
Route::post('/staff/forgot-password/signin', [StaffController::class, 'signinAfterReset']);

// check level staff
Route::post('/admin/data', [StaffController::class, 'getAdminData']);
Route::post('/shipper/data', [StaffController::class, 'getShipperData']);

// add product
Route::post('/products', [ProductsController::class, 'store']);

// update product
Route::put('/products/{id}', [ProductsController::class, 'update']);

// delete product
Route::delete('products/{id}', [ProductsController::class, 'destroy']);

// accept order
Route::put('/orders/{orderId}/accept', [StaffController::class, 'acceptOrder']);

// reject order
Route::put('/orders/{orderId}/reject', [StaffController::class, 'rejectOrder']);

// update profile
Route::put('/staff/update-profile', [StaffController::class, 'updateProfile']);

// sign out
Route::post('/signout', [StaffController::class, 'signout']);

// Route untuk menambah produk ke keranjang
Route::post('/cart/add', [CartController::class, 'addToCart'])->name('cart.add');

// Route untuk mendapatkan semua item keranjang berdasarkan CustomerID
Route::get('/cart/items/{customerId}', [CartController::class, 'getCartItems'])->name('cart.items');

// Route untuk menerima pesanan
Route::post('/order/accept/{orderId}', [CartController::class, 'acceptOrder'])->name('order.accept');

// Route untuk menolak pesanan
Route::post('/order/reject/{orderId}', [CartController::class, 'rejectOrder'])->name('order.reject');

// Route untuk mendapatkan detail pesanan
Route::get('/order/details/{orderId}', [CartController::class, 'getOrderDetails']);

// Route untuk mendapatkan informasi pelacakan pesanan
Route::get('/order/tracking/{orderId}', [CartController::class, 'getTracking'])->name('order.tracking');






// API Customer
Route::get('customers/search/{name}', [CustomersController::class, 'searchByName']);
Route::get('/customers', [CustomersController::class, 'getAllCustomers']);

// customer sign up
Route::post('/customers/signup', [CustomersController::class, 'signUp']);

// customer sign in
Route::post('/customers/signin', [CustomersController::class, 'signIn']);

// customer Forgot Password
Route::post('/customers/forgot-password/verify-email', [CustomersController::class, 'verifyEmail']);
Route::post('/customers/forgot-password/reset-password', [CustomersController::class, 'resetPassword']);
Route::post('/customers/forgot-password/signin', [CustomersController::class, 'signinAfterReset']);

// customer Edit Profile
Route::put('/customers/edit-profile', [CustomersController::class, 'editProfile']);

// show Customer Name
Route::get('/customers/{id}', [CustomersController::class, 'getCustomerById']);

// show menu recommendations
Route::get('recommendation', [ProductsController::class, 'getMenuItems']);

// add product to cart
Route::post('/add-to-cart', [CartController::class, 'addToCart']);

// show product in cart
Route::get('/cart/{customerId}', [CartController::class, 'getCartItems']);

// show all product
Route::get('/products', [ProductsController::class, 'index']);

// Route baru untuk fungsi showProductsByName
Route::get('/all-products', [ProductsController::class, 'getAllProducts']);

// search products by name
Route::get('products/search/{name}', [ProductsController::class, 'show']);

// checkout product
Route::post('/checkout', [CartController::class, 'checkout']);

// show order details
Route::get('/orders/{orderId}/details', [CartController::class, 'getOrderDetails']);

// track order
Route::get('/orders/{orderId}/tracking', [CartController::class, 'getTracking']);

// sign out
Route::post('/customers/signout', [CustomersController::class, 'signOut']);






use App\Http\Controllers\OrdersController;

Route::get('/orders', [OrdersController::class, 'index']);
Route::get('/orders/{id}', [OrdersController::class, 'show']);
Route::post('/orders', [OrdersController::class, 'store']);
Route::put('/orders/{id}', [OrdersController::class, 'update']);
Route::delete('/orders/{id}', [OrdersController::class, 'destroy']);
Route::put('/orders/{id}/accept', [OrdersController::class, 'acceptOrder']);
Route::put('/orders/{id}/reject', [OrdersController::class, 'rejectOrder']);

// Rute untuk mendapatkan total produk yang terjual
Route::get('/total-products-sold', [ProductsController::class, 'getTotalProductsSold']);

// Rute untuk mendapatkan total pembayaran
Route::get('/total-payment', [ProductsController::class, 'getTotalPayment']);

// Rute untuk mendapatkan riwayat pesanan berdasarkan StaffID
Route::get('/order-history/{StaffID}', [OrdersController::class, 'getOrderHistoryByStaffID']);