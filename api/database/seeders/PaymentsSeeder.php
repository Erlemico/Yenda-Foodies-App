<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class PaymentsSeeder extends Seeder
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

        // Ambil OrderID secara acak dari tabel Orders
        $orderId = DB::table('Orders')
            ->inRandomOrder()
            ->value('OrderID');

        // Generate UUID untuk PaymentID
        $paymentId = (string) Str::uuid();

        // Insert data ke tabel payments
        DB::table('Payments')->insert([
            'PaymentID' => $paymentId,
            'StaffID' => $staffId,
            'OrderID' => $orderId, // Harus ada di tabel Orders
            'Amount' => DB::table('Orders')->where('OrderID', $orderId)->value('TotalAmount'),
            'PaymentMethod' => 'BCA', // Sesuaikan dengan metode pembayaran yang ada
            'PaymentDate' => now(),
            'StatusCode' => 'PAID', // Sesuaikan dengan status yang ada
        ]);

        // Update PaymentID di tabel orders
        DB::table('Orders')
            ->where('OrderID', $orderId)
            ->update(['PaymentID' => $paymentId]);
    }
}
