<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Customers extends Model
{
    use HasFactory;

    protected $table = 'Customers';

    protected $primaryKey = 'CustomerID';

    protected $keyType = 'string';

    public $incrementing = false;

    protected $fillable = [
        'CustomerID',
        'CustomerName',
        'NumberPhone',
        'Email',
        'Password',
        'CreatedDate',
    ];

    protected $hidden = [
        'Password',
    ];

}