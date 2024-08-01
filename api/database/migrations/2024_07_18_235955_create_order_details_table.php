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
        Schema::create('OrderDetails', function (Blueprint $table) {
            $table->string('OrderDetailID')->primary();
            $table->uuid('OrderID');
            $table->string('ProductID');
            $table->string('ProductName');
            $table->integer('Quantity');
            $table->decimal('UnitPrice', 10, 2)->nullable();
            $table->string('Notes')->nullable();

            $table->foreign('OrderID')->references('OrderID')->on('Orders')->onDelete('cascade');
            $table->foreign('ProductID')->references('ProductID')->on('Products')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('OrderDetails');
    }
};