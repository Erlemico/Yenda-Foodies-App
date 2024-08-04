<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cart extends Model
{
    use HasFactory;

    protected $table = 'Cart';
    protected $primaryKey = 'CartID';
    public $incrementing = true;
    protected $keyType = 'int';

    protected $fillable = [
        'CustomerID',
        'ProductID',
        'Quantity',
        'DateAdded'
    ];

    public function customer()
    {
        return $this->belongsTo(Customers::class, 'CustomerID');
    }

    public function product()
    {
        return $this->belongsTo(Products::class, 'ProductID');
    }

}