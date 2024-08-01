<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tracking extends Model
{
    use HasFactory;

    protected $primaryKey = 'TrackingID'; // Set primary key
    protected $keyType = 'string'; // Primary key type
    public $incrementing = false; // Disable auto-increment

    protected $fillable = [
        'TrackingID',
        'OrderID',
        'Location',
        'Status',
        'Remarks',
        'TrackDate',
        'Latitude',
        'Longitude'
    ];

    // Define the relationship with Order
    public function order()
    {
        return $this->belongsTo(Orders::class, 'OrderID', 'OrderID');
    }

}
