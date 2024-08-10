<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Models\Customers;
use App\Models\Staff;
use Tymon\JWTAuth\Facades\JWTAuth;

class AuthController extends Controller
{

    // Metode Login untuk Customer
    public function login(Request $request)
    {

        $credentials = $request->only('email', 'password');
        $customer = Customers::where('email', $credentials['email'])->first();

        if ($customer && Hash::check($credentials['password'], $customer->Password)) {
            $token = JWTAuth::fromUser($customer);
            return response()->json([
                'token' => $token,
                'statusCode' => 200,
                'message' => 'success',
                'status' => true,
                'customer' => $customer
            ]);
        }

        return response()->json(['error' => 'Invalid credentials'], 401);
    }

    public function login_staff(Request $request)
    {

        $credentials = $request->only('email', 'password');
        $staff = Staff::where('email', $credentials['email'])->first();

        if ($staff && Hash::check($credentials['password'], $staff->Password)) {
            $token = JWTAuth::fromUser($staff);
            return response()->json([
                'token' => $token,
                'statusCode' => 200,
                'message' => 'success',
                'status' => true,
                'staff' => $staff
            ]);
        }

        return response()->json(['error' => 'Invalid credentials'], 401);
    }

    // Metode Register untuk Customer
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'number_phone' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:customers',
            'password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $customer = Customers::create([
            'CustomerID' => (string) \Illuminate\Support\Str::uuid(), // Generate UUID
            'CustomerName' => $request->name,
            'NumberPhone' => $request->number_phone,
            'Email' => $request->email,
            'Password' => bcrypt($request->password), // Enkripsi password
            'CreatedDate' => now(),
        ]);

        // Menggunakan guard api_customer untuk membuat token JWT
        $token = auth()->guard('api_customer')->login($customer);

        return response()->json([
            'statusCode' => 200,
            'token' => $token,
            'customer' => $customer
        ]);
    }

    // Metode Logout untuk Customer
    public function logout()
    {
        auth()->guard('api_customer')->logout();
        return response()->json(['message' => 'Successfully logged out']);
    }

    // Metode Refresh Token untuk Customer
    public function refresh()
    {
        $newToken = auth()->guard('api_customer')->refresh();

        return response()->json(['token' => $newToken]);
    }

    // Mendapatkan Informasi Customer yang Terautentikasi
    public function me()
    {
        return response()->json(auth()->guard('api_customer')->user());
    }
}
