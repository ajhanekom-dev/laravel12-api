<?php

namespace App\Http\Controllers\API;

use Illuminate\Support\Facades\Validator;
use Auth;
use App\Http\Controllers\Controller;
use App\Models\Like;
use Illuminate\Http\Request;



class LikeController extends Controller
{

 public function react(Request $request)
{
    $user = $request->user();
    if (! $user) {
        return response()->json([
            'status' => 'fail',
             'message' => 'Unauthenticated'
    ], 401);
    }

    $validator = Validator::make($request->all(), [
        'post_id' => 'required|integer|exists:blog_posts,id',
        'status'  => 'required|integer|in:0,1' // 1=like, 0=dislike
    ]);

    if ($validator->fails()) {
        return response()->json([
            'status' => 'fail', 
            'message' => $validator->errors()
    ], 400);
    }

    $userId = $user->id;
    $postId = (int) $request->post_id;
    $status = (int) $request->status;

    // Same-user-per-post record
    $like = Like::firstOrNew(['user_id' => $userId, 'post_id' => $postId]);

    // If same reaction sent again → remove (toggle off)
    if ($like->exists && (int)$like->status === $status) {
        $like->delete();
        return response()->json([
            'status' => 'success', 
            'message' => 'Reaction removed'
        ], 200);
    }

    // alternarively
    $like->status = $status;
    $like->save();

    return response()->json([
        'status' => 'success', 
        'message' => $like->wasRecentlyCreated ? 'Reaction added' : 'Reaction updated'], 201);
}

public function reactions(Request $request, $postId)
{
    $likes     = Like::where('post_id', $postId)->where('status', 1)->count();
    $dislikes  = Like::where('post_id', $postId)->where('status', 0)->count();

    return response()->json([
        'status'    => 'success',
        'post_id'   => (int)$postId,
        'likes'     => $likes,
        'dislikes'  => $dislikes
    ], 200);
}
}