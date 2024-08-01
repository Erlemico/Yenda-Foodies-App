<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PaymentMethods extends Model
{
    use HasFactory;

    protected $table = 'PaymentMethods';
    protected $primaryKey = 'PaymentMethod';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'PaymentMethod',
        'Descriprion'
    ];
}
