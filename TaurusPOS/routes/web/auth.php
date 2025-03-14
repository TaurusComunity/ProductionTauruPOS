<?php

use Inertia\Inertia;
use Illuminate\Support\Facades\Route;

Route::prefix('login')->group(function () {
    Route::get('/auth', function () {
        return Inertia::render('Auth/Auth');
    })->name('login.auth');
});
