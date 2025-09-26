<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
class TestApiController extends Controller
{

    public function test(): JsonResponse{
        return response()->json(data: [
            "status" => "success",
            "message"=> "App Works yes"
        ]);
    }
}
