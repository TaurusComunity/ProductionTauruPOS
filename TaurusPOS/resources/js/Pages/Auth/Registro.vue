<script setup>
import { Head } from '@inertiajs/vue3';
import { useForm } from '@inertiajs/vue3'
import { computed } from 'vue';
import { usePage } from '@inertiajs/inertia-vue3';
import { route } from 'ziggy-js'; 

const page = usePage();

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

<template>
 <div>

   <Head title="Registrate" />
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
           <h2 class="text-[35px] font-bold mt-[20px]">Registrate y empecemos👋</h2>
           <p class="text-[20px]">No te arrepentiras de unirte a la familia Taurus Comunity, especializado en software</p>
         </div>


         <form @submit.prevent="submit" class="mt-5 flex flex-col gap-5">
           <div v-if="form.errors.numero_documento_ct" class="text-red-500">
             {{ form.errors.numero_documento_ct }}
           </div>
           <div v-if="form.errors.password" class="text-red-500">
             {{ form.errors.password }}
           </div>

           <div class="flex justify-between items-center gap-2">
            <div class="w-[50%]">
             <p class="my-[5px] text-[14px]">Nombre:</p>

             <div
               class="w-[100%] transition-all rounded-[5px] border-[1px] border-secundary-light p-[3px] flex items-center gap-[8px]">
               <span class="material-symbols-rounded text-universal-naranja text-[20px] pl-[5px]">format_italic</span>

               <input type="text"
                 class="w-full focus:outline-none focus:border-none font-normal bg-mono-negro text-blanco"
                 placeholder="Ingresa tus nombres" v-model="form.nombres_ct" />

             </div>
           </div>

           <div class="w-[50%]">
             <p class="my-[5px] text-[14px]">Apellidos:</p>


             <div
               class="w-[100%] transition-all rounded-[5px] border-[1px] border-secundary-light p-[3px] flex items-center gap-[8px]">
               <span class="material-symbols-rounded text-universal-naranja text-[20px] pl-[5px]">format_italic</span>

               <input type="text"
                 class="w-full focus:outline-none focus:border-none font-normal bg-mono-negro text-blanco"
                 placeholder="Ingresa tus apellidos" v-model="form.apellidos_ct" />
             </div>
           </div>
           </div>
           <div class="flex justify-between items-center gap-2">
            <div class="w-[50%]">
             <p class="my-[5px] text-[14px]">Tipo de documento:</p>

             <div
               class="w-[100%] transition-all rounded-[5px] border-[1px] border-secundary-light p-[3px] flex items-center gap-[8px]">
               <span class="material-symbols-rounded text-universal-naranja text-[20px] pl-[5px]">pin</span>

               <input type="text"
                 class="w-full focus:outline-none focus:border-none font-normal bg-mono-negro text-blanco"
                 placeholder="Ingresa solo números" v-model="form.id_tipo_documento" />

             </div>
           </div>

           <div class="w-[50%]">
             <p class="my-[5px] text-[14px]">Número de documento:</p>


             <div
               class="w-[100%] transition-all rounded-[5px] border-[1px] border-secundary-light p-[3px] flex items-center gap-[8px]">
               <span class="material-symbols-rounded text-universal-naranja text-[20px] pl-[5px]">pin</span>

               <input type="text"
                 class="w-full focus:outline-none focus:border-none font-normal bg-mono-negro text-blanco"
                 placeholder="Ingresa tus email" v-model="form.numero_documento_ct" />
             </div>
           </div>
           </div>
           <div class="flex justify-between items-center gap-2">
            <div class="w-[50%]">
             <p class="my-[5px] text-[14px]">Numero telefono:</p>

             <div
               class="w-[100%] transition-all rounded-[5px] border-[1px] border-secundary-light p-[3px] flex items-center gap-[8px]">
               <span class="material-symbols-rounded text-universal-naranja text-[20px] pl-[5px]">phone</span>

               <input type="text"
                 class="w-full focus:outline-none focus:border-none font-normal bg-mono-negro text-blanco"
                 placeholder="Ingresa solo números" v-model="form.telefono_ct" />

             </div>
           </div>

           <div class="w-[50%]">
             <p class="my-[5px] text-[14px]">Email:</p>


             <div
               class="w-[100%] transition-all rounded-[5px] border-[1px] border-secundary-light p-[3px] flex items-center gap-[8px]">
               <span class="material-symbols-rounded text-universal-naranja text-[20px] pl-[5px]">email</span>

               <input type="email"
                 class="w-full focus:outline-none focus:border-none font-normal bg-mono-negro text-blanco"
                 placeholder="Ingresa tus email" v-model="form.email_ct" />
             </div>
           </div>
           </div>
           <div class="flex justify-between items-center gap-2">
            <div class="w-[50%]">
             <p class="my-[5px] text-[14px]">Ingresa una contraseña:</p>

             <div
               class="w-[100%] transition-all rounded-[5px] border-[1px] border-secundary-light p-[3px] flex items-center gap-[8px]">
               <span class="material-symbols-rounded text-universal-naranja text-[20px] pl-[5px]">password</span>

               <input type="password"
                 class="w-full focus:outline-none focus:border-none font-normal bg-mono-negro text-blanco"
                 placeholder="Ingresa solo números" v-model="form.contrasenia_ct" />

             </div>
           </div>

           <div class="w-[50%]">
             <p class="my-[5px] text-[14px]">Confirmar contraseña:</p>


             <div
               class="w-[100%] transition-all rounded-[5px] border-[1px] border-secundary-light p-[3px] flex items-center gap-[8px]">
               <span class="material-symbols-rounded text-universal-naranja text-[20px] pl-[5px]">password</span>

               <input type="password"
                 class="w-full focus:outline-none focus:border-none font-normal bg-mono-negro text-blanco"
                 placeholder="Ingresa tus email" v-model="form.contrasenia_ct_confirmation" />
             </div>
           </div>
           </div>
           

           <a href="" class="text-universal-azul text-right">Contactanos para la activación</a>

           <button type="submit" class="btn-taurus">Crear cuenta <span
               class="material-symbols-rounded bg-transparent">bolt</span></button>

           <p class="text-center">¿Ya eres parte de Taurus Comunity?, <a :href="route('login.auth')"
               class="text-universal-azul">Inicia Sesion</a>.</p>

           <p class="text-universal-azul text-center text-[12px]">Versión Deimos 1.0.0</p>

         </form>
       </div>
       <div class="right w-[40%] rounded-lg flex justify-center items-center shadowM">
         <img
           src="https://images.unsplash.com/photo-1638657527755-ca3e0d217260?q=80&w=1376&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
           alt="Img login" class="rounded-lg" </div>
     </main>
   </div>
 </div>
</template>