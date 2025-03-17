<?php

use Inertia\Inertia;
use Illuminate\Support\Facades\Route;

Route::prefix('essentials/admin')->group(function () {
    Route::get('/multisucursales', function () {
        return Inertia::render('Apps/Essentials/Admin/Multisucursales/Multisucursales');
    })->name('essentials.admin.multisucursales');
});
