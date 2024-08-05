<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cart;
use App\Models\Tracking;
use App\Models\Orders;
use App\Models\OrderDetails;
use App\Models\Products;
use App\Models\Staff;
use App\Models\Payments;
use App\Models\PaymentMethods;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class CartController extends Controller
{

    

    // Method untuk mendapatkan semua item keranjang untuk pelanggan
    public function getCartItems($customerId)
    {
        // Validasi input
        $validator = Validator::make(['CustomerID' => $customerId], [
            'CustomerID' => 'required|uuid|exists:Customers,CustomerID',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // Ambil semua item keranjang untuk pelanggan
        $cartItems = Cart::where('CustomerID', $customerId)->get();

        if ($cartItems->isEmpty()) {
            return response()->json([
                'status' => false,
                'message' => 'Keranjang kosong'
            ], 404);
        }

        // Ambil detail produk berdasarkan ProductID dari item keranjang
        $productIds = $cartItems->pluck('ProductID');
        $products = Products::whereIn('ProductID', $productIds)->get();

        // Gabungkan data produk dengan item keranjang
        $cartItemsWithProducts = $cartItems->map(function ($cartItem) use ($products) {
            $product = $products->where('ProductID', $cartItem->ProductID)->first();
            return [
                'ProductID' => $cartItem->ProductID,
                'Quantity' => $cartItem->Quantity,
                'Product' => $product
            ];
        });

        return response()->json([
            'status' => true,
            'message' => 'Item keranjang ditemukan',
            'data' => $cartItemsWithProducts
        ], 200);
    }

    public function checkout(Request $request)
    {
        // Validasi input
        $validator = Validator::make($request->all(), [
            'CustomerID' => 'required|uuid|exists:Customers,CustomerID',
            'PaymentID' => 'required|string|exists:Payments,PaymentID',
            'DeliveryAddress' => 'required|string|max:255',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $customerId = $request->CustomerID;
        $paymentId = $request->PaymentID;
        $deliveryAddress = $request->DeliveryAddress;

        // Ambil item keranjang untuk pelanggan
        $cartItems = Cart::where('CustomerID', $customerId)->get();

        if ($cartItems->isEmpty()) {
            return response()->json([
                'status' => false,
                'message' => 'Keranjang kosong'
            ], 404);
        }

        // Hitung total harga dan jumlah produk
        $totalAmount = 0;
        $totalOrder = 0; // Jumlah produk yang dicheckout
        foreach ($cartItems as $item) {
            $product = Products::find($item->ProductID);
            $totalAmount += $product->Price * $item->Quantity;
            $totalOrder += $item->Quantity; // Menambahkan kuantitas produk ke total order
        }

        // Ambil detail metode pembayaran dari tabel Payments
        $payment = Payments::find($paymentId);

        // Ambil detail metode pembayaran dari tabel PaymentMethods
        $paymentMethod = PaymentMethods::find($payment->PaymentMethod);

        // Cari Staff dengan level ADMIN
        $adminStaff = Staff::where('level', 'ADMIN')->first();

        if (!$adminStaff) {
            return response()->json([
                'status' => false,
                'message' => 'Tidak ada staff dengan level ADMIN tersedia'
            ], 404);
        }

        // Buat pesanan
        $order = Orders::create([
            'OrderID' => Str::uuid(),
            'CustomerID' => $customerId,
            'PaymentID' => $paymentId,
            'OrderDate' => now(),
            'TotalOrder' => $totalOrder, // Simpan jumlah produk yang dicheckout
            'TotalAmount' => $totalAmount,
            'DeliveryAddress' => $deliveryAddress,
            'StatusCode' => 'PENDING',
            'StaffID' => $adminStaff->StaffID,
        ]);

        // Simpan item-item keranjang ke tabel OrderDetails
        foreach ($cartItems as $item) {
            $product = Products::find($item->ProductID);
            OrderDetails::create([
                'OrderDetailID' => Str::uuid(),
                'OrderID' => $order->OrderID,
                'ProductID' => $item->ProductID,
                'Quantity' => $item->Quantity,
                'UnitPrice' => $product->Price,
                'Notes' => $item->Notes,
            ]);
        }

        // Hapus item dari keranjang setelah pesanan dibuat
        Cart::where('CustomerID', $customerId)->delete();

        return response()->json([
            'status' => true,
            'message' => 'Pesanan berhasil dibuat',
            'order' => $order,
            'paymentMethod' => $paymentMethod
        ], 201);
    }

    // Metode untuk menerima pesanan
    public function acceptOrder(Request $request, $orderId)
    {
        $order = Orders::find($orderId);

        if (!$order) {
            return response()->json(['status' => false, 'message' => 'Pesanan tidak ditemukan'], 404);
        }

        // Periksa apakah staff yang sedang memproses adalah ADMIN
        $staff = Staff::find($request->input('StaffID'));
        if (!$staff || $staff->Level !== 'ADMIN') {
            return response()->json(['status' => false, 'message' => 'Tidak memiliki otorisasi'], 403);
        }

        $order->StatusCode = 'ACCEPTED'; // Atur status menjadi diterima
        $order->save();

        return response()->json(['status' => true, 'message' => 'Pesanan diterima']);
    }

    // Metode untuk menolak pesanan
    public function rejectOrder(Request $request, $orderId)
    {
        $order = Orders::find($orderId);

        if (!$order) {
            return response()->json(['status' => false, 'message' => 'Pesanan tidak ditemukan'], 404);
        }

        // Periksa apakah staff yang sedang memproses adalah ADMIN
        $staff = Staff::find($request->input('StaffID'));
        if (!$staff || $staff->Level !== 'ADMIN') {
            return response()->json(['status' => false, 'message' => 'Tidak memiliki otorisasi'], 403);
        }

        $order->StatusCode = 'REJECTED'; // Atur status menjadi ditolak
        $order->save();

        return response()->json(['status' => true, 'message' => 'Pesanan ditolak']);
    }

    public function getOrderDetails($orderId)
    {
        $orderDetails = OrderDetails::where('OrderID', $orderId)->get();

        if ($orderDetails->isEmpty()) {
            return response()->json(['status' => false, 'message' => 'Detail pesanan tidak ditemukan'], 404);
        }

        return response()->json(['status' => true, 'orderDetails' => $orderDetails]);
    }

    // Metode untuk melacak pesanan
    public function getTracking($orderId)
    {
        $tracking = Tracking::where('OrderID', $orderId)->get();

        if ($tracking->isEmpty()) {
            return response()->json(['status' => false, 'message' => 'Informasi pelacakan tidak ditemukan'], 404);
        }

        return response()->json(['status' => true, 'tracking' => $tracking]);
    }

    public function addToCart(Request $request)
    {
        $validated = $request->validate([
            'CustomerID' => 'required|uuid',
            'ProductID' => 'required|string',
            'Quantity' => 'required|integer|min:1',
        ]);

        // Check if the item is already in the cart
        $cartItem = Cart::where('CustomerID', $validated['CustomerID'])
                        ->where('ProductID', $validated['ProductID'])
                        ->first();

        if ($cartItem) {
            // If item exists, update the quantity
            $cartItem->Quantity += $validated['Quantity'];
            $cartItem->save();
        } else {
            // If item does not exist, create a new cart item
            Cart::create($validated);
        }

        return response()->json(['message' => 'Item added to cart successfully'], 200);
    }
}

