<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class OrderDetailsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Ambil OrderID secara acak dari tabel Orders
        $orderId = DB::table('Orders')
            ->inRandomOrder()
            ->value('OrderID');

        // Data OrderDetails
        $orderDetails = [
            [
                'OrderDetailID' => (string) Str::uuid(),
                'OrderID' => $orderId,
                'ProductID' => 'RMF006',
                'ProductName' => 'Paket Nasi Tunjang',
                'Quantity' => 3,
                'UnitPrice' => 36000,
                'Notes' => null,
            ],
            [
                'OrderDetailID' => (string) Str::uuid(),
                'OrderID' => $orderId,
                'ProductID' => 'RFM012',
                'ProductName' => 'Ayam Pop',
                'Quantity' => 2,
                'UnitPrice' => 19000,
                'Notes' => null,
            ],
            [
                'OrderDetailID' => (string) Str::uuid(),
                'OrderID' => $orderId,
                'ProductID' => 'RMF031',
                'ProductName' => 'Jus Mangga',
                'Quantity' => 2,
                'UnitPrice' => 17000,
                'Notes' => null,
            ],
        ];

        // Hitung TotalOrder dan TotalAmount
        $totalOrder = array_sum(array_column($orderDetails, 'Quantity'));
        $totalAmount = array_reduce($orderDetails, function ($sum, $detail) {
            return $sum + ($detail['Quantity'] * $detail['UnitPrice']);
        }, 0);

        // Insert data ke tabel order_details
        DB::table('OrderDetails')->insert($orderDetails);

        // Update TotalOrder dan TotalAmount di tabel orders
        DB::table('Orders')
            ->where('OrderID', $orderId)
            ->update([
                'TotalOrder' => $totalOrder,
                'TotalAmount' => $totalAmount,
            ]);
    }
}
