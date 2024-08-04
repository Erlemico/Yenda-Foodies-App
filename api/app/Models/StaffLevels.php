<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StaffLevels extends Model
{
    use HasFactory;

    protected $table = 'StaffLevels';

    protected $primaryKey = 'Level';

    public $incrementing = false;

    protected $fillable = [
        'Level',
        'JobDesk',
    ];

}
