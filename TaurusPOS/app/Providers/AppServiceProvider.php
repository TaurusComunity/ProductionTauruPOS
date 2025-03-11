<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Inertia\Inertia; // Asegúrate de importar Inertia

class AppServiceProvider extends ServiceProvider
{
    public function boot()
    {
        Inertia::share([
            'currentRoute' => function () {
                return request()->route() ? request()->route()->getName() : null;
            },
        ]);
    }
    
}
