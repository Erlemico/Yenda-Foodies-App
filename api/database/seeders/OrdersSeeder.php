<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class OrdersSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Ambil ID Staff dengan Level ADMIN secara acak
        $staffId = DB::table('Staff')
            ->where('Level', 'ADMIN')
            ->inRandomOrder()
            ->value('StaffID');

        // Ambil ID Shipper dengan Level SHIPPER secara acak
        $shipperId = DB::table('Staff')
            ->where('Level', 'SHIPPER')
            ->inRandomOrder()
            ->value('StaffID');

        // Ambil CustomerID secara acak dari tabel Customers
        $customerId = DB::table('Customers')
            ->inRandomOrder()
            ->value('CustomerID');

        // Generate UUID untuk OrderID
        $orderId = (string) Str::uuid();
        $paymentId = (string) Str::uuid();

        // Insert data ke tabel orders
        DB::table('Orders')->insert([
            'OrderID' => $orderId,
            'StaffID' => $staffId,
            'CustomerID' => $customerId,
            'StatusCode' => 'PENDING', // Sesuaikan dengan status yang ada
            'PaymentID' => $paymentId, // PaymentID akan diisi di PaymentsSeeder
            'OrderDate' => now(),
            'TotalOrder' => 0, // TotalOrder akan dihitung di OrderDetailsSeeder
            'TotalAmount' => 0, // TotalAmount akan dihitung di OrderDetailsSeeder
            'DeliveryAddress' => 'Jl. Contoh Alamat No.123',
            'Shipper' => $shipperId,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}
