<?php


namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\ClienteTaurus;
use App\Models\TokenAcceso;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

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
            'id_tipo_documento' => 'required|integer',
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
        ]);

        // ✅ Generar token único
        TokenAcceso::create([
            'id_cliente_ct' => $cliente->id, // ID del cliente recién creado
            'id_estado' => 1, // Estado activo (ajustar según tus necesidades)
            'token_activacion' => Str::uuid(), // Generar token único
            'id_tienda_sistematizada' => null, // Si necesitas asignar una tienda específica
        ]);

        return redirect()->route('login.auth')->with('success', 'Registro exitoso. Ahora puedes iniciar sesión.');
    }
}
