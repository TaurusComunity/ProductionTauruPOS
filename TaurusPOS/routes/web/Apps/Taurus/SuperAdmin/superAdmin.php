<?php

use Inertia\Inertia;
use Illuminate\Support\Facades\Route;

Route::prefix('TaurusCO/superAdmin')->middleware(['auth', 'check.role:4'])->group(function () {
    Route::get('/dashboard', function () {
        return Inertia::render('Apps/Taurus/Admin/Dashboard');
    })->name('superAdmin.dashboard');
});
