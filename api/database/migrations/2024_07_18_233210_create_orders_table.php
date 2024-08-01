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
            $table->uuid('StaffID')->nullable();
            $table->uuid('CustomerID')->nullable();
            $table->string('StatusCode')->nullable();
            $table->string('PaymentID')->nullable();
            $table->dateTime('OrderDate')->nullable();
            $table->decimal('TotalOrder', 10, 2)->nullable();
            $table->decimal('TotalAmount', 10, 2)->nullable();
            $table->text('DeliveryAddress')->nullable();
            $table->uuid('Shipper')->nullable();
            $table->timestamps();

            $table->foreign('StaffID')->references('StaffID')->on('Staff')->onDelete('set null');
            $table->foreign('CustomerID')->references('CustomerID')->on('Customers')->onDelete('set null');
            $table->foreign('StatusCode')->references('StatusCode')->on('Status')->onDelete('set null');
            $table->foreign('Shipper')->references('StaffID')->on('Staff')->onDelete('set null');
        });
    }

    public function down(): void {
        Schema::dropIfExists('Orders');
    }
};