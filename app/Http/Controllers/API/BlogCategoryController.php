<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller; use Illuminate\Support\Str; use Illuminate\Http\Request;
use App\Models\BlogCategory; use Illuminate\Support\Facades\Validator;

class BlogCategoryController extends Controller
{
    /**
     * Use this part to extract a specific record
     * Make sure to check http code
     */
    public function index()
    {
        $categories = BlogCategory::get();

        return response()->json(
        [
            "status" => "success", "count" => count($categories), "data"=> $categories
        ],200);
    }
    /**
     * Create a new category. Validation 1st then fails handling with val erros
     */
    public function store(Request $request)
    {
            //Validate
        $validator = Validator::make($request->all(), 
        [
            'name'=> 'required'
             
        ]);
        if($validator->fails())
        {
            return response()->json( [
            "status"    => "fail", "message"   => $validator-> errors()
        ], 400);
        }
        $data['name'] = $request->name;
        $data['slug'] = Str::slug($request->name);

        BlogCategory::create($data);

            return response()->json( [
            "status"    => "success",     "message"   => "Category Created Successfully"
        ], 201);

    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //Validate
        $validator = Validator::make($request->all(), 
        [
            'name' => 'required'
             
    ]);

        if($validator->fails())
        {
            return response()->json( [
            "status"    => "fail",  "message"   => $validator-> errors()
        ], 400);
        
        }

        $category = BlogCategory::find($id);

        if($category){

            $category->name = $request->name;
            $category->slug = Str::slug($request->name);
            $category->save();

            return response()->json( [
            "status"    => "success",       "message"   => "Category updated successfully"
        ], 200);

 }else{
            return response()->json( [
            "status"    => "fail",
            "message"   => "Category not found"
        ], 404);

       }
     }

//this is deletee
    public function destroy(string $id)
    {
    $category = BlogCategory::find($id); 

    if($category)
        {
        BlogCategory::destroy($id);

            return response()->json( [
            "status"    => "success",
            "message"   => "Category deleted successfully"
        ], 201);
        }
        else
        {
            return response()->json( [
            "status"    => "fail",
            "message"   => "Category not found"
        ], 404);

      }
  }
}