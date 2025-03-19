<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class CheckRole
{
    /**
     * Manejar una solicitud entrante.
     */
    public function handle($request, Closure $next, ...$roles)
    {
        if (!Auth::check()) {
            return redirect()->route('login.auth');
        }

        // ⚠️ Verifica que el rol recibido esté en la lista
        if (!in_array(Auth::user()->id_rol, $roles)) {
            abort(403, 'No tienes permiso para acceder a esta página');
        }

        return $next($request);
    }
}
