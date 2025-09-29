<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Seo extends Model
{
    protected $fillable =[
        
        'post_id',
        'meta_title',
        'meta_description',
        'meta_keywords',

    ];
}
