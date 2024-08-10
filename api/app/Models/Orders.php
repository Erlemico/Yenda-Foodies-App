<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Orders extends Model
{
    use HasFactory;

    protected $table = 'Orders';
    protected $primaryKey = 'OrderID';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'OrderID',
        'AdminID',
        'CustomerID',
        'StatusCode',
        'OrderDate',
        'TotalOrder',
        'TotalAmount',
        'DeliveryAddress',
    ];

    public function staff()
    {
        return $this->belongsTo(Staff::class, 'AdminID');
    }

    public function customer()
    {
        return $this->belongsTo(Customers::class, 'CustomerID');
    }

    public function orderDetails()
    {
        return $this->hasMany(OrderDetails::class, 'OrderID', 'OrderID');
    }
}
