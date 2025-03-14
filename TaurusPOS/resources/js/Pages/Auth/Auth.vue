<script>
import { Head } from '@inertiajs/vue3';

export default {
  name: 'Auth',
  components: {
    Head,
  },
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
                    <p class="text-[20px]">Hoy es un excelente dia para vender, inicia sesión y sácale el jugo a tu App.</p>
                </div>

                <form action="#" method="post" class="mt-5 flex flex-col gap-5">
                    <div class="w-[100%]">
                        <p class="my-[5px] text-[14px]">Usuario:</p>
                        <div
                          class="w-[100%] transition-all rounded-[5px] border-[1px] border-secundary-light p-[3px] flex items-center gap-[8px]"
                        >
                          <span
                            class="material-symbols-rounded text-universal-naranja text-[20px] pl-[5px]"
                            >people</span
                          >
            
                          <input
                            type="number"
                            id="user"
                            class="w-full focus:outline-none focus:border-none font-normal bg-mono-negro text-blanco"
                            placeholder="Ingresa tu usuario establecido."
                            name="user"
                          />
                        </div>
                      </div>

                    <div class="w-[100%]">
                        <p class="my-[5px] text-[14px]">Contraseña:</p>
                        <div
                          class="w-[100%] transition-all rounded-[5px] border-[1px] border-secundary-light p-[3px] flex items-center gap-[8px]"
                        >
                          <span
                            class="material-symbols-rounded text-universal-naranja text-[20px] pl-[5px]"
                            >password</span
                          >
            
                          <input
                            type="password"
                            id="password"
                            class="w-full focus:outline-none focus:border-none font-normal bg-mono-negro text-blanco"
                            placeholder="Ingresa tu contraseña."
                            name="password"
                          />
                        </div>
                      </div>

                    <a href="" class="text-universal-azul text-right">Olvidé mi contraseña</a>

                    <button type="submit" class="btn-taurus">Iniciar sessión <span class="material-symbols-rounded bg-transparent">bolt</span></button>

                    <p class="text-center">¿No tienes una cuenta con nosotros?, <a href="" class="text-universal-azul">contáctenos</a>.</p>

                    <p class="text-universal-azul text-center text-[12px]">Versión Deimos 1.0.0</p>

                </form>
            </div>
            <div class="right w-[40%] rounded-lg flex justify-center items-center shadowM">
                <img src="https://images.unsplash.com/photo-1638657527755-ca3e0d217260?q=80&w=1376&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="Img login" class="rounded-lg"
            </div>
        </main>
  </div>
    </div>
  </template>
  

  