<?php

namespace App\Http\Controllers\Auth;

use App\Models\ClienteTaurus;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Controller;
use Hash;

class RegisterController extends Controller
{
    // Mostrar formulario de registro
    public function show()
    {
        return Inertia::render('Auth/Registro');
    }

    // Lógica de registro
    public function register(Request $request)
    {
        $request->validate([
            'nombres_ct' => 'required|string|max:255',
            'apellidos_ct' => 'required|string|max:255',
            'id_tipo_documento' => 'required|exists:tipo_documentos,id',
            'numero_documento_ct' => 'required|string|unique:clientes_taurus,numero_documento_ct',
            'email_ct' => 'required|string|email|max:255|unique:clientes_taurus,email_ct',
            'telefono_ct' => 'required|string|max:20',
            'contrasenia_ct' => 'required|string|confirmed|min:6',
        ]);
    
        $cliente = ClienteTaurus::create([
            'nombres_ct' => $request->nombres_ct,
            'apellidos_ct' => $request->apellidos_ct,
            'id_tipo_documento' => $request->id_tipo_documento,
            'numero_documento_ct' => $request->numero_documento_ct,
            'email_ct' => $request->email_ct,
            'telefono_ct' => $request->telefono_ct,
            'contrasenia_ct' => bcrypt($request->contrasenia_ct), // Hashear la contraseña
        ]);

        return redirect()->route('login.auth')->with('success', 'Registro exitoso. Inicia sesión.');
    }
}
