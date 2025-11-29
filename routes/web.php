<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware(['auth', 'admin.permission'])->group(function () {
    Route::get('/dev', function () {
        return view('dev.index');
    })->name('dev');
    Route::post('/dev/commonList', function () {
        dd('commonList TODO');
    })->name('dev.commonList');
    Route::post('/dev/exportList', function () {
        dd('exportList TODO');
    })->name('dev.exportList');
});


Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
