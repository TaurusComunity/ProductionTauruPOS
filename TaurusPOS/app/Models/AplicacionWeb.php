<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AplicacionWeb extends Model
{
    protected $table = 'aplicaciones_web';

    protected $fillable = [
        'id_estado',
        'id_plan_aplicacion',
        'nombre_app'
    ];

    public function tiendas()
    {
        return $this->hasMany(TiendaSistematizada::class, 'id_aplicacion_web');
    }
}
