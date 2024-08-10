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
        Schema::create('Products', function (Blueprint $table) {
            $table->string('ProductID')->primary();
            $table->string('ProductName');
            $table->string('Category');
            $table->integer('QtyProduct');
            $table->integer('UnitPrice');
            $table->text('Description')->nullable();
            $table->string('ImageProduct')->nullable();
            $table->decimal('RatingProduct', 3, 2)->nullable();
            $table->uuid('CreatedBy');
            $table->dateTime('CreatedDate')->nullable();
            $table->timestamps();
    
            // Definisi foreign key
            $table->foreign('Category')->references('CategoryID')->on('Categories')->onDelete('cascade');
            $table->foreign('CreatedBy')->references('AdminID')->on('Admin')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('Products');
    }
};
