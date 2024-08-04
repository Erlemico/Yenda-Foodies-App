<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('OrderDetails', function (Blueprint $table) {
            $table->uuid('OrderDetailID')->primary();
            $table->uuid('OrderID');
            $table->uuid('ProductID');
            $table->string('ProductName');
            $table->integer('Quantity');
            $table->decimal('UnitPrice', 10, 2)->nullable();
            $table->text('Notes')->nullable();
            $table->timestamps();

            $table->foreign('OrderID')->references('OrderID')->on('Orders')->onDelete('cascade');
            $table->foreign('ProductID')->references('ProductID')->on('Products')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('OrderDetails');
    }
};