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
        Schema::create('Tracking', function (Blueprint $table) {
            $table->string('TrackingID')->primary();
            $table->uuid('OrderID')->nullable();
            $table->string('Location')->nullable();
            $table->text('Remarks')->nullable();
            $table->timestamp('TrackDate')->useCurrent();
            $table->decimal('Latitude', 10, 6)->nullable();
            $table->decimal('Longitude', 10, 6)->nullable();

            $table->foreign('OrderID')->references('OrderID')->on('Orders')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('Tracking');
    }
};
