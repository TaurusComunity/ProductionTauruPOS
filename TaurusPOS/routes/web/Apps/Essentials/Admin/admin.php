<?php

use Inertia\Inertia;
use Illuminate\Support\Facades\Route;

Route::prefix('essentials/admin')->group(function () {
    Route::get('/dashboard', function () {
        return Inertia::render('Apps/Essentials/Admin/Dashboard');
    })->name('essentials.admin.dashboard');
});

Route::get('/swap', function () {
    return Inertia::render('Swap');
})->name('swap');
