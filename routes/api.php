<?php

use App\Http\Controllers\API\TestApiController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\StudentApiController;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');

//First API Route for testing

// Route::get(uri: '/test', action: [TestApiController::class,'test'])->name(name: 'test-api');

// Route::get('/test', function () {
//     return response()->json([
//         'success' => true,
//         'message' => 'Your first API route is working!'
//     ]);
// });

Route::apiResource('/students', StudentApiController::class);