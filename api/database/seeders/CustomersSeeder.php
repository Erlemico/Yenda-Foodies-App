<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class CustomersSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $customers = [
            [
                'CustomerID' => (string) Str::uuid(),
                'CustomerName' => 'John Doe',
                'NumberPhone' => '1234567890',
                'Email' => 'john.doe@example.com',
                'Password' => bcrypt('password123'),
                'CreatedDate' => now(),
            ],
            [
                'CustomerID' => (string) Str::uuid(),
                'CustomerName' => 'Jane Smith',
                'NumberPhone' => '0987654321',
                'Email' => 'jane.smith@example.com',
                'Password' => bcrypt('password123'),
                'CreatedDate' => now(),
            ],
            [
                'CustomerID' => (string) Str::uuid(),
                'CustomerName' => 'Alice Johnson',
                'NumberPhone' => '1122334455',
                'Email' => 'alice.johnson@example.com',
                'Password' => bcrypt('password123'),
                'CreatedDate' => now(),
            ],
        ];

        DB::table('Customers')->insert($customers);
    }
}
