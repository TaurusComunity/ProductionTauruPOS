<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\Auth\RegisterController;
use Inertia\Inertia;

// Mostrar el formulario de login

Route::prefix('login')->group(function () {
    Route::get('/auth', [LoginController::class, 'show'])->name('login.auth');
    Route::post('/auth', [LoginController::class, 'login'])->name('login.post');
    Route::post('/logout', [LoginController::class, 'logout'])->name('logout');
});

// Mostrar el formulario de registro
Route::prefix('register')->group(function () {
    Route::get('/auth', function () {
        return Inertia::render('Auth/Registro');
    })->name('register.auth');

    // Ruta para procesar el registro (POST)
    Route::post('/auth', [RegisterController::class, 'register'])->name('register');
});
