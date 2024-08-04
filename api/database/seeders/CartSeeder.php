<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Faker\Factory as Faker;

class CartSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $faker = Faker::create();

        // Ambil semua ProductName dari tabel Products
        $productNames = DB::table('Products')->pluck('ProductName')->toArray();

        // Ambil semua CustomerID dari tabel Customers
        $customerIds = DB::table('Customers')->pluck('CustomerID')->toArray();

        // Insert dummy data into Cart table
        foreach (range(1, 50) as $index) {
            DB::table('Cart')->insert([
                'CustomerID' => $faker->randomElement($customerIds),
                'ProductName' => $faker->randomElement($productNames),
                'Quantity' => $faker->numberBetween(1, 10),
                'DateAdded' => $faker->dateTimeThisYear(),
            ]);
        }
    }
}
