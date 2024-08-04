<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tracking extends Model
{
    use HasFactory;

    protected $primaryKey = 'TrackingID';
    protected $keyType = 'string';
    public $incrementing = false;

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

    public function order()
    {
        return $this->belongsTo(Orders::class, 'OrderID', 'OrderID');
    }

}
