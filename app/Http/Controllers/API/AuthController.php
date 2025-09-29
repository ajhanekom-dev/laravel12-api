<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\User;
use Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    // Registration API
    public function register(Request $request){

        // Validate
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'email' => 'required|unique:users,email',
            'password' => 'required|min:8|confirmed',
            'password_confirmation' => 'required|min:8'
        ]);

        if($validator->fails()){
            return response()->json([
                'status' => 'fail',
                'message' => $validator->errors()
            ], 400);
        }

        $data = $request->all();

        // Image Upload
        $imagePath = null;
        if($request->hasFile('profile_picture') && $request->file('profile_picture')->isValid()){
            $file = $request->file('profile_picture');

            // Generate a unique filname
            $fileName = time().'_'.$file->getClientOriginalName();

            // Move file to the public directory
            $file->move(public_path('storage/profile'), $fileName);

            // Save the relative path to the database
            $imagePath = "storage/profile/".$fileName;
        }

        $data['profile_picture'] = $imagePath;

        
        User::create($data); // Users table new record will be created

        return response()->json([
            'status' => 'success',
            'message' => 'New user created successfilly!'
        ], 201);

    }

    // Login API
    public function login(Request $request){
        // Validation

        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'password' => 'required'
        ]);

        if($validator->fails()){
            return response()->json([
                'status' => 'fail',
                'message' => $validator->errors()
            ], 400);
        }

        if(Auth::attempt(['email'=>$request->email, 'password'=>$request->password])){
            $user = Auth::user();

            $response['token'] = $user->createToken('BlogApp')->plainTextToken;
            $response['email'] = $user->email;
            $response['name'] = $user->name;

            return response()->json([
                'status' => 'success',
                'message' => 'Logged in successfully!',
                'data' => $response
            ], 200);
        } else{
            return response()->json([
                'status' => 'fail',
                'message' => 'Invalid Credentials'
            ], 400);
        }
    }

    // Profile API
    public function profile(){

        $user = Auth::user();

        return response()->json([
            'status' => 'success',
            'data' => $user
        ], 200);
    }

    // Logout API
    public function logout(){
        $user = Auth::user();
        $user->tokens()->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Logged out successfully.'
        ], 200);
    }

    
}