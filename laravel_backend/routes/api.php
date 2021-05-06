<?php

/* use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route; */

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

/* Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
}); */

use Illuminate\Http\Request;


Route::post('/register', 'UserController@register');
Route::post('/login', 'UserController@login');
Route::get('/user', 'UserController@getCurrentUser');
Route::post('/update', 'UserController@update');
Route::get('/logout', 'UserController@logout');

Route::post('/publish','UserController@publish');
Route::get('/publication_show','UserController@publication_show');


