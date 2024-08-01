<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Customers;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class CustomersController extends Controller
{
    public function signUp(Request $request)
    {
        // Validasi input
        $validator = Validator::make($request->all(), [
            'CustomerName' => 'required|string|max:255',
            'NumberPhone' => 'required|string|max:15',
            'Email' => 'required|email|unique:Customers,Email',
            'Password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // Simpan data customer baru
        $customer = Customers::create([
            'CustomerID' => (string) \Illuminate\Support\Str::uuid(), // Generate UUID
            'CustomerName' => $request->CustomerName,
            'NumberPhone' => $request->NumberPhone,
            'Email' => $request->Email,
            'Password' => Hash::make($request->Password), // Enkripsi password
            'CreatedDate' => now(),
        ]);

        return response()->json($customer, 201);
    }

    public function signIn(Request $request)
    {
        // Validasi input
        $validator = Validator::make($request->all(), [
            'CustomerName' => 'required|string',
            'Password' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // Cari customer berdasarkan nama dan password
        $customer = Customers::where('CustomerName', $request->CustomerName)->first();

        if (!$customer || !Hash::check($request->Password, $customer->Password)) {
            return response()->json(['message' => 'Invalid credentials'], 401);
        }

        return response()->json([
            'status' => true,
            'message' => 'Login berhasil',
            'customer' => [
                'CustomerID' => $customer->CustomerID,
                'CustomerName' => $customer->CustomerName,
                'Email' => $customer->Email,
            ]
        ], 200);
    }

    public function getAllCustomers()
    {
        $customers = Customers::all();
        return response()->json($customers);
    }

    public function searchByName($name) {
    $customers = Customers::where('CustomerName', 'like', '%' . $name . '%')->get();

    // Jika tidak ada pelanggan ditemukan
    if ($customers->isEmpty()) {
        return response()->json(['message' => 'No customers found'], 404);
    }

    // Kembalikan hasil pencarian dalam format JSON
    return response()->json($customers);
    }

    public function verifyEmail(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'Email' => 'required|email|exists:Customers,Email',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Email tidak ditemukan di database.',
                'errors' => $validator->errors()
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Email terverifikasi. Anda dapat melanjutkan untuk mereset kata sandi.',
        ], 200);
    }

    public function resetPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'Email' => 'required|email|exists:Customers,Email',
            'Password' => 'required|string|confirmed|min:8',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validasi gagal.',
                'errors' => $validator->errors()
            ], 422);
        }

        $customer = Customers::where('Email', $request->Email)->first();

        if (!$customer) {
            return response()->json([
                'success' => false,
                'message' => 'Customer tidak ditemukan.',
            ], 404);
        }

        $customer->Password = Hash::make($request->Password);
        $customer->save();

        return response()->json([
            'success' => true,
            'message' => 'Kata sandi telah direset. Anda sekarang dapat masuk.',
        ], 200);
    }

    public function signinAfterReset(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'Email' => 'required|email',
            'Password' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $customer = Customers::where('Email', $request->Email)->first();

        if (!$customer || !Hash::check($request->Password, $customer->Password)) {
            return response()->json(['message' => 'Invalid credentials'], 401);
        }

        return response()->json($customer);
    }

    public function editProfile(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'CustomerID' => 'required|exists:Customers,CustomerID',
            'CustomerName' => 'sometimes|required|string|max:255',
            'NumberPhone' => 'sometimes|required|string|max:15',
            'Email' => 'sometimes|required|email|unique:Customers,Email,' . $request->CustomerID . ',CustomerID',
            'Password' => 'sometimes|required|string|min:6|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $customer = Customers::find($request->CustomerID);

        if (!$customer) {
            return response()->json(['message' => 'Customer tidak ditemukan'], 404);
        }

        if ($request->has('CustomerName')) {
            $customer->CustomerName = $request->CustomerName;
        }
        if ($request->has('NumberPhone')) {
            $customer->NumberPhone = $request->NumberPhone;
        }
        if ($request->has('Email')) {
            $customer->Email = $request->Email;
        }
        if ($request->has('Password')) {
            $customer->Password = Hash::make($request->Password);
        }

        $customer->save();

        return response()->json([
            'success' => true,
            'message' => 'Profil berhasil diperbarui.',
            'customer' => $customer
        ], 200);
    }

    public function getCustomerById($id)
    {
        $customer = Customers::find($id);

        if (!$customer) {
            return response()->json([
                'status' => false,
                'message' => 'Customer tidak ditemukan'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'message' => 'Customer ditemukan',
            'data' => $customer
        ], 200);
    }

    public function signOut(Request $request)
    {
        return response()->json([
            'status' => true,
            'message' => 'Sign-out berhasil'
        ], 200);
    }

}