<?php

namespace Database\Seeders;

use Illuminate\Support\Facades\DB;
use Illuminate\Database\Seeder;

class PaymentMethodsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $paymentmethods = [
            ['PaymentMethod' => 'BCA', 'Description' => 'Virtual account bank BCA'],
            ['PaymentMethod' => 'BRI', 'Description' => 'Virtual account bank BRI'],
            ['PaymentMethod' => 'Mandiri', 'Description' => 'Virtual account bank Mandiri'],
            ['PaymentMethod' => 'QRIS', 'Description' => 'Scan QR code'],
            ['PaymentMethod' => 'Cash', 'Description' => 'Cash'],
        ];

        DB::table('PaymentMethods')->insert($paymentmethods);
    }
}