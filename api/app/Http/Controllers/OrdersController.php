<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Orders;
use Illuminate\Support\Facades\DB;

class OrdersController extends Controller
{
    public function index()
    {
        $orders = Orders::all();
        $totalOrders = $orders->count(); // Hitung jumlah total pesanan

        // Hitung total pembayaran dari semua pesanan
        $totalPayment = $orders->sum(function ($order) {
            return $order->total_payment; // Gantilah 'total_payment' dengan nama field yang sesuai di model Orders
        });

        return response()->json([
            'status' => true,
            'message' => 'Pesanan tersedia',
            'total_orders' => $totalOrders, // Tambahkan jumlah total pesanan
            'total_payment' => $totalPayment, // Tambahkan total pembayaran
            'data' => $orders
        ], 200);
    }

    public function show(string $id)
    {
        $order = Orders::find($id);

        if (!$order) {
            return response()->json([
                'status' => false,
                'message' => 'Pesanan tidak ditemukan'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'message' => 'Pesanan ditemukan',
            'data' => $order
        ], 200);
    }

    public function store(Request $request)
    {
        // Validasi input
        $request->validate([
            'OrderID' => 'required|string|max:255',
            'CustomerID' => 'required|string|max:255',
            'OrderDate' => 'required|date',
            'Status' => 'required|string|max:255',
            'total_payment' => 'required|numeric|min:0', // Validasi total pembayaran
            // Tambahkan validasi lainnya sesuai kebutuhan
        ]);

        // Simpan data pesanan
        $order = Orders::create([
            'OrderID' => $request->OrderID,
            'CustomerID' => $request->CustomerID,
            'OrderDate' => $request->OrderDate,
            'Status' => $request->Status,
            'total_payment' => $request->total_payment, // Simpan total pembayaran
            // Tambahkan field lainnya sesuai kebutuhan
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Pesanan berhasil ditambahkan',
            'data' => $order
        ], 201);
    }

    public function update(Request $request, string $id)
    {
        $order = Orders::find($id);

        if (!$order) {
            return response()->json([
                'status' => false,
                'message' => 'Pesanan tidak ditemukan'
            ], 404);
        }

        $request->validate([
            'Status' => 'required|string|max:255',
            'total_payment' => 'required|numeric|min:0', // Validasi total pembayaran
            // Tambahkan validasi lainnya sesuai kebutuhan
        ]);

        $order->update($request->only(['Status', 'total_payment'])); // Update status dan total pembayaran

        return response()->json([
            'status' => true,
            'message' => 'Pesanan berhasil diperbarui',
            'data' => $order
        ], 200);
    }

    public function destroy(string $id)
    {
        $order = Orders::find($id);

        if (!$order) {
            return response()->json([
                'status' => false,
                'message' => 'Pesanan tidak ditemukan'
            ], 404);
        }

        $order->delete();

        return response()->json([
            'status' => true,
            'message' => 'Pesanan berhasil dihapus'
        ], 200);
    }

    public function acceptOrder(Request $request, string $id)
    {
        $order = Orders::find($id);

        if (!$order) {
            return response()->json([
                'status' => false,
                'message' => 'Pesanan tidak ditemukan'
            ], 404);
        }

        $order->update(['Status' => 'Accepted']);

        return response()->json([
            'status' => true,
            'message' => 'Pesanan berhasil diterima',
            'data' => $order
        ], 200);
    }

    public function rejectOrder(Request $request, string $id)
    {
        $order = Orders::find($id);

        if (!$order) {
            return response()->json([
                'status' => false,
                'message' => 'Pesanan tidak ditemukan'
            ], 404);
        }

        $order->update(['Status' => 'Rejected']);

        return response()->json([
            'status' => true,
            'message' => 'Pesanan berhasil ditolak',
            'data' => $order
        ], 200);
    }

    public function getAllOrderHistory()
    {
        // Ambil semua pesanan beserta detailnya
        $orders = Orders::with('orderDetails')->get();

        // Siapkan respons dengan data riwayat pesanan
        $orderHistory = $orders->map(function($order) {
            return [
                'OrderID' => $order->OrderID,
                'OrderDate' => $order->OrderDate,
                'TotalAmount' => $order->orderDetails->sum(function($detail) {
                    return $detail->Quantity * $detail->UnitPrice;
                }),
                'StatusCode' => $order->StatusCode,
                'Details' => $order->orderDetails->map(function($detail) {
                    return [
                        'ProductID' => $detail->ProductID,
                        'ProductName' => $detail->ProductName,
                        'Quantity' => $detail->Quantity,
                        'UnitPrice' => $detail->UnitPrice,
                        'Notes' => $detail->Notes
                    ];
                })
            ];
        });

        return response()->json([
            'status' => true,
            'message' => 'Riwayat semua pesanan berhasil ditemukan',
            'data' => $orderHistory
        ], 200);
    }

    public function getOrderHistoryByStaffID($StaffID)
{
    // Ambil pesanan beserta detailnya berdasarkan StaffID
    $orders = Orders::with('orderDetails')
                    ->where('StaffID', $StaffID)
                    ->get();

    // Jika tidak ada pesanan yang ditemukan, kembalikan pesan error
    if ($orders->isEmpty()) {
        return response()->json([
            'status' => false,
            'message' => 'Pesanan tidak ditemukan untuk StaffID tersebut'
        ], 404);
    }

    // Siapkan respons dengan data riwayat pesanan
    $orderHistory = $orders->map(function($order) {
        return [
            'OrderID' => $order->OrderID,
            'OrderDate' => $order->OrderDate,
            'TotalAmount' => $order->orderDetails->sum(function($detail) {
                return $detail->Quantity * $detail->UnitPrice;
            }),
            'Details' => $order->orderDetails->map(function($detail) {
                return [
                    'ProductID' => $detail->ProductID,
                    'ProductName' => $detail->ProductName,
                    'Quantity' => $detail->Quantity,
                    'UnitPrice' => $detail->UnitPrice,
                    'Notes' => $detail->Notes
                ];
            })
        ];
    });

    return response()->json([
        'status' => true,
        'message' => 'Riwayat pesanan berhasil ditemukan untuk StaffID',
        'data' => $orderHistory
    ], 200);
}

    public function getDeliveredOrderHistory()
    {
        // Ambil semua pesanan dengan StatusCode = DELIVERED beserta detailnya
        $orders = Orders::with('orderDetails')
            ->where('StatusCode', 'DELIVERED')
            ->get();

        // Hitung total jumlah pesanan yang dikirim
        $totalDeliveredCount = $orders->count();

        // Siapkan respons dengan data riwayat pesanan
        $orderHistory = $orders->map(function($order) {
            return [
                'OrderID' => $order->OrderID,
                'OrderDate' => $order->OrderDate,
                'TotalAmount' => $order->orderDetails->sum(function($detail) {
                    return $detail->Quantity * $detail->UnitPrice;
                }),
                'StatusCode' => $order->StatusCode,
                'Details' => $order->orderDetails->map(function($detail) {
                    return [
                        'ProductID' => $detail->ProductID,
                        'ProductName' => $detail->ProductName,
                        'Quantity' => $detail->Quantity,
                        'UnitPrice' => $detail->UnitPrice,
                        'Notes' => $detail->Notes
                    ];
                })
            ];
        });

        return response()->json([
            'status' => true,
            'message' => 'Riwayat pesanan dengan StatusCode DELIVERED berhasil ditemukan',
            'totalDeliveredCount' => $totalDeliveredCount, // Total count pesanan yang dikirim
            'data' => $orderHistory
        ], 200);
    }

    public function getOrderHistoryByPaymentMethod($paymentMethod)
{
    // Ambil semua pesanan dengan PaymentMethod yang sesuai beserta detailnya
    $orders = Orders::with('orderDetails')
        ->where('PaymentMethod', $paymentMethod)
        ->get();

    // Jika tidak ada pesanan yang ditemukan, kembalikan pesan error
    if ($orders->isEmpty()) {
        return response()->json([
            'status' => false,
            'message' => 'Pesanan dengan metode pembayaran ' . $paymentMethod . ' tidak ditemukan'
        ], 404);
    }

    // Hitung total jumlah pesanan yang ditemukan
    $totalOrdersCount = $orders->count();

    // Siapkan respons dengan data riwayat pesanan
    $orderHistory = $orders->map(function($order) {
        return [
            'OrderID' => $order->OrderID,
            'OrderDate' => $order->OrderDate,
            'TotalAmount' => $order->orderDetails->sum(function($detail) {
                return $detail->Quantity * $detail->UnitPrice;
            }),
            'StatusCode' => $order->StatusCode,
            'PaymentMethod' => $order->PaymentMethod,
            'Details' => $order->orderDetails->map(function($detail) {
                return [
                    'ProductID' => $detail->ProductID,
                    'ProductName' => $detail->ProductName,
                    'Quantity' => $detail->Quantity,
                    'UnitPrice' => $detail->UnitPrice,
                    'Notes' => $detail->Notes
                ];
            })
        ];
    });

    return response()->json([
        'status' => true,
        'message' => 'Riwayat pesanan berhasil ditemukan untuk metode pembayaran: ' . $paymentMethod,
        'totalOrdersCount' => $totalOrdersCount, // Total jumlah pesanan yang ditemukan
        'data' => $orderHistory
    ], 200);
}


}