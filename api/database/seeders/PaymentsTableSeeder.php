<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;

class PaymentsTableSeeder extends Seeder
{
    public function run()
    {
        $faker = Faker::create();

        // Ambil OrderID, TotalAmount, dan OrderDate dari tabel Orders
        $orders = DB::table('Orders')->select('OrderID', 'TotalAmount', 'OrderDate')->get();

        // Ambil StaffID dari tabel Staff
        $staffIds = DB::table('Staff')->pluck('StaffID');

        // Ambil StatusCode dari tabel Status
        $statusCodes = DB::table('Status')->pluck('StatusCode');

        // Ambil PaymentMethodID dari tabel PaymentMethods
        $paymentMethodIds = DB::table('PaymentMethods')->pluck('PaymentMethod');

        foreach ($orders as $order) {
            DB::table('Payments')->insert([
                'PaymentID' => $faker->uuid,
                'StaffID' => $faker->randomElement($staffIds),
                'OrderID' => $order->OrderID,
                'Amount' => $order->TotalAmount, // Mengambil Amount dari TotalAmount di Orders
                'PaymentMethod' => $faker->randomElement($paymentMethodIds),
                'PaymentDate' => $order->OrderDate, // Mengambil PaymentDate dari OrderDate di Orders
                'StatusCode' => $faker->randomElement($statusCodes),
            ]);
        }
    }
}
