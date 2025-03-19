<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\ClienteTaurus;
use App\Models\TiendaSistematizada;
use App\Models\TokenAcceso;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Inertia\Inertia;

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
        // ✅ Validar datos
        $request->validate([
            'nombres_ct' => 'required|string|max:255',
            'apellidos_ct' => 'required|string|max:255',
            'id_tipo_documento' => 'required|integer|exists:tipo_documentos,id',
            'numero_documento_ct' => 'required|string|max:20|unique:clientes_taurus,numero_documento_ct',
            'email_ct' => 'required|string|email|max:255|unique:clientes_taurus,email_ct',
            'telefono_ct' => 'required|string|max:15',
            'contrasenia_ct' => 'required|string|min:6|confirmed',
        ]);

        // ✅ Crear cliente
        $cliente = ClienteTaurus::create([
            'nombres_ct' => $request->nombres_ct,
            'apellidos_ct' => $request->apellidos_ct,
            'id_tipo_documento' => $request->id_tipo_documento,
            'numero_documento_ct' => $request->numero_documento_ct,
            'email_ct' => $request->email_ct,
            'telefono_ct' => $request->telefono_ct,
            'contrasenia_ct' => Hash::make($request->contrasenia_ct),
            'id_estado' => 1, // Estado activo por defecto
            'id_rol' => 1, // Rol por defecto
        ]);

        // ✅ Crear tienda asociada automáticamente
        $tienda = TiendaSistematizada::create([
            'id_estado' => 1, // Estado activo
            'id_aplicacion_web' => 1, // ID de aplicación por defecto (ajústalo según tu caso)
            'nombre_tienda' => 'Tienda de ' . $cliente->nombres_ct,
            'email_tienda' => $cliente->email_ct,
            'telefono_ct' => $cliente->telefono_ct,
            'direccion_ct' => 'Dirección por defecto',
            'barrio_ct' => 'Barrio por defecto',
            'logo_tienda' => '', // Si no tienes un logo inicial
        ]);

        // ✅ Asociar tienda al cliente
        $cliente->update([
            'id_tienda' => $tienda->id
        ]);

        // ✅ Generar token único para el cliente
        TokenAcceso::create([
            'id_cliente_ct' => $cliente->id,
            'id_estado' => 1, // Estado activo
            'token_activacion' => Str::uuid(),
            'id_tienda_sistematizada' => $tienda->id, // Asociar token a la tienda creada
        ]);

        // ✅ Redirigir a login
        return redirect()->route('login.auth')->with('success', 'Registro exitoso. Ahora puedes iniciar sesión.');
    }
}
