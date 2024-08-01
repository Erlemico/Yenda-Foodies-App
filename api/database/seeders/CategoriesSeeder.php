<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CategoriesSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // Data untuk kategori produk
        $categories = [
            ['CategoryID' => 'DRINK', 'Description' => 'Category for various drinks'],
            ['CategoryID' => 'OTHER', 'Description' => 'Category for other items'],
            ['CategoryID' => 'PACKAGE', 'Description' => 'Category for package menus'],
            ['CategoryID' => 'SIDEDISH', 'Description' => 'Category for side dishes'],
        ];

        // Insert data ke dalam tabel categories
        DB::table('Categories')->insert($categories);
    }
}