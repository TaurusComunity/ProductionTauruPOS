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
            'numero_documento_ct' => 'required',
            'contrasenia_ct' => 'required',
        ]);

        // ✅ Verifica si el usuario existe
        $cliente = \App\Models\ClienteTaurus::where('numero_documento_ct', $request->numero_documento_ct)->first();

        if (!$cliente) {
            return Inertia::render('Auth/Auth', [
                'errors' => ['numero_documento_ct' => 'El usuario no existe.']
            ]);
        }

        // ✅ Intenta autenticar
        if (!Auth::attempt([
            'numero_documento_ct' => $request->numero_documento_ct,
            'password' => $request->contrasenia_ct, // ✅ Laravel usará automáticamente `contrasenia_ct`
        ])) {
            return redirect()->back()->withErrors([
                'contrasenia_ct' => 'La contraseña es incorrecta.',
            ]);
        }

        $cliente = Auth::user()->load('rol', 'tienda');

        // ✅ Verifica si el token es válido
        if (!$cliente->tienda || !$cliente->tienda->token || !$cliente->tienda->token->token_activacion) {
            Auth::logout();
            return Inertia::render('Auth/Auth', [
                'errors' => ['numero_documento_ct' => 'Token no válido o inactivo.']
            ]);
        }

        // ✅ Redirige según el rol del usuario usando `redirect()->intended()`
        switch ($cliente->rol->id) {
            case 1:
                return redirect()->intended(route('admin.dashboard'));
            case 2:
                return redirect()->intended(route('cliente.dashboard'));
            case 3:
                return redirect()->intended(route('empleado.dashboard'));
            case 4:
                return Inertia::location(route('superAdmin.dashboard'));
            default:
                return redirect()->route('login.auth');
        }
    }

    // ✅ Cierre de sesión
    public function logout()
    {
        Auth::logout();
        return redirect()->route('login.auth');
    }

    public function show()
    {
        return Inertia::render('Auth/Auth');
    }
}
