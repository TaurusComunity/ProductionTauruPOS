<?php

use Inertia\Inertia;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Gate;

Route::prefix('TaurusCO/superAdmin')->middleware('auth')->group(function () {
    Route::get('/dashboard', function () {
        if (!Gate::allows('access-role', 4)) {
            abort(403, 'No tienes permisos para acceder a esta sección.');
        }

        $user = auth()->user();

        abort(404);
    })->name('superAdmin.dashboard');
});
