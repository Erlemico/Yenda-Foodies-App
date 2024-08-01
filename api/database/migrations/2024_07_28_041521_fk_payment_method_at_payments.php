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
        Schema::table('Payments', function (Blueprint $table) {
            $table->foreign('PaymentMethod')->references('PaymentMethod')->on('PaymentMethods')->onDelete('restrict');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('Payments', function (Blueprint $table) {
        });
    }
};
