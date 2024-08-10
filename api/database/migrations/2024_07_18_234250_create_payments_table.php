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
        Schema::create('Payments', function (Blueprint $table) {
            $table->string('PaymentID')->primary();
            $table->uuid('AdminID');
            $table->uuid('OrderID');
            $table->integer('Amount')->nullable();
            $table->string('PaymentMethod')->nullable();
            $table->dateTime('PaymentDate')->nullable();
            $table->string('StatusCode');

            $table->foreign('AdminID')->references('AdminID')->on('Admin')->onDelete('cascade');
            $table->foreign('OrderID')->references('OrderID')->on('Orders')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('Payments');
    }
};