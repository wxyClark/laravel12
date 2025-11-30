<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\Dev\DevController;
use App\Http\Controllers\Dev\QueryController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

//  DEV
Route::middleware(['auth', 'admin.permission'])->namespace('Dev')->group(function () {
    Route::get('/dev', [DevController::class, 'query'])->name('dev');

    Route::post('/query/list', [QueryController::class, 'list'])->name('query.list');
    Route::post('/query/export', [QueryController::class, 'export'])->name('query.export');
    Route::get('/query/test', [QueryController::class, 'test'])->name('query.test');
});

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
