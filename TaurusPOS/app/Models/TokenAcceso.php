<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TokenAcceso extends Model
{
    protected $table = 'token_accesos';

    protected $fillable = [
        'id_estado',
        'id_tienda_sistematizada',
        'token_activacion'
    ];

    public function tienda()
    {
        return $this->hasOne(TiendaSistematizada::class, 'id_token');
    }
}
