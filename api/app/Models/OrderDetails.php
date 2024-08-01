<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrderDetails extends Model
{
    use HasFactory;

    protected $primaryKey = 'OrderDetailID'; // Set primary key
    protected $keyType = 'string'; // Primary key type
    public $incrementing = false; // Disable auto-increment

    protected $fillable = [
        'OrderDetailID',
        'OrderID',
        'ProductID',
        'ProductName',
        'Quantity',
        'UnitPrice',
        'Notes',
    ];

    // Define the relationship with Order
    public function order()
    {
        return $this->belongsTo(Orders::class, 'OrderID', 'OrderID');
    }

    // Define the relationship with Product
    public function product()
    {
        return $this->belongsTo(Products::class, 'ProductID', 'ProductID');
    }
}