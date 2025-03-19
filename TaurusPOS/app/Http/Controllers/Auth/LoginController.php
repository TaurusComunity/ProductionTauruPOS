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
        if (
            Auth::attempt([
                'numero_documento_ct' => $request->numero_documento_ct,
                'password' => $request->password
            ])
        ) {
            $cliente = Auth::user()->load('rol', 'tienda'); // Cargar relaciones

            // Verificar si el token es válido
            if (!$cliente->tienda || !$cliente->tienda->token || !$cliente->tienda->token->token_activacion) {
                Auth::logout();
                return redirect()->back()->withErrors([
                    'numero_documento_ct' => 'Token no válido o inactivo.'
                ]);
            }

            // Redirigir según el rol
            if ($cliente->rol->id === 1) {
                return redirect()->route('superAdmin.dashboard');
            } elseif ($cliente->rol->id === 2) {
                return redirect()->route('admin.dashboard');
            } elseif ($cliente->rol->id === 3) {
                return redirect()->route('cliente.dashboard');
            }

            return redirect()->route('login.auth');
        }

        return redirect()->back()->withErrors([
            'numero_documento_ct' => 'Credenciales incorrectas'
        ]);
    }

    // Cierre de sesión
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
