<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\BlogPost;
use App\Models\Seo;
use App\Models\BlogCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth; // ok to keep, but we won’t use it here
use Illuminate\Support\Facades\RateLimiter;


class BlogPostController extends Controller
{
public function index()
{
    $posts = BlogPost::with('seo_data')->get();

    return response()->json(
    [
        'status' => 'success', 
        'count' => count($posts),
        'data' => $posts
    ], 200);

}







public function store(Request $request)
{
        // Must be authenticated via auth:sanctum middleware
    $user = $request->user();
    if (!$user) {
        return response()->json([
            'status'  => 'fail',
            'message' => 'Unauthenticated'
        ], 401);
    }

    //Rate limit: 10 requests per minute per user
    $key = 'posts-store:' . ($user->id ?? $request->ip());
    if (RateLimiter::tooManyAttempts($key, 3)) {
        $seconds = RateLimiter::availableIn($key);
        return response()->json([
            'status'  => 'fail',
            'message' => 'Too many requests. Try again in ' . $seconds . ' seconds.'
        ], 429);
    }
    RateLimiter::hit($key, 60); // decay in 60 seconds


    // Only allow admins
    if ($user->role == 'reader') {
        return response()->json(
        ['status' => 'fail', 
        'message' => 'Unauthorized Access'
        ], 400);
    }

    // Validate input
      $validator = Validator::make($request->all(), 
        [
            'user_id'           => 'required|numeric',
            'category_id'       => 'required|numeric',
            'title'             => 'required',
            'content'           => 'required',
            'thumbnail'         => 'nullable|image|max:2048',
            'meta_title'         => 'required',
            'meta_description'   => 'required',
            'meta_keywords'      => 'required'
        ]);

    if ($validator->fails()) {
        return response()->json([
            'status'  => 'fail',
            'message' => $validator->errors()
        ], 400);
    }

    
$category = BlogCategory::find($request->category_id);
        
        if(!$category){
            return response()->json( [
            "status"    => "fail",
            "message"   => "Category not found"
        ], 404);}

    // Optional upload
    $imagePath = null;
    if ($request->hasFile('thumbnail') && $request->file('thumbnail')->isValid()) 
    {
        $file = $request->file('thumbnail');
        $fileName = time().'_'.$file->getClientOriginalName();
        $file->move(public_path('storage/posts'), $fileName);
        $imagePath = 'storage/posts/'.$fileName;
    } 

    // Build data from trusted/authenticated user

    if ($user->role == 'author') {
    $data = [
        'user_id'     => $user->id,                 
        'category_id' => $request->category_id,
        'title'       => $request->title,
        'slug'        => Str::slug($request->title),
        'content'     => $request->content,
        'excerpt'     => $request->excerpt,
        'thumbnail'   => $imagePath,
        'status'      => 'draft',
        'published_at'=> now(),
    ];}
    
    elseif ($user->role == 'admin')
    {
    $data = [
        'user_id'     => $user->id,                 
        'category_id' => $request->category_id,
        'title'       => $request->title,
        'slug'        => Str::slug($request->title),
        'content'     => $request->content,
        'excerpt'     => $request->excerpt,
        'thumbnail'   => $imagePath,
        'status'      => 'published',
        'published_at'=> now(),
    ];}

    $blogPost = BlogPost::create($data);

    $postId = $blogPost->id;

    $seoData['post_id'] =         $postId;
    $seoData['meta_title']=      $request->meta_title;
    $seoData['meta_description']=$request->meta_description;
    $seoData['meta_keywords']=   $request->meta_keywords;

    Seo::create($seoData);

    return response()->json([
        'status'  => 'success',
        'message' => 'BlogPost created successfully'
    ], 201);
}







public function update(Request $request, $id)
{
    $user = $request->user();
    if (!$user) {
        return response()->json([
        'status' => 'fail', 
        'message' => 'Unauthenticated'
        ], 401);
    }

        $key = 'posts-store:' . ($user->id ?? $request->ip());
    if (RateLimiter::tooManyAttempts($key, 3)) {
        $seconds = RateLimiter::availableIn($key);
        return response()->json([
            'status'  => 'fail',
            'message' => 'Too many requests. Try again in ' . $seconds . ' seconds.'
        ], 429);
    }
    RateLimiter::hit($key, 60); // decay in 60 seconds

    
    // Only allow admins
    if ($user->role == 'reader') {
        return response()->json(
        ['status' => 'fail', 
        'message' => 'Unauthorized Access'
        ], 400);
    }
    //Check if blog exists

    $blogPost = BlogPost::find($id);
        if(!$blogPost)
            {
        return response()->json([
            'status'  => 'fail',
            'message' => 'No BlogPost found of id___  '. $id
        ], 404);
        }
      $validator = Validator::make($request->all(), 
        [
            'user_id'           => 'required|numeric',
            'category_id'       => 'required|numeric',
            'title'             => 'required',
            'content'           => 'required',
            'meta_title'         => 'required',
            'meta_description'   => 'required',
            'meta_keywords'      => 'required'
         ]);

    if ($validator->fails()) {
        return response()->json([
            'status'  => 'fail',
            'message' => $validator->errors()
        ], 400);

    }

    $blogPost->seo()->updateOrCreate([], [
    'meta_title'       => $request->meta_title,
    'meta_description' => $request->meta_description,
    'meta_keywords'    => $request->meta_keywords,
]);
        $blogPost->category_id  = $request->category_id;
        $blogPost->user_id      = $request->user_id;
        $blogPost->title        = $request->title;
        $blogPost->slug         = Str::slug($request->title) ;
        $blogPost->content      = $request->content;
        $blogPost->excerpt      = $request->excerpt;
        $blogPost->status       = $request->status;

        $blogPost-> save(); //this updates the blogposts records in the DB
        
        $seoData = Seo::where('post_id',$blogPost->id)->first();


       

        $seoData-> meta_title       = $request->meta_title;
        $seoData-> meta_description = $request->meta_description;
        $seoData-> meta_keywords    = $request->meta_keywords;

        $seoData->save();


        return response()->json([
            'status'  => 'success',
            'message' => 'Blogpost edited successfully'
        ], 201);
    }








    public function blogPostImage(Request $request, string $id)
    {
        $blogPost = BlogPost::find($id);
        if(!$blogPost)
        {
        return response()->json([
            'status'  => 'fail',
            'message' => 'No BlogPost found of id___  '. $id
        ], 404);
        }
        $validator = Validator::make($request->all(), 
        [
            'user_id'           => 'required|numeric',
            'thumbnail'         => 'nullable|image|max:2048',

         ]);

    if ($validator->fails()) 
        {
        return response()->json([
            'status'  => 'fail',
            'message' => $validator->errors()
        ], 400);
        }
        
        $user = $request->user();
    if (! $user) 
    {
        return response()->json(
    [
        'status' => 'fail', 
        'message' => 'You are not Unauthenticated'
    ], 401);
    }

    // Only admins and authors may edit images
    if ($user->role == 'reader') {
        return response()->json(
    [
        'status' => 'fail', 
        'message' => 'You do not have admin access edit this '
    ], 400);
    }
    //Upload the image
        $imagePath = null;
    if ($request->hasFile('thumbnail') && $request->file('thumbnail')->isValid()) 
    {
        $file = $request->file('thumbnail');
        $fileName = time().'_'.$file->getClientOriginalName();
        $file->move(public_path('storage/posts'), $fileName);
        $imagePath = 'storage/posts/'.$fileName;
    } 
    //save image

    $blogPost->thumbnail = $imagePath ? $imagePath : $blogPost-> thumbnail;
    $blogPost->save();

        return response()->json(
    [
        'status' => 'Success', 
        'message' => 'Your image has been successfully updated'
    ], 201);

    }








    public function destroy(Request $request, string $id)
{
    // Must be authenticated via auth:sanctum
    $user = $request->user();
    if (! $user) {
        return response()->json(
    [
        'status' => 'fail', 
        'message' => 'You are not Unauthenticated'
    ], 401);
    }

    // Only admins may delete posts
    if ($user->role !== 'admin') {
        return response()->json(
    [
        'status' => 'fail', 
        'message' => 'You do not have admin access to delete this post'
    ], 400);
    }

    // Check if post exists
    $blogPost = BlogPost::find($id);
    if (! $blogPost) {
        return response()->json(
    [
            'status' => 'fail', 
        'message' => 'Oops, the Blogpost could not be found - check you blogpost ID'
    ], 404);
    }

    // Delete it
    $blogPost->delete();

    // Return success when post deleted successfully by admins only
    return response()->json(
    [
        'status' => 'success', 
        'message' => 'Blogpost deleted successfully'
    ], 200);
}

}

