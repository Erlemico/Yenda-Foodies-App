<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Faker\Factory as Faker;

class OrdersSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = Faker::create();

        // Ambil ID Staff dengan Level ADMIN secara acak
        $staffIds = DB::table('Staff')->where('Level', 'ADMIN')->pluck('StaffID');
        
        // Ambil ID Shipper dengan Level SHIPPER secara acak
        $shipperIds = DB::table('Staff')->where('Level', 'SHIPPER')->pluck('StaffID');
        
        // Ambil CustomerID secara acak dari tabel Customers
        $customerIds = DB::table('Customers')->pluck('CustomerID');
        
        // Ambil StatusCode secara acak dari tabel Status
        $statusCodes = DB::table('Status')->pluck('StatusCode');
        
        // Menghasilkan 25 entri order
        for ($i = 0; $i < 25; $i++) {
            // Generate UUID untuk OrderID
            $orderId = (string) Str::uuid();
            
            // Pilih ID Staff, Shipper, Customer, dan Status secara acak
            $staffId = $staffIds->random();
            $shipperId = $shipperIds->random();
            $customerId = $customerIds->random();
            $statusCode = $statusCodes->random();

            // Generate alamat pengiriman acak menggunakan Faker
            $deliveryAddress = $faker->address;

            // Insert data ke tabel orders
            DB::table('Orders')->insert([
                'OrderID' => $orderId,
                'StaffID' => $staffId,
                'CustomerID' => $customerId,
                'StatusCode' => $statusCode,
                'OrderDate' => now(),
                'TotalOrder' => 0, // TotalOrder akan dihitung di OrderDetailsSeeder
                'TotalAmount' => 0, // TotalAmount akan dihitung di OrderDetailsSeeder
                'DeliveryAddress' => $deliveryAddress,
                'Shipper' => $shipperId,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
