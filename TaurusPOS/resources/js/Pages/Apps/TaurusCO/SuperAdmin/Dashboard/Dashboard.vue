<template>
  <div>
    <h1>Bienvenido, {{ user.nombres_ct }} {{ user.apellidos_ct }}</h1>
    <p><strong>Documento:</strong> {{ user.numero_documento_ct }}</p>
    <p><strong>Email:</strong> {{ user.email_ct }}</p>
    <p><strong>Teléfono:</strong> {{ user.telefono_ct }}</p>
    <p><strong>Rol:</strong> {{ user.rol?.tipo_rol || 'Sin rol' }}</p>


    <br>
    <h2>Datos de la tienda vinculada:</h2>
    <p><strong>Nombre de la tienda:</strong> {{ user.tienda?.nombre_tienda || 'Sin tienda' }}</p>
    <p><strong>Dirección:</strong> {{ user.tienda?.direccion_ct || 'Sin dirección' }}</p>
    <p><strong>Ciudad:</strong> {{ user.tienda?.barrio_ct || 'Sin ciudad' }}</p>
    <p><strong>Email de la tienda:</strong> {{ user.tienda?.email_tienda || 'Sin email' }}</p>
    <p><strong>Teléfono:</strong> {{ user.tienda?.telefono_ct || 'Sin teléfono' }}</p>
    <p><strong>Fecha de creación:</strong> {{ user.tienda?.fecha_creacion || 'Sin fecha' }}</p>

    <br>
    <p><strong>Estado del cliente:</strong> {{ user.id_estado || 'Sin estado' }}</p>
    <p><strong>Estado de la tienda:</strong> {{ user.tienda?.estado?.tipo_estado || 'Sin estado' }}</p>



    <button @click="logout">Cerrar sesión</button>
  </div>
</template>

<script setup>
import { router } from '@inertiajs/vue3'

const props = defineProps({
  auth: {
    type: Object,
    required: true
  }
})

const user = props.auth.user

const logout = () => {
  router.post(route('logout'))
}
</script>
