<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Auth;

class RoleMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next, $roles): Response
    {
        //Check if user is logged in
        if (!Auth::check()){

            return response()->json([
            'status'  => 'fail',
            'message' => 'Unauthorised Access for this user'
        ], 403);
        }
        //Allow Role Based Access here

        if(in_array(Auth::user()->role, array($roles))){
            return $next($request);

        }
            return response()->json([
            'status'  => 'fail',
            'message' => 'You are not allowed to execute this request'
        ], 403);
    }
}
