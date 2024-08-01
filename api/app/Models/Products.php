<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Products extends Model
{
    use HasFactory;

    protected $table = 'Products'; // Sesuaikan dengan nama tabel yang Anda buat

    protected $primaryKey = 'ProductID'; // Tentukan primary key sesuai dengan kolom yang Anda tentukan sebagai primary key

    public $incrementing = false; // Jika primary key bukan incrementing integer, atur false

    protected $fillable = [
        'ProductID',
        'ProductName',
        'Category',
        'QtyProduct',
        'UnitPrice',
        'Description',
        'ImageProduct',
        'RatingProduct',
        'CreatedBy',
        'CreatedDate',
    ];

    protected $dates = [
        'CreatedDate',
    ];

    // Relasi dengan model Staff untuk CreatedBy
    public function createdBy()
    {
        return $this->belongsTo(Staff::class, 'CreatedBy', 'StaffID');
    }

    // Relasi dengan model Category
    public function category()
    {
        return $this->belongsTo(Categories::class, 'Category', 'CategoryID');
    }
}
