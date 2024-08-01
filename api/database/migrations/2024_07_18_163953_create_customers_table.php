<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('Customers', function (Blueprint $table) {
            $table->uuid('CustomerID')->primary();
            $table->string('CustomerName');
            $table->string('NumberPhone');
            $table->string('Email');
            $table->string('Password');
            $table->dateTime('CreatedDate')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('Customers');
    }
};
