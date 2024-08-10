<?php

// routes/api.php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductsController;
use App\Http\Controllers\CustomersController;
use App\Http\Controllers\StaffController;
use App\Http\Controllers\OrdersController;


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





// API Customer
Route::get('customers/search/{name}', [CustomersController::class, 'searchByName']);
Route::get('/customers', [CustomersController::class, 'getAllCustomers']);

// customer sign up
Route::post('/customers/signup', [CustomersController::class, 'signUp']);

// customer sign in

use App\Http\Controllers\AuthController;


Route::group([
    'prefix' => 'customer-new'
], function () {
    Route::post('register', [AuthController::class, 'register']);
    Route::post('login', [AuthController::class, 'login']);

    Route::group([
        'middleware' => 'api',
    ], function () {
        Route::post('logout', [AuthController::class, 'logout']);
        Route::post('refresh', [AuthController::class, 'refresh']);

        Route::get('product', [ProductsController::class, 'getProductUser']);

        Route::group([
            'prefix' => 'order'
        ], function () {
            Route::post('/', [OrdersController::class, 'orderProduct']);
            Route::post('payment', [OrdersController::class, 'orderPayment']);
        });
    });
});


Route::group([
    'prefix' => 'admin-new'
], function () {
    Route::post('register', [AuthController::class, 'register']);
    Route::post('login', [AuthController::class, 'login_staff']);

    Route::group([
        'middleware' => 'api',
    ], function () {
        Route::post('logout', [AuthController::class, 'logout']);
        Route::post('refresh', [AuthController::class, 'refresh']);

        Route::get('product', [ProductsController::class, 'getProductUser']);

        Route::group([
            'prefix' => 'order'
        ], function () {
            Route::post('/', [OrdersController::class, 'orderProduct']);
            Route::post('payment', [OrdersController::class, 'orderProcessing']);
        });
    });
});


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


// show all product
Route::get('/products', [ProductsController::class, 'index']);

// Route baru untuk fungsi showProductsByName
Route::get('/all-products', [ProductsController::class, 'getAllProducts']);

// search products by name
Route::get('products/search/{name}', [ProductsController::class, 'show']);

// sign out
Route::post('/customers/signout', [CustomersController::class, 'signOut']);



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
