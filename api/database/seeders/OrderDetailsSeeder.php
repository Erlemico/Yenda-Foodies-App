<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Faker\Factory as Faker;

class OrderDetailsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = Faker::create();

        // Ambil semua OrderID dari tabel Orders
        $orderIds = DB::table('Orders')->pluck('OrderID');

        // Ambil semua ProductID, ProductName, dan UnitPrice dari tabel Products
        $products = DB::table('Products')->get(['ProductID', 'ProductName', 'UnitPrice']);

        foreach ($orderIds as $orderId) {
            $orderDetails = [];

            // Buat antara 3 hingga 7 detail pesanan
            $numDetails = rand(3, 7);

            for ($i = 0; $i < $numDetails; $i++) {
                // Pilih produk secara acak dari tabel Products
                $product = $products->random();

                $orderDetails[] = [
                    'OrderDetailID' => (string) Str::uuid(),
                    'OrderID' => $orderId,
                    'ProductID' => $product->ProductID,
                    'ProductName' => $product->ProductName,
                    'Quantity' => $faker->numberBetween(1, 5),
                    'UnitPrice' => $product->UnitPrice, // Ambil UnitPrice dari tabel Products
                    'Notes' => $faker->optional()->sentence,
                ];
            }

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
}
