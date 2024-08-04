<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Staff extends Model
{
    use HasFactory;

    protected $table = 'Staff';

    protected $primaryKey = 'StaffID';

    protected $keyType = 'string';

    public $incrementing = false;

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