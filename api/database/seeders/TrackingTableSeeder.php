<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;

class TrackingTableSeeder extends Seeder
{
    public function run()
    {
        $faker = Faker::create();

        // Ambil OrderID dari tabel Orders
        $orderIds = DB::table('Orders')->pluck('OrderID');

        foreach (range(1, 50) as $index) { // Menghasilkan 50 entri, sesuaikan sesuai kebutuhan
            DB::table('Tracking')->insert([
                'TrackingID' => $faker->uuid,
                'OrderID' => $faker->randomElement($orderIds),
                'Location' => $faker->address,
                'Remarks' => $faker->text(200),
                'TrackDate' => $faker->dateTimeBetween('-1 year', 'now'),
                'Latitude' => $faker->latitude,
                'Longitude' => $faker->longitude,
            ]);
        }
    }
}
