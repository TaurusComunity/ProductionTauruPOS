<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TokenAcceso extends Model
{
    protected $table = 'token_accesos';

    protected $fillable = [
        'id_cliente_ct',
        'id_estado',
        'token_activacion',
        'id_tienda_sistematizada',
    ];

    public $timestamps = false;

    protected $primaryKey = 'id';

    // Relaciones
    public function cliente()
    {
        return $this->belongsTo(ClienteTaurus::class, 'id_cliente_tc');
    }
}
