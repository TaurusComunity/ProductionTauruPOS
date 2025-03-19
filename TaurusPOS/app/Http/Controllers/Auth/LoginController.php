<?php
namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class LoginController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'numero_documento_ct' => 'required|exists:clientes_taurus,numero_documento_ct',
            'password' => 'required',
        ]);

        // Autenticación manual usando Auth::attempt()
        if (Auth::attempt([
            'numero_documento_ct' => $request->numero_documento_ct,
            'password' => $request->password
        ])) {
            $cliente = Auth::user()->load('rol', 'tienda'); // Cargar relaciones

            // Verificar si el token es válido
            if (!$cliente->tienda || !$cliente->tienda->token || !$cliente->tienda->token->token_activacion) {
                Auth::logout();
                return redirect()->back()->withErrors([
                    'numero_documento_ct' => 'Token no válido o inactivo.'
                ]);
            }

            // ✅ Redirigir según el rol usando Inertia::location()
            if ($cliente->rol->id === 1) {
                return Inertia::location(route('superAdmin.dashboard'));
            } elseif ($cliente->rol->id === 2) {
                return Inertia::location(route('admin.dashboard'));
            } elseif ($cliente->rol->id === 3) {
                return Inertia::location(route('cliente.dashboard'));
            }

            // Si no hay un rol válido, redirigir al login
            return Inertia::location(route('login.auth'));
        }

        // ✅ Si las credenciales son incorrectas
        return redirect()->back()->withErrors([
            'numero_documento_ct' => 'Credenciales incorrectas.'
        ]);
    }

    // ✅ Cierre de sesión
    public function logout()
    {
        Auth::logout();
        return redirect()->route('login.auth');
    }

    // ✅ Mostrar formulario de login
    public function show()
    {
        return Inertia::render('Auth/Auth');
    }
}
