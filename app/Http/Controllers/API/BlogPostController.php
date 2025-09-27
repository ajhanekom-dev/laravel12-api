<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\BlogPost;
use App\Models\BlogCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth; // ok to keep, but we won’t use it here


class BlogPostController extends Controller
{
public function index()
{
    $posts = Blogpost::get();

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
        'status' => 'fail', 
        'message' => 'Unauthenticated'
        ], 401);
    }

    // Only allow admins
    if ($user->role !== 'admin') {
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
            'thumbnail'         => 'nullable|image|max:2048'
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
    ];

    $post = BlogPost::create($data);

    return response()->json([
        'status'  => 'success',
        'message' => 'BlogPost created successfully',
        'data'    => $post
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

    // Only allow admins
    if ($user->role !== 'admin') {
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
         ]);

    if ($validator->fails()) {
        return response()->json([
            'status'  => 'fail',
            'message' => $validator->errors()
        ], 400);

    }
        $blogPost->category_id  = $request->category_id;
        $blogPost->user_id      = $request->user_id;
        $blogPost->title        = $request->title;
        $blogPost->slug         = Str::slug($request->title) ;
        $blogPost->content      = $request->content;
        $blogPost->excerpt      = $request->excerpt;
        $blogPost->status       = $request->status;

        $blogPost-> save(); //this updates the blogposts records in the DB
        return response()->json([
            'status'  => 'success',
            'message' => 'Blogpost edited successfully'
        ], 201);
    }

    public function destroy(string $id)
    {

        $blogPost = BlogPost::find($id);

        if(!$blogPost)
        {
        return response()->json([
            'status'  => 'fail',
            'message' => 'Blogpost not found'
        ], 404);

        }
        $blogPost-> delete();
             return response()->json([
            'status'  => 'sucess',
            'message' => 'Blogpost deleted successfully'
        ], 201);
    }
}

