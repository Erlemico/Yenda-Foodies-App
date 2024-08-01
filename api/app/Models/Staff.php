<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Staff extends Model
{
    use HasFactory;

    protected $table = 'Staff'; // Sesuaikan dengan nama tabel yang Anda buat

    protected $primaryKey = 'StaffID'; // Tentukan primary key sesuai dengan kolom yang Anda tentukan sebagai primary key

    protected $keyType = 'string'; // Tentukan tipe dari primary key, misalnya string atau UUID

    public $incrementing = false; // Jika primary key bukan incrementing integer, atur false

    protected $fillable = [
        'StaffID',
        'StaffName',
        'Level',
        'NumberPhone',
        'Email',
        'Password',
        'CreatedDate',
    ];

    protected $hidden = [
        'Password',
    ];

    // Metode atau relasi-relasi tambahan bisa ditambahkan di sini
}