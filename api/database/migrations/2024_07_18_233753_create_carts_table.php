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
        Schema::create('Cart', function (Blueprint $table) {
            $table->id('CartID');
            $table->uuid('CustomerID');
            $table->string('ProductID');
            $table->integer('Quantity');
            $table->dateTime('DateAdded')->useCurrent();

            $table->foreign('CustomerID')->references('CustomerID')->on('Customers')->onDelete('cascade');
            $table->foreign('ProductID')->references('ProductID')->on('Products')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('Cart');
    }
};
