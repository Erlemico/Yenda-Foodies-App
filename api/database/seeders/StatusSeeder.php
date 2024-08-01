<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class StatusSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $status = [
            ['StatusCode' => 'ACCEPTED', 'Description' => 'Order has been accepted'],
            ['StatusCode' => 'CANCELLED', 'Description' => 'Order has been cancelled'],
            ['StatusCode' => 'DELIVERED', 'Description' => 'Order has been delivered to the customer'],
            ['StatusCode' => 'PAID', 'Description' => 'Order has been paid'],
            ['StatusCode' => 'PAYMENT_CANCELLED', 'Description' => 'Payment has been cancelled'],
            ['StatusCode' => 'PENDING', 'Description' => 'Order has been placed but not yet processed'],
            ['StatusCode' => 'PROCESSING', 'Description' => 'Order is currently being processed'],
            ['StatusCode' => 'REFUNDED', 'Description' => 'Order has been refunded to the customer'],
            ['StatusCode' => 'RETURNED', 'Description' => 'Order has been returned by the customer'],
            ['StatusCode' => 'SHIPPED', 'Description' => 'Order has been shipped'],
            ['StatusCode' => 'WAITING', 'Description' => 'Waiting for an order to be paid'],
        ];

        DB::table('Status')->insert($status);
    }
}