<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('Orders', function (Blueprint $table) {
            $table->uuid('OrderID')->primary();
            $table->uuid('AdminID')->nullable();
            $table->uuid('CustomerID')->nullable();
            $table->string('StatusCode')->nullable();
            $table->dateTime('OrderDate')->nullable();
            $table->decimal('TotalOrder', 10, 2)->nullable();
            $table->decimal('TotalAmount', 10, 2)->nullable();
            $table->text('DeliveryAddress')->nullable();
            $table->timestamps();

            $table->foreign('AdminID')->references('AdminID')->on('Admin')->onDelete('set null');
            $table->foreign('CustomerID')->references('CustomerID')->on('Customers')->onDelete('set null');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('Orders');
    }
};