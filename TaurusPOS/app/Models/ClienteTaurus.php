<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class ClienteTaurus extends Authenticatable
{
    use Notifiable;

    // Definir la tabla y las columnas personalizadas para las fechas
    protected $table = 'clientes_taurus';

    public const CREATED_AT = 'fecha_creacion';
    public const UPDATED_AT = 'fecha_modificacion';

    // Definir los campos que pueden ser asignados en masa
    protected $fillable = [
        'nombres_ct',
        'apellidos_ct',
        'numero_documento_ct',
        'contrasenia_ct',
        'email_ct',
        'telefono_ct',
        'id_tienda',
        'id_rol',
        'id_estado',
        'id_tipo_documento',
    ];

    // ⚠️ Este método le dice a Laravel qué campo es la contraseña
    public function getAuthPassword()
    {
        return $this->contrasenia_ct;
    }

    // ⚠️ Define las relaciones correctamente
    public function rol()
    {
        return $this->belongsTo(Rol::class, 'id_rol');
    }

    public function tienda()
    {
        return $this->belongsTo(TiendaSistematizada::class, 'id_tienda');
    }

    // Relación con el modelo TipoDocumento (si es necesario)
    public function tipoDocumento()
    {
        return $this->belongsTo(TipoDocumento::class, 'id_tipo_documento');
    }

    // Método para obtener el identificador de autenticación (si usas un campo diferente)
    public function getAuthIdentifierName()
    {
        return 'numero_documento_ct';
    }

    // Método para obtener el identificador único del cliente
    public function getAuthIdentifier()
    {
        return $this->numero_documento_ct;
    }

    // Método para obtener el nombre completo del cliente (opcional)
    public function getFullNameAttribute()
    {
        return $this->nombres_ct . ' ' . $this->apellidos_ct;
    }
}
