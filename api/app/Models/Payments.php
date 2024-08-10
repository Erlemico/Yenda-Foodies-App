<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Payments extends Model
{
    use HasFactory;

    public $timestamps = false;
    protected $table = 'payments';
    protected $primaryKey = 'PaymentID';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'PaymentID',
        'AdminID',
        'OrderID',
        'Amount',
        'PaymentMethod',
        'PaymentDate',
    ];

    public function staff()
    {
        return $this->belongsTo(Staff::class, 'AdminID');
    }

    public function order()
    {
        return $this->belongsTo(Orders::class, 'OrderID');
    }

}
