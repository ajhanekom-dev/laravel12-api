<?php
namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Comment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\RateLimiter;

{
    return response()->json(['status'=>'fail','message'=>'Unauthenticated'], 401);
}

class CommentController extends Controller
{

public function index(Request $request)
{
    $user = $request->user();
    if (! $user) return response()->json(['status'=>'fail','message'=>'Unauthenticated'], 401);

    if ($user->role !== 'admin') {
        return response()->json(['status'=>'fail','message'=>'Unauthorized Access'], 400);
    }

    $key = "comments-index:{$user->id}";
    if (RateLimiter::tooManyAttempts($key, 10)) {
        return response()->json([
            'status'=>'fail',
            'message'=>'Too many requests. Try again in '.RateLimiter::availableIn($key).' seconds.'
        ], 429);
    }
    RateLimiter::hit($key, 60);

    $comments = Comment::latest('id')->get();
    return response()->json(['status'=>'success','count'=>$comments->count(),'data'=>$comments], 200);
}



    public function store(Request $request)
    {
        // Validate Input
        $validator = Validator::make($request->all(), [
            'post_id' => 'required|integer|exists:blog_posts,id',
            'content' => 'required'
        ]);

        if($validator->fails()){
            return response()->json([
                'status' => 'fail',
                'message' => $validator->errors()
            ], 400);
        }

        $data['post_id'] = $request->post_id;
        $data['user_id'] = auth()->id();
        $data['content'] = $request->content;

        Comment::create($data); // It will create new record in DB

        return response()->json([
            'status' => 'success',
            'message' => 'Comment created and waiting for admin approval'
        ],201);


    }

    // Change Comment Status
    public function changeStatus(Request $request){
        // Validate input

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
    if ($user->role !== 'admin') {
        return response()->json(
        ['status' => 'fail', 
        'message' => 'Unauthorized Access'
        ], 400);
    }
        $validator = Validator::make($request->all(), [
            'comment_id' => 'required|exists:comments,id',
            'status' => 'required'
        ]);

    if ($validator->fails()) {
        return response()->json([
            'status'  => 'fail',
            'message' => $validator->errors()
        ], 400);
        }


        $comment = Comment::find($request->comment_id);
        $comment->status = $request->status;
        $comment->save(); // It will update the status in comments table

        return response()->json([
            'status'  => 'success',
            'message' => 'Comment edited successfully'
        ], 201);

    }

    /**
     * Display the specified resource.
     */
    public function show(Request $request,$id)
    {
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
    if ($user->role !== 'admin') {
        return response()->json(
        ['status' => 'fail', 
        'message' => 'Unauthorized Access'
        ], 400);
    }
        $comments = Comment::where('post_id', $id)->where('status', 'approved')->get();
        if($comments){
            return response()->json([
                'status' => 'success',
                'count' => count($comments),
                'data' => $comments
                
            ], 200);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $comment = Comment::find($id);

        if($comment){

            Comment::destroy($id); // It will remove the comment from our DB

            return response()->json([
                'status' => 'success',
                'message' => 'Comment Deleted Successfully'
            ], 201);
        } else{
            return response()->json([
                'status' => 'fail',
                'message' => 'Comment Not Found'
            ], 404);
        }
    }
}