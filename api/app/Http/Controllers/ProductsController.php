<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Products;
use App\Models\OrderDetails;
use Illuminate\Support\Facades\DB;

class ProductsController extends Controller
{
    public function index()
    {
        // Mengurutkan produk berdasarkan ProductID secara asc
        $products = Products::orderBy('ProductID', 'asc')->get();
        $totalProducts = $products->count(); // Hitung jumlah total produk

        return response()->json([
            'status' => true,
            'message' => 'Produk tersedia',
            'total' => $totalProducts, // Tambahkan jumlah total produk
            'data' => $products
        ], 200);
    }


    public function store(Request $request)
    {
        // Validasi input
        $request->validate([
            'ProductID' => 'required|string|max:255',
            'ProductName' => 'required|string|max:255',
            'Category' => 'required|string|max:255',
            'QtyProduct' => 'required|integer|min:0',
            'UnitPrice' => 'required|numeric|min:0',
            'Description' => 'required|string',
            'ImageProduct' => 'required|string',
            'RatingProduct' => 'nullable|numeric|min:0|max:5',
            'CreatedBy' => 'required|string|max:255',
            'CreatedDate' => 'required|date',
        ]);

        // Simpan data produk
        $product = Products::create([
            'ProductID' => $request->ProductID,
            'ProductName' => $request->ProductName,
            'Category' => $request->Category,
            'QtyProduct' => $request->QtyProduct,
            'UnitPrice' => $request->UnitPrice,
            'Description' => $request->Description,
            'ImageProduct' => $request->ImageProduct,
            'RatingProduct' => $request->RatingProduct,
            'CreatedBy' => $request->CreatedBy,
            'CreatedDate' => $request->CreatedDate,
        ]);

        // Respons API
        return response()->json([
            'status' => true,
            'message' => 'Produk berhasil ditambahkan',
            'data' => $product
        ], 201);
    }

    public function show(string $name)
    {
        $product = Products::where('ProductName', 'like', '%' . $name . '%')->get();

        if ($product->isEmpty()) { // Periksa jika koleksi kosong
            return response()->json([
                'status' => false,
                'message' => 'Produk tidak ditemukan'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'message' => 'Produk ditemukan',
            'data' => $product
        ], 200);
    }

    public function update(Request $request, string $id)
    {
        // Temukan produk berdasarkan ID yang diberikan (diasumsikan kolom ID bernama 'ProductID')
        $product = Products::where('ProductID', $id)->first();

        // Periksa apakah produk ditemukan
        if (!$product) {
            return response()->json([
                'status' => false,
                'message' => 'Produk tidak ditemukan'
            ], 404);
        }

        // Validasi data permintaan yang masuk
        $request->validate([
            'ProductName' => 'required|string|max:255',
            // Tambahkan aturan validasi lainnya sesuai kebutuhan
        ]);

        // Perbarui produk dengan data yang sudah divalidasi
        $product->update($request->only(['ProductName'])); // Tentukan hanya field yang ingin diperbarui

        return response()->json([
            'status' => true,
            'message' => 'Produk berhasil diperbarui',
            'data' => $product
        ], 200);
    }

    public function destroy(string $id)
    {
        $product = Products::where('ProductID', $id)->first();

        if (!$product) {
            return response()->json([
                'status' => false,
                'message' => 'Produk tidak ditemukan'
            ], 404);
        }

        $product->delete();

        return response()->json([
            'status' => true,
            'message' => 'Produk berhasil dihapus'
        ], 200);
    }

    public function getMenuItems()
    {
        // Daftar ID produk yang diinginkan
        $productIDs = ['RMF023', 'RMF008', 'RMF010', 'RMF015', 'RMF014', 'RMF004'];

        // Ambil produk berdasarkan ID dan pilih kolom yang diperlukan
        $products = Products::whereIn('ProductID', $productIDs)
            ->get(['ImageProduct', 'ProductName', 'UnitPrice', 'Description']); // Pilih kolom yang diinginkan

        return response()->json([
            'status' => true,
            'message' => 'Produk ditemukan',
            'data' => $products
        ], 200);
    }


    public function getTotalProductsSold()
    {
        // Hitung total produk yang terjual berdasarkan OrderDetails
        $totalProductsSold = DB::table('OrderDetails')
            ->select('ProductID', DB::raw('SUM(Quantity) as total_sold'))
            ->groupBy('ProductID')
            ->get();

        // Gabungkan dengan data produk
        $productsSold = $totalProductsSold->map(function ($item) {
            $product = Products::find($item->ProductID);
            return [
                'ProductID' => $item->ProductID,
                'ProductName' => $product->ProductName,
                'TotalSold' => $item->total_sold
            ];
        });

        return response()->json([
            'status' => true,
            'message' => 'Total produk yang terjual berhasil ditemukan',
            'data' => $productsSold
        ], 200);
    }

    public function getTotalPayment()
    {
        // Hitung total pembayaran berdasarkan OrderDetails
        $totalPayment = DB::table('OrderDetails')
            ->join('Orders', 'OrderDetails.OrderID', '=', 'Orders.OrderID')
            ->select(DB::raw('SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) as total_payment'))
            ->first();

        return response()->json([
            'status' => true,
            'message' => 'Total pembayaran berhasil dihitung',
            'data' => [
                'TotalPayment' => $totalPayment->total_payment
            ]
        ], 200);
    }

    public function getAllProducts()
    {
        // Ambil semua produk dari tabel Products, urutkan berdasarkan ProductName, dan pilih kolom yang diperlukan
        $products = Products::orderBy('ProductName', 'asc')
            ->get(['ImageProduct', 'ProductName', 'UnitPrice', 'Description', 'Category']);

        return response()->json([
            'status' => true,
            'message' => 'Semua produk ditemukan',
            'data' => $products
        ], 200);
    } 
}