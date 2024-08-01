<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class StaffLevelsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('StaffLevels')->insert([
            ['Level' => 'ADMIN', 'JobDesk' => 'Manage orders, products, payments, and deliveries'],
            ['Level' => 'SHIPPER', 'JobDesk' => 'Shipping orders to customers'],
        ]);
    }
}
