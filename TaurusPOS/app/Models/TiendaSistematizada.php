<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TiendaSistematizada extends Model
{
    protected $table = 'tiendas_sistematizadas';

    protected $fillable = [
        'id_estado',
        'id_token',
        'id_aplicacion_web',
        'id_cliente_taurus',
        'logo_tienda',
        'nombre_tienda',
        'email_tienda',
        'telefono_ct',
        'direccion_ct',
        'barrio_ct'
    ];

    public function cliente()
    {
        return $this->belongsTo(ClienteTaurus::class, 'id_cliente_taurus');
    }

    public function token()
    {
        return $this->belongsTo(TokenAcceso::class, 'id_token');
    }

    public function aplicacion()
    {
        return $this->belongsTo(AplicacionWeb::class, 'id_aplicacion_web');
    }
}
