<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;

class StaffSeeder extends Seeder
{
    public function run() {
        $faker = Faker::create();

        // Masukkan data contoh ke tabel Staff
        foreach (range(1, 10) as $index) {
            DB::table('Staff')->insert([
                'StaffID' => $faker->unique()->uuid,
                'StaffName' => $faker->name,
                'Level' => $faker->randomElement(['ADMIN', 'SHIPPER']),
                'NumberPhone' => $faker->phoneNumber,
                'Email' => $faker->safeEmail,
                'Password' => bcrypt('password'), // Enkripsi password
                'CreatedDate' => $faker->dateTimeBetween('-1 year', 'now'),
            ]);
        }
    }
}