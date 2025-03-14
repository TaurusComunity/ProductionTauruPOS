<?php

use Inertia\Inertia;
use Illuminate\Support\Facades\Route;

Route::prefix('superAdmin')->group(function () {
    Route::get('/dashboard', function () {
        return Inertia::render('SuperAdmin/Dashboard');
    })->name('superAdmin.dashboard');
});

Route::get('/swap', function () {
    return Inertia::render('Swap');
})->name('swap');
