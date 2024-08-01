<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Status extends Model
{
    use HasFactory;

    protected $table = 'Status'; // Sesuaikan dengan nama tabel yang Anda buat

    protected $primaryKey = 'StatusCode'; // Tentukan primary key sesuai dengan kolom yang Anda tentukan sebagai primary key

    public $incrementing = false; // Jika primary key bukan incrementing integer, atur false

    protected $fillable = [
        'StatusCode',
        'Description',
    ];

    public $timestamps = false; // Nonaktifkan timestamps jika tabel tidak memiliki kolom created_at dan updated_at

    // Metode atau relasi-relasi tambahan bisa ditambahkan di sini
}
