<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $fillable = [
        'category_id',
        'brand_id',
        'title',
    ];

    public function comments()
    {
        return $this->morphMany(Comment::class, 'commentable');
    }

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function brand()
    {
        return $this->belongsTo(Brand::class);
    }

    public function likes()
    {
        return $this->hasMany(Like::class);
    }

    public function product_types()
    {
        return $this->hasMany(ProductType::class);
    }

    public function product_propertys()
    {
        return $this->hasMany(ProductProperty::class);
    }

    public function total_comments()
    {

        $totalComments = $this->comments->count();
        $totalAnswers = $this->comments->sum(function ($comment) {
            return $comment->answers->count();
        });

        return $totalComments + $totalAnswers;
    }
}
