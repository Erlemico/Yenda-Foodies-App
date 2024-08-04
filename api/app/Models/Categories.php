<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Categories extends Model
{
    use HasFactory;

    protected $table = 'Categories';

    protected $primaryKey = 'CategoryID';

    public $incrementing = false;

    protected $fillable = [
        'CategoryID',
        'Description',
    ];

}
