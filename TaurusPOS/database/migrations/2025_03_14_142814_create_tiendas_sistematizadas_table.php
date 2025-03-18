<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('tiendas_sistematizadas', function (Blueprint $table) {
            $table->id(); // ID autoincremental (equivalente a INT PRIMARY KEY AUTO_INCREMENT)
            $table->unsignedBigInteger('id_estado')->default(1);
            $table->unsignedBigInteger('id_token')->unique();
            $table->unsignedBigInteger('id_aplicacion_web');
            $table->unsignedBigInteger('id_cliente_taurus');
            $table->binary('logo_tienda');
            $table->string('nombre_tienda');
            $table->string('email_tienda')->unique();
            $table->string('telefono_ct')->unique();
            $table->string('direccion_ct');
            $table->string('barrio_ct');
           
            $table->timestamp('fecha_creacion')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('fecha_modificacion')->default(DB::raw('CURRENT_TIMESTAMP'))->useCurrentOnUpdate();
            
            // Si necesitas una relación con otra tabla, por ejemplo, estados:
            $table->foreign('id_estado')->references('id')->on('estados')->onDelete('cascade');
            $table->foreign('id_token')->references('id')->on('token_accesos')->onDelete('cascade');
            $table->foreign('id_aplicacion_web')->references('id')->on('aplicaciones_web')->onDelete('cascade');
            $table->foreign('id_cliente_taurus')->references('id')->on('clientes_taurus')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tiendas_sistematizadas');
    }
};
