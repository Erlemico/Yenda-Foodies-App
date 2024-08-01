<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::table('Staff', function (Blueprint $table) {
            $table->foreign('Level', 'fk_staff_level')
                  ->references('Level')
                  ->on('StaffLevels')
                  ->onDelete('restrict');
        });
    }

    public function down(): void {
        Schema::table('Staff', function (Blueprint $table) {
            $table->dropForeign('fk_staff_level');
        });
    }
};
