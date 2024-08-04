<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Status extends Model
{
    use HasFactory;

    protected $table = 'Status';

    protected $primaryKey = 'StatusCode';

    public $incrementing = false;

    protected $fillable = [
        'StatusCode',
        'Description',
    ];

    public $timestamps = false;

}
