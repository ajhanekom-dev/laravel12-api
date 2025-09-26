<?php

namespace App\Http\Controllers\API;
use App\Models\Student;
use App\Http\Controllers\Controller;
// use Dotenv\Validator;
use Validator;
use Illuminate\Auth\Events\Validated;
use Illuminate\Http\Request;

class StudentApiController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $students = Student::get(); 
        return response()->json(data: [
            "status"=> "success",
            "data"=> $students
        ], status:200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //Validate out input request


        $validator = Validator::make($request->all(), 
        [
            'name' => 'required|min:4',
            'email' => 'required|unique:students,email',
            'gender' => 'required',
        ]);

        if($validator->fails())
        {
            return response()->json
            ([
            'status'    =>  'fail',
            'message'   =>  $validator-> errors() 
            ],400);
        }

        $data = $request -> all();
        Student::create($data); //this will store data into the student database table 'students'

            return response()->json
            ([
            'status'    =>  'success',
            'message'   =>  "student created successfully"
            ],201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $student = Student::find($id);
        if ($student){
            return response()->json
            ([
            'status'    =>  'success',
            'message'   =>  $student
            ],200);
        }
    
            return response()->json
            ([
            'status'    =>  'fail',
            'message'   =>  "No student record found"
            ],404);
    }
    

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //Validate input request
        $validator = Validator::make($request->all(), 
        [
            'name' => 'required|min:4',
            'email' => 'required|unique:students,email,',$id ,
            'gender' => 'required',
        ]);

        if($validator->fails())
        {
            return response()->json
            ([
            'status'    =>  'fail',
            'message'   =>  $validator-> errors() 
            ],400);
        }
     
        $student = Student::find($id); 

        if (!$student)
    {
            return response()->json
            ([
            'status'    =>  'fail',
            'message'   =>  "No student record found"
            ],404);
    }
            $student->name = $request->name;
            $student->email = $request->email;
            $student->gender = $request->gender;
            $student-> save();   //This will update the student's data

            return response()->json
            ([
            'status'    =>  'success',
            'message'   =>  "Student record updated successfully",
            'data'   =>  $student
            ],200);
    
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //Find the student whether exist or not.

        $student = Student::find($id);
        if (!$student)
    {
            return response()->json
            ([
            'status'    =>  'fail',
            'message'   =>  "No student record found"
            ],404);

    }
        $student->delete();//Delete all student data from the database
        return response()->json
            ([
            'status'    =>  'success',
            'message'   =>  'Student deleted successfully'
            ],201);
}
}
