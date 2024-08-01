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
        Schema::create('Staff', function (Blueprint $table) {
            $table->uuid('StaffID')->primary();
            $table->string('StaffName');
            $table->string('Level');
            $table->string('NumberPhone')->nullable();
            $table->string('Email')->nullable()->unique();
            $table->string('Password')->nullable();
            $table->dateTime('CreatedDate')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('Staff');
    }
};
