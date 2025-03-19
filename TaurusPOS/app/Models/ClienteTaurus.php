<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ClienteTaurus extends Authenticatable
{
    use HasFactory, Notifiable;

    protected $table = 'clientes_taurus';
    protected $primaryKey = 'id';

    protected $dates = ['fecha_creacion', 'fecha_modificacion'];

    const CREATED_AT = 'fecha_creacion';
    const UPDATED_AT = 'fecha_modificacion';
    
    protected $fillable = [
        'id_estado',
        'id_rol',
        'nombres_ct',
        'apellidos_ct',
        'id_tipo_documento',
        'numero_documento_ct',
        'contrasenia_ct',
        'email_ct',
        'telefono_ct',
    ];

    protected $hidden = [
        'contrasenia_ct',
    ];

    // Permitir que Auth::attempt() use el campo 'contrasenia_ct' como 'password'
    public function getAuthPassword()
    {
        return $this->contrasenia_ct;
    }

    // Relación con la tabla 'roles_administrativos'
    public function rol()
    {
        return $this->belongsTo(Rol::class, 'id_rol');
    }

    // Relación con la tabla 'tiendas_sistematizadas'
    public function tienda()
    {
        return $this->hasOne(TiendaSistematizada::class, 'id_cliente_taurus');
    }
}
