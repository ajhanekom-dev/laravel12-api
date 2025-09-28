<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Like;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;

class LikeController extends Controller
{
    /**
     * Display a listing of the resource.
    //  */
    // public function index()
    // {
    //     //
    // }

    //Likes and dislikes
    public function react(Request $request)
    {
        $validator = Validator::make($request->all(), 
        [
            'post_id'           => 'required|integer|exists:blog_posts,id',
            'status'            => 'required|integer'
        ]);

        if ($validator->fails()) 
             {
                return response()->json(
                [
                  'status'  => 'fail',
                  'message' => $validator->errors()
                ], 400);
            }

                $userId = auth()->id();
                $postId = $request->post_id;
                $status = $request->status;

                 //if already a user leaves a reaction
                $like = Like::where('user_id', $userId)->where('post_id',$postId)->first();
      
            if($like)
            {
             if($like->status == $status)
                {
                $like->delete();    
                return response()->json([
                'status'  => 'success',
                'message' => 'Reaction removed'
                ], 201);
                 }
                else
                {
                 $like->status = $status;
                 $like->save();
                return response()->json([
                'status'  => 'success',
                 'message' => 'Reaction Updated'
                ], 201);
                 }
            } 
            else 
            {
            Like::create([
                'user_id'=> $userId,
                'post_id' => $postId,
                'status' => $status
            ],201);
            }
                return response()->json([
                'status'  => 'success',
                 'message' => 'Reaction Added'
                ], 201);
    }  
    public function reactions(Request $request,$postId){

        $likeCount = Like::where('post_id', $postId)->where('status',1)->count();
        $dislikeCount = Like::where('post_id', $postId)->where('status',2)->count();

                return response()->json([
                'status'  => 'success',
                 'likes' => $likeCount,
                 'dislikes' => $dislikeCount,
                 'post_id' => $postId
                ], 200);

    }
}

