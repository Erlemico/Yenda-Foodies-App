<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrderDetails extends Model
{
    use HasFactory;

    protected $table = 'OrderDetails';
    protected $primaryKey = 'OrderDetailID';
    protected $keyType = 'string';
    public $incrementing = false;

    protected $fillable = [
        'OrderDetailID',
        'OrderID',
        'ProductID',
        'ProductName',
        'Quantity',
        'UnitPrice',
        'Notes',
    ];

    public function order()
    {
        return $this->belongsTo(Orders::class, 'OrderID', 'OrderID');
    }

    public function product()
    {
        return $this->belongsTo(Products::class, 'ProductID', 'ProductID');
    }
}
