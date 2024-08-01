<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StaffLevels extends Model
{
    use HasFactory;

    protected $table = 'StaffLevels'; // Sesuaikan dengan nama tabel yang Anda buat

    protected $primaryKey = 'Level'; // Tentukan primary key sesuai dengan kolom yang Anda tentukan sebagai primary key

    public $incrementing = false; // Jika primary key bukan incrementing integer, atur false

    protected $fillable = [
        'Level',
        'JobDesk',
    ];

    // Relasi atau metode tambahan dapat ditambahkan di sini
}
