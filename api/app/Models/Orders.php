<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Orders extends Model
{
    use HasFactory;

    protected $table = 'Orders';
    protected $primaryKey = 'OrderID';
    public $incrementing = false; // Karena OrderID adalah UUID
    protected $keyType = 'string';

    protected $fillable = [
        'OrderID',
        'StaffID',
        'CustomerID',
        'StatusCode',
        'OrderDate',
        'TotalOrder',
        'TotalAmount',
        'DeliveryAddress',
        'Shipper',
    ];

    public function staff()
    {
        return $this->belongsTo(Staff::class, 'StaffID');
    }

    public function customer()
    {
        return $this->belongsTo(Customers::class, 'CustomerID');
    }

    public function status()
    {
        return $this->belongsTo(Status::class, 'StatusCode', 'StatusCode');
    }

    public function shipper()
    {
        return $this->belongsTo(Staff::class, 'Shipper');
    }

    public function orderDetails()
    {
        return $this->hasMany(OrderDetails::class, 'OrderID', 'OrderID');
    }
}
