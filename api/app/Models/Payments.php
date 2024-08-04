<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Payments extends Model
{
    use HasFactory;

    protected $table = 'payment';
    protected $primaryKey = 'PaymentID';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'PaymentID',
        'StaffID',
        'OrderID',
        'Amount',
        'PaymentMethod',
        'PaymentDate',
        'StatusCode'
    ];

    public function staff()
    {
        return $this->belongsTo(Staff::class, 'StaffID');
    }

    public function order()
    {
        return $this->belongsTo(Orders::class, 'OrderID');
    }
    
}