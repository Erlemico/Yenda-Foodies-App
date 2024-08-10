<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Products extends Model
{
    use HasFactory;

    protected $table = 'Products';

    protected $primaryKey = 'ProductID';

    public $incrementing = false;

    protected $fillable = [
        'ProductID',
        'ProductName',
        'Category',
        'QtyProduct',
        'UnitPrice',
        'Description',
        'ImageProduct',
        'RatingProduct',
        'CreatedBy',
        'CreatedDate',
    ];

    protected $dates = [
        'CreatedDate',
    ];

    // Relasi dengan model Staff untuk CreatedBy
    public function createdBy()
    {
        return $this->belongsTo(Staff::class, 'CreatedBy', 'AdminID');
    }

    // Relasi dengan model Category
    public function category()
    {
        return $this->belongsTo(Categories::class, 'Category', 'CategoryID');
    }
}
