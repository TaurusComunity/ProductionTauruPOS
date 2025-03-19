<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TiendaSistematizada extends Model
{
    protected $table = 'tiendas_sistematizadas';

    public const CREATED_AT = 'fecha_creacion';
    public const UPDATED_AT = 'fecha_modificacion';

    protected $fillable = [
        'id_estado',
        'id_token',
        'id_aplicacion_web',
        'logo_tienda',
        'nombre_tienda',
        'email_tienda',
        'telefono_ct',
        'direccion_ct',
        'barrio_ct',
    ];

    // ✅ Relación con la aplicación
    public function aplicacion()
    {
        return $this->belongsTo(AplicacionWeb::class, 'id_aplicacion_web');
    }

    public function token()
    {
        return $this->hasOne(TokenAcceso::class, 'id_tienda_sistematizada');
    }



}
