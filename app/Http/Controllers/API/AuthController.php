<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\User;
use Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Laravel\Sanctum\HasApiTokens;


class AuthController extends Controller
{
    //Register API
 
        public function register(Request $request)
    {

        //Validate
        $validator = Validator::make($request->all(), 
        [
            'name'      => 'required',
            'email'     => 'required|unique:users,email',
            'password'  => 'required|min:8|confirmed',
            'password_confirmation' => 'required|min:8',
            
        ]);

        if($validator->fails())
        {
            return response()->json( [
            "status"    => "fail",
            "message"   => $validator-> errors()
        ], 400);

        }
            $data = $request->all();

        //Upload user image (thumbnail)
        $imagepath = null;
        if($request->hasFile('profile_picture') && $request->file('profile_picture')-> isValid()){

         $file = $request->file('profile_picture');

         //Generate a unique filename

         $fileName=time().'_'.$file-> getClientOriginalName();

        //Move file to public directory 

        $file->move(public_path('storage/profile'), $fileName);

        //Save the relative path to the database

        $imagePath = "storage/profile". $fileName;

        }
        $data['profile_picture'] = $imagePath;
        
        

        //Create new users Table record

        User::create($data);  

        return response()->json(
        [
            "status" => "success",
            "message"=> "New User has been created successfully"
        ], 201);
        
    }
            public function login(Request $request)
{
    // Validation
    $validator = Validator::make($request->all(), [
        'email'    => 'required|email',
        'password' => 'required|min:8',
    ]);

    if ($validator->fails()) {
        return response()->json([
            "status"  => "fail",
            "message" => $validator->errors()
        ], 400);
    }

    // Attempt to authenticate
    if (Auth::attempt(['email' => $request->email, 'password' => $request->password])) {
        $user = Auth::user();

        $response['token'] = $user->createToken('BlogApp')->plainTextToken;
        $response['email'] = $user->email;
        $response['name']  = $user->name;

        return response()->json([
            "status"  => "success",
            "message" => "User logged in successfully",
            "data"    => $response
        ], 200);
    } else {
        return response()->json([
            "status"  => "fail",
            "message" => "Invalid credentials"
        ], 401);
    }
}
//Profile of logged in user API

    public function profile()
{
    $user = Auth::user();

    return response()->json([
        "status" => "success",
        "data"   => $user
    ], 200);
}

//Logout API
    public function logout()
{
    $user = Auth::user();
    $user->tokens()->delete();

        return response()->json([
        "status" => "success",
        "message"   => "User logged out successfully"
    ], 200);
}

}
