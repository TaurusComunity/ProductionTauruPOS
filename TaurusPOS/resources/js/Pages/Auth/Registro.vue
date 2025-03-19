<template>
    <form @submit.prevent="submit">
      <input v-model="form.nombres_ct" type="text" placeholder="Nombres" />
      <input v-model="form.apellidos_ct" type="text" placeholder="Apellidos" />
      <input v-model="form.numero_documento_ct" type="text" placeholder="Número de documento" />
      <input v-model="form.email_ct" type="email" placeholder="Correo electrónico" />
      <input v-model="form.telefono_ct" type="text" placeholder="Teléfono" />
      <input v-model="form.contrasenia_ct" type="password" placeholder="Contraseña" />
      <input v-model="form.contrasenia_ct_confirmation" type="password" placeholder="Confirmar contraseña" />
      <button type="submit">Registrar</button>
    </form>
  </template>
  
  <script setup>
  import { useForm } from '@inertiajs/vue3'
  
  const form = useForm({
    nombres_ct: '',
    apellidos_ct: '',
    id_tipo_documento: 1,
    numero_documento_ct: '',
    email_ct: '',
    telefono_ct: '',
    contrasenia_ct: '',
    contrasenia_ct_confirmation: '',
  })
  
  function submit() {
    console.log('Enviando formulario...') // Verifica que este mensaje aparezca en consola
    form.post('/register/auth', {
      onSuccess: () => {
        console.log('Registro exitoso') // Si llega aquí, el registro fue exitoso
      },
      onError: (errors) => {
        console.log('Errores:', errors) // Si hay errores de validación, se mostrarán aquí
      }
    })
  }
  </script>
  