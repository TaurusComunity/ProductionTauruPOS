<?php
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

require __DIR__.'/admin.php';

Route::get('/', function () {
    return Inertia::render('Home');
});

Route::get('/auth', function () {
    return Inertia::render('Auth/Auth');
});
