<script>
import { Head, useForm } from '@inertiajs/vue3'
import { computed } from 'vue';
import { usePage } from '@inertiajs/inertia-vue3';
import { route } from 'ziggy-js';
export default {
  name: 'Auth',
  components: {
    Head,
  },
}
</script>

<script setup>
const form = useForm({
  numero_documento_ct: '',
  contrasenia_ct: ''
})

const submit = () => {
  form.post('/login/auth', {
    onError: (errors) => {
      console.error('Errores:', errors) // ✅ Para depurar errores en consola
    },
    onSuccess: () => {
      console.log('Inicio de sesión exitoso') // ✅ Si el login es exitoso
    },
  })
}
</script>

<template>
  <div>
    <Head title="Login" />
    <div class="bg-mono-negro flex justify-center items-center">
      <main class="flex items-center justify-between h-[100vh] w-[80%] p-[80px] gap-16">
        <div class="left w-[60%]">
          <div class="logo flex gap-3 items-center">
            <div class="gota h-7 w-10 shadow-essentials bg-universal-naranja rounded-full"></div>
            <div class="logo">
              <h1 class="text-[20px] font-semibold">Taurus Comunity CO</h1>
              <p class="-mt-[8px] text-[14px] font-medium">Software profesional Essentials App</p>
            </div>
          </div>

          <div class="welcome">
            <h2 class="text-[35px] font-bold mt-[20px]">Bienvenido Nuevamente 👋</h2>
            <p class="text-[20px]">Hoy es un excelente día para vender, inicia sesión y sácale el jugo a tu App.</p>
          </div>

          <!-- ✅ FORMULARIO DE LOGIN -->
          <form @submit.prevent="submit" class="mt-5 flex flex-col gap-5">
            <!-- ✅ Campo Usuario -->
            <div class="w-[100%]">
              <p class="my-[5px] text-[14px]">Usuario:</p>
              <div
                class="w-[100%] transition-all rounded-[5px] border-[1px] border-secundary-light p-[3px] flex items-center gap-[8px]"
                :class="{ 'border-universal-naranja': form.errors.numero_documento_ct }"
              >
                <span class="material-symbols-rounded text-universal-naranja text-[20px] pl-[5px]">people</span>
                <input 
                  type="text"
                  v-model="form.numero_documento_ct"
                  class="w-full focus:outline-none focus:border-none font-normal bg-mono-negro text-blanco"
                  placeholder="Ingresa tu usuario establecido." 
                />
              </div>
              <span v-if="form.errors.numero_documento_ct" class="text-universal-naranja text-sm">
                {{ form.errors.numero_documento_ct }}
              </span>
            </div>

            <!-- ✅ Campo Contraseña -->
            <div class="w-[100%]">
              <p class="my-[5px] text-[14px]">Contraseña:</p>
              <div
                class="w-[100%] transition-all rounded-[5px] border-[1px] border-secundary-light p-[3px] flex items-center gap-[8px]"
                :class="{ 'border-universal-naranja': form.errors.contrasenia_ct }"
              >
                <span class="material-symbols-rounded text-universal-naranja text-[20px] pl-[5px]">password</span>
                <input 
                  type="password"
                  v-model="form.contrasenia_ct"
                  class="w-full focus:outline-none focus:border-none font-normal bg-mono-negro text-blanco"
                  placeholder="Ingresa tu contraseña." 
                />
              </div>
              <span v-if="form.errors.contrasenia_ct" class="text-universal-naranja text-sm">
                {{ form.errors.contrasenia_ct }}
              </span>
            </div>

            <a href="" class="text-universal-azul text-right">Olvidé mi contraseña</a>

            <!-- ✅ BOTÓN DE INICIAR SESIÓN -->
            <button type="submit" class="btn-taurus">
              Iniciar sesión 
              <span class="material-symbols-rounded bg-transparent">bolt</span>
            </button>

            <p class="text-center">¿No tienes una cuenta con nosotros? 
              <a :href="route('register.auth')"
                class="text-universal-azul">Registrarme</a>.</p>

            <p class="text-universal-azul text-center text-[12px]">Versión Deimos 1.0.0</p>
          </form>
        </div>

        <div class="right w-[40%] rounded-lg flex justify-center items-center shadowM">
          <img 
            src="https://images.unsplash.com/photo-1638657527755-ca3e0d217260?q=80&w=1376&auto=format&fit=crop"
            alt="Img login" 
            class="rounded-lg"
          />
        </div>
      </main>
    </div>
  </div>
</template>
