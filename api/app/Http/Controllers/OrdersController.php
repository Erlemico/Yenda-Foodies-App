<?php

namespace App\Http\Controllers;

use App\Models\OrderDetails;
use Illuminate\Http\Request;
use App\Models\Orders;
use App\Models\Payments;
use App\Models\Staff;
use Illuminate\Support\Facades\DB;
use Tymon\JWTAuth\Facades\JWTAuth;
use Illuminate\Support\Facades\Validator;


class OrdersController extends Controller
{
    public function index()
    {
        $orders = Orders::all();
        $totalOrders = $orders->count(); // Hitung jumlah total pesanan

        // Hitung total pembayaran dari semua pesanan
        $totalPayment = $orders->sum(function ($order) {
            return $order->Total; // Gantilah 'total_payment' dengan nama field yang sesuai di model Orders
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
        $orderHistory = $orders->map(function ($order) {
            return [
                'OrderID' => $order->OrderID,
                'OrderDate' => $order->OrderDate,
                'TotalAmount' => $order->orderDetails->sum(function ($detail) {
                    return $detail->Quantity * $detail->UnitPrice;
                }),
                'StatusCode' => $order->StatusCode,
                'Details' => $order->orderDetails->map(function ($detail) {
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
        $orderHistory = $orders->map(function ($order) {
            return [
                'OrderID' => $order->OrderID,
                'OrderDate' => $order->OrderDate,
                'TotalAmount' => $order->orderDetails->sum(function ($detail) {
                    return $detail->Quantity * $detail->UnitPrice;
                }),
                'Details' => $order->orderDetails->map(function ($detail) {
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
        $orderHistory = $orders->map(function ($order) {
            return [
                'OrderID' => $order->OrderID,
                'OrderDate' => $order->OrderDate,
                'TotalAmount' => $order->orderDetails->sum(function ($detail) {
                    return $detail->Quantity * $detail->UnitPrice;
                }),
                'StatusCode' => $order->StatusCode,
                'PaymentMethod' => $order->PaymentMethod,
                'Details' => $order->orderDetails->map(function ($detail) {
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

    public function orderProduct(Request $request)
    {
        $payload = JWTAuth::parseToken()->getPayload();

        $request->validate([
            'total_payment' => 'required|numeric|min:0', // Validasi total pembayaran
            'address' => 'required', // Validasi total pembayaran
            'detail_order' => 'required'
        ]);

        $response = [
            'status' => true,
            'message' => 'Gagal dalam memesan'
        ];

        try {
            DB::beginTransaction();

            $shipper = Staff::where('level','=','SHIPPER')->first();

            // Perform your database operations
            $order = Orders::create([
                'OrderID' => (string) \Illuminate\Support\Str::uuid(), // Generate UUID
                'CustomerID' => $payload->get('sub'),
                'OrderDate' => now(),
                'StatusCode' => 'WAITING',
                'TotalAmount' => $request->total_payment, // Simpan total pembayaran
                'TotalOrder' => count($request->detail_order),
                'DeliveryAddress' => $request->address,
                'Shipper' => $shipper->StaffID
            ]);

            $resDetail = $this->mapDetailOrder($request->detail_order, $order);
            OrderDetails::insert($resDetail);

            // If everything is okay, commit the transaction
            DB::commit();

            $response = [
                'status' => true,
                'message' => 'Silahkan lanjut pembayaran',
                'data' => $order
            ];
        } catch (\Exception $e) {
            // If something goes wrong, rollback the transaction
            DB::rollBack();

            // Handle the exception (e.g., log the error, rethrow, etc.)
            throw $e;
        }

        return response()->json($response, 200);
    }

    public function orderPayment(Request $request){
        $validator = Validator::make($request->all(), [
            'order_id' => 'required', // Validasi total pembayaran
            'payment_method' => 'required', // Validasi total pembayaran
        ]);

        if ($validator->fails()) {
            return redirect()->back()
                            ->withErrors($validator)
                            ->withInput();
        }


        $response = [
            'status' => true,
            'message' => 'Gagal pembayaran'
        ];

        try {
            DB::beginTransaction();

            $admin = Staff::where('level','=','ADMIN')->first();
            $order = Orders::where('OrderID', $request->order_id)->first();

            // Perform your database operations
            Orders::where('OrderID', $request->order_id)->update([
                'StatusCode' => 'PAID',
                'StaffID' => $admin->StaffID,
                'Updated_at' => now()
            ]);

            $amount = $order->TotalAmount;
            Payments::create([
                'StaffID' => $admin->StaffID,
                'PaymentID' => (string) \Illuminate\Support\Str::uuid(), // Generate UUID
                'OrderID' => $request->order_id,
                'Amount' => $amount,
                'PaymentMethod' => $request->payment_method,
                'PaymentDate' => now(),
                'StatusCode' => 'PAID'
            ]);

            // If everything is okay, commit the transaction
            DB::commit();

            $response = [
                'status' => true,
                'message' => 'Orderan sedang di proses silahkan tunggu'
            ];
        } catch (\Exception $e) {
            // If something goes wrong, rollback the transaction
            DB::rollBack();

            // Handle the exception (e.g., log the error, rethrow, etc.)
            throw $e;
        }

        return response()->json($response, 200);

    }

    public function orderProcessing(Request $request){
        $request->validate([
            'order_id' => 'required', // Validasi total pembayaran
        ]);

        $response = [
            'status' => true,
            'message' => 'Gagal Update'
        ];

        try {
            DB::beginTransaction();

            $admin = Staff::where('level','=','ADMIN')->first();
            $order = Orders::where('OrderID', $request->order_id)->first();

            // Perform your database operations
            Orders::where('OrderID', $request->order_id)->update([
                'StatusCode' => 'PAID',
                'StaffID' => $admin->StaffID,
                'Updated_at' => now()
            ]);

            $amount = $order->TotalAmount;
            Payments::create([
                // 'StaffID' => $admin->StaffID,
                'PaymentID' => (string) \Illuminate\Support\Str::uuid(), // Generate UUID
                'OrderID' => $request->order_id,
                'Amount' => $amount,
                'PaymentMethod' => $request->payment_method,
                'PaymentDate' => now(),
                'StatusCode' => 'PAID'
            ]);

            // If everything is okay, commit the transaction
            DB::commit();

            $response = [
                'status' => true,
                'message' => 'Orderan sedang di proses silahkan tunggu'
            ];
        } catch (\Exception $e) {
            // If something goes wrong, rollback the transaction
            DB::rollBack();

            // Handle the exception (e.g., log the error, rethrow, etc.)
            throw $e;
        }

        return response()->json($response, 200);

    }

    private function mapDetailOrder(array $data, object $order){
        $res = [];
        foreach ($data as $value) {
            $res[] = [
                'OrderDetailID' => (string) \Illuminate\Support\Str::uuid(), // Generate UUID
                'OrderID' => $order->OrderID,
                'ProductID' => $value['product_id'],
                'ProductName' => $value['product_name'],
                'Quantity' => $value['qty'],
                'UnitPrice' => $value['unit_price'],
                'Notes' => $value['notes'],
                'Created_At' => now(),
                'Updated_At' => now()
            ];
        }

        return $res;
    }
}
