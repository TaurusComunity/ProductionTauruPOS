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
        Schema::create('clientes_taurus', function (Blueprint $table) {
            $table->id(); // ID autoincremental (equivalente a INT PRIMARY KEY AUTO_INCREMENT)
            $table->unsignedBigInteger('id_estado')->default(1);
            $table->string('nombres_ct')->nullable(false);
            $table->string('apellidos_ct')->nullable(false);
            $table->string('nombre_ct')->nullable(false);
            $table->unsignedBigInteger('id_tipo_documento')->nullable(false);
            $table->string('numero_documento_ct')->nullable(false);
            $table->string('email_ct')->nullable(false)->unique();
            $table->integer('telefono_ct')->nullable(false)->unique();
            $table->string('direccion_ct')->nullable(false);
            $table->string('barrio_ct')->nullable(false);
            $table->timestamp('fecha_creacion')->default(DB::raw('CURRENT_TIMESTAMP'));
            $table->timestamp('fecha_modificacion')->default(DB::raw('CURRENT_TIMESTAMP'))->useCurrentOnUpdate();
            
            // Si necesitas una relación con otra tabla, por ejemplo, estados:
            $table->foreign('id_estado')->references('id')->on('estados')->onDelete('cascade');
            $table->foreign('id_tipo_documento')->references('id')->on('tipo_documentos')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('clientes_taurus');
    }
};
