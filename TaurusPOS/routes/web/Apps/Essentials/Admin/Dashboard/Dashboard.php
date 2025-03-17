<?php

use Inertia\Inertia;
use Illuminate\Support\Facades\Route;

Route::prefix('essentials/admin')->group(function () {
    Route::get('/dashboard', function () {
        return Inertia::render('Apps/Essentials/Admin/Dashboard/Dashboard');
    })->name('essentials.admin.dashboard');
});
