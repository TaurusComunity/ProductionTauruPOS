<script>
import { Head } from '@inertiajs/vue3';

export default {
    name: 'Dashboard',
    components: {
        Head,
    },
}
</script>

<script setup>
import DetallesPlan from '@/Components/Dashboard/DetallesPlan.vue';

import { ref, computed, onMounted, onUnmounted } from 'vue';

//
// Reloj en tiempo real
//
const dia = ref('');
const mes = ref('');
const anio = ref('');
const hora = ref('');
const saludo = ref('');

function actualizarFechaHora() {
    const fecha = new Date();
    dia.value = fecha.getDate();

    const monthNamesClock = [
        "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
        "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
    ];
    mes.value = monthNamesClock[fecha.getMonth()];
    anio.value = fecha.getFullYear();

    let horas = fecha.getHours();
    const minutos = fecha.getMinutes().toString().padStart(2, "0");
    const segundos = fecha.getSeconds().toString().padStart(2, "0");
    const periodo = horas >= 12 ? "pm" : "am";

    if (horas > 12) {
        horas -= 12;
    } else if (horas === 0) {
        horas = 12;
    }
    hora.value = `${horas}:${minutos}:${segundos} ${periodo}`;

    if (fecha.getHours() < 12) {
        saludo.value = "¡Buenos días";
    } else if (fecha.getHours() < 18) {
        saludo.value = "¡Buenas tardes";
    } else {
        saludo.value = "¡Buenas noches";
    }
}

let clockInterval = null;
onMounted(() => {
    actualizarFechaHora();
    clockInterval = setInterval(actualizarFechaHora, 1000);
});
onUnmounted(() => {
    clearInterval(clockInterval);
});

//
// Funcionalidad del calendario
//
const monthNames = [
    "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
    "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
];

const currentDate = new Date();
const currentMonth = ref(currentDate.getMonth());
const currentYear = ref(currentDate.getFullYear());
const today = currentDate.getDate();
const startDayIndex = ref(today - 1); // Comienza desde el día actual
const daysToShow = 7;

// Computed para mostrar "Mes Año"
const monthYear = computed(() => {
    return `${monthNames[currentMonth.value]} ${currentYear.value}`;
});

// Computed para generar el arreglo de días a mostrar
const daysArray = computed(() => {
    const daysInMonth = new Date(currentYear.value, currentMonth.value + 1, 0).getDate();
    let arr = [];
    const endIndex = Math.min(startDayIndex.value + daysToShow, daysInMonth);
    for (let i = startDayIndex.value; i < endIndex; i++) {
        arr.push(i + 1);
    }
    return arr;
});

// Función para cambiar el bloque de días (avanzar o retroceder)
function changeDays(step) {
    let daysInMonth = new Date(currentYear.value, currentMonth.value + 1, 0).getDate();
    startDayIndex.value += step * daysToShow;

    // Si superamos los días del mes, avanzamos al siguiente mes
    while (startDayIndex.value >= daysInMonth) {
        startDayIndex.value -= daysInMonth;
        currentMonth.value++;
        if (currentMonth.value > 11) {
            currentMonth.value = 0;
            currentYear.value++;
        }
        daysInMonth = new Date(currentYear.value, currentMonth.value + 1, 0).getDate();
    }

    // Si retrocedemos más allá del inicio del mes, retrocedemos un mes
    while (startDayIndex.value < 0) {
        currentMonth.value--;
        if (currentMonth.value < 0) {
            currentMonth.value = 11;
            currentYear.value--;
        }
        daysInMonth = new Date(currentYear.value, currentMonth.value + 1, 0).getDate();
        startDayIndex.value += daysInMonth;
    }
}

// Función para cambiar de mes
function changeMonth(step) {
    currentMonth.value += step;
    if (currentMonth.value < 0) {
        currentMonth.value = 11;
        currentYear.value--;
    } else if (currentMonth.value > 11) {
        currentMonth.value = 0;
        currentYear.value++;
    }
    // Al cambiar de mes, reiniciamos el índice al primer día
    startDayIndex.value = 0;
}

// Datos de las barras de progreso
const barsData = ref([
    {
        id: "bar1",
        title: "Sucursales activas:",
        segments: [
            { max: 1, value: 1, color: "bg-blue-500", tag: "Sucursal 1: Direccion sucursal" },
            { max: 1, value: 1, color: "bg-green-500", tag: "Sucursal 2: Direccion sucursal" }
        ],
    },
    {
        id: "bar2",
        title: "Gestión usuarios:",
        segments: [
            { max: 9999, value: 1, color: "bg-purple-500", tag: "Empleados" },
            { max: 9999, value: 1, color: "bg-yellow-500", tag: "Usuarios" },
            { max: 9999, value: 1, color: "bg-orange-500", tag: "Clientes" },
        ],
    },
    {
        id: "bar3",
        title: "Facturación POS",
        segments: [
            { max: 9999, value: 1, color: "bg-teal-500", tag: "Electronica" },
            { max: 9999, value: 1, color: "bg-pink-500", tag: "Digital" }
        ],
    },
    {
        id: "bar4",
        title: "Gestión de inventarios",
        segments: [
            { max: 9999, value: 1, color: "bg-cyan-500", tag: "Categorías" },
            { max: 9999, value: 1, color: "bg-indigo-500", tag: "Productos" },
            { max: 9999, value: 1, color: "bg-lime-500", tag: "Servicios" },
        ],
    },
    {
        id: "bar5",
        title: "Gestión de mesas:",
        segments: [
            { max: 200, value: 1, color: "bg-emerald-500", tag: "Registradas" },
        ],
    },
]);

// Función para calcular el total de valores en una barra
function barTotalValue(bar) {
    return bar.segments.reduce((sum, segment) => sum + segment.value, 0);
}

// Función para calcular el porcentaje que ocupa cada segmento
function segmentPercentage(segment, bar) {
    // Calculamos el valor máximo total entre los segmentos
    const totalMax = Math.max(...bar.segments.map(s => s.max));
    return (segment.value / totalMax) * 100;
}
</script>

<template>
    <div>

        <Head title="¡Bienvenido!" />


        <div class="bg-mono flex scrollbar-custom">
            <div class="h-[100vh] w-[60px] flex items-center p-[20px]">
                <aside
                    class="w-[60px] flex justify-center flex-col gap-2 items-center bg-secundary-default p-2 rounded-full">
                    <div class="gota h-12 w-12 shadow-essentials bg-essentials-primary rounded-full"></div>
                    <div class="btn-link">
                        <a href="" class="bg-transparent flex items-center justify-center">
                            <span class="material-symbols-rounded"> space_dashboard </span>
                        </a>
                    </div>
                    <div class="btn-link-disable">
                        <a href="" class="bg-transparent flex items-center justify-center">
                            <span class="material-symbols-rounded"> swap_horiz </span>
                        </a>
                    </div>
                    <div class="btn-link-disable">
                        <a href="" class="bg-transparent flex items-center justify-center">
                            <span class="material-symbols-rounded"> savings </span>
                        </a>
                    </div>
                    <div class="btn-link-disable">
                        <a href="" class="bg-transparent flex items-center justify-center">
                            <span class="material-symbols-rounded"> monitoring </span>
                        </a>
                    </div>
                    <div class="btn-link-disable">
                        <a href="" class="bg-transparent flex items-center justify-center">
                            <span class="material-symbols-rounded"> identity_platform </span>
                        </a>
                    </div>
                    <div class="btn-link-disable">
                        <a href="" class="bg-transparent flex items-center justify-center">
                            <span class="material-symbols-rounded"> calendar_clock </span>
                        </a>
                    </div>
                    <div class="btn-link-disable">
                        <a href="" class="bg-transparent flex items-center justify-center">
                            <span class="material-symbols-rounded"> checklist </span>
                        </a>
                    </div>
                    <div class="btn-link-disable">
                        <a href="" class="bg-transparent flex items-center justify-center">
                            <span class="material-symbols-rounded"> barcode_scanner </span>
                        </a>
                    </div>
                    <div class="btn-link-disable">
                        <a href="" class="bg-transparent flex items-center justify-center">
                            <span class="material-symbols-rounded"> qr_code_2 </span>
                        </a>
                    </div>
                    <div class="btn-link-disable">
                        <a href="" class="bg-transparent flex items-center justify-center">
                            <span class="material-symbols-rounded"> donut_small </span>
                        </a>
                    </div>
                    <div class="btn-link-disable">
                        <a href="" class="bg-transparent flex items-center justify-center">
                            <span class="material-symbols-rounded"> diversity_1 </span>
                        </a>
                    </div>
                </aside>
            </div>

            <main class="w-full h-[100%] px-[40px] py-[20px] bg-transparent">
                <header class="w-full h-[100%] flex justify-between mb-[40px]">
                    <div class="date flex gap-3 items-center">
                        <div class="dia flex items-center justify-center font-semibold h-10 w-7 shadow-essentials bg-essentials-primary rounded-full"
                            id="dia">
                            {{ dia }}
                        </div>
                        <div class="mes-año flex flex-col text-[14px] font-medium" id="mes-año">
                            <span id="mes">{{ mes }}</span>
                            <span id="anio">{{ anio }}</span>
                        </div>
                        <div class="separador h-8 w-[2px] bg-essentials-primary rounded-lg"></div>
                        <div class="hora text-[14px]" id="hora">{{ hora }}</div>
                    </div>

                    <div class="options-user flex gap-2 items-center justify-center">
                        <div class="btn-link-disable">
                            <span class="bg-transparent material-symbols-rounded">
                                notifications
                            </span>
                        </div>
                        <div class="btn-link-disable">
                            <span class="bg-transparent material-symbols-rounded">
                                settings
                            </span>
                        </div>
                        <div class="logo flex gap-3 items-center">
                            <div class="gota h-10 w-10 shadow-essentials bg-essentials-primary rounded-full"></div>
                            <div class="logo">
                                <h3 class="font-semibold">Nombre de Usuario</h3>
                                <p class="-mt-[8px] text-secundary-light text-[13px] font-medium">
                                    Rol de perfil
                                </p>
                            </div>
                        </div>
                    </div>
                </header>

                <div class="flex gap-[10px]">
                    <div class="left w-[35%] h-[85vh] flex flex-col gap-5 justify-between px-3">
                        <div class="saludo-btn flex flex-col justify-center items-center gap-3">
                            <h4 class="text-[25px] text-center">
                                <span id="saludo">{{ saludo }}</span> Nombre usuario!, espero te encuentres
                                muy bien, ¿Listo para vender?
                            </h4>
                            <p>La aplicación más profesional del mercado.</p>
                            <button
                                class="flex items-center justify-center gap-3 shadow-essentials bg-essentials-primary py-[10px] px-[40px] rounded-xl hover:shadow-lg">
                                Vender con POS
                                <span class="material-symbols-rounded"> outbound </span>
                            </button>
                        </div>

                        <div class="chart bg-transparent">
                            <div class="pastel h-[150px] w-full flex justify-center items-center my-[10px]">
                                <div class="circulo rounded-full bg-orange-400 h-full w-[150px]"></div>
                            </div>

                            <div class="info flex items-center justify-between gap-5">
                                <div class="realizados">
                                    <p class="text-semaforo-verde">Servicios realizados:</p>
                                    <p class="number text-[20px]">Numero</p>
                                </div>
                                <div class="balance">
                                    <p class="text-semaforo-verde">Balance general:</p>
                                    <p class="number text-[20px]">$ cantidad vendida</p>
                                </div>
                            </div>

                            <div class="tags flex justify-between my-2">
                                <div class="curso flex flex-col">
                                    <p class="text-[12px]">En curso:</p>
                                    <div class="tag bg-semaforo-verde rounded-lg w-full h-[4px]"></div>
                                    <span class="text-[12px]">#<span class="text-[12px]"> Servicios</span></span>
                                </div>
                                <div class="proxima flex flex-col">
                                    <p class="text-[12px]">Proximas:</p>
                                    <div class="tag bg-semaforo-amarillo rounded-lg w-full h-[4px]"></div>
                                    <span class="text-[12px]">#<span class="text-[12px]"> Servicios</span></span>
                                </div>
                                <div class="cancelada flex flex-col">
                                    <p class="text-[12px]">Canceladas:</p>
                                    <div class="tag bg-semaforo-rojo rounded-lg w-full h-[4px]"></div>
                                    <span class="text-[12px]">#<span class="text-[12px]"> Servicios</span></span>
                                </div>
                            </div>
                        </div>

                        <div class="calendar flex flex-col justify-center items-center">
                            <div class="month-nav flex justify-between items-center text-[12px] my-2">
                                <span class="material-symbols-rounded cursor-pointer" @click="changeMonth(-1)">
                                    chevron_left
                                </span>

                                <span id="monthYear" class="mx-5">{{ monthYear }}</span>
                                <span class="material-symbols-rounded cursor-pointer" @click="changeMonth(1)">
                                    chevron_right
                                </span>
                            </div>

                            <!-- <div class="weekdays flex gap-5">
              <span>Dom</span><span>Lun</span><span>Mar</span><span>Mié</span
              ><span>Jue</span><span>Vie</span><span>Sáb</span>
            </div> -->

                            <div
                                class="day-nav flex justify-between bg-mono-blanco shadowM rounded-2xl p-[15px] w-full">
                                <span class="material-symbols-rounded cursor-pointer text-mono-negro"
                                    @click="changeDays(-1)">
                                    chevron_left
                                </span>

                                <div class="days flex gap-8 bg-transparent text-mono-negro" id="daysContainer"
                                    v-for="day in daysArray" :key="day" :class="[
                                        'day', 'bg-transparent', 'font-bold',
                                        { 'text-red-400': day === today && currentMonth === new Date().getMonth() && currentYear === new Date().getFullYear() }
                                    ]">
                                    {{ day }}
                                </div>
                                <span class="material-symbols-rounded cursor-pointer text-mono-negro"
                                    @click="changeDays(1)">
                                    chevron_right
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="right w-[65%] px-3 flex flex-col justify-between">
                        <div class="encabezadoPanelDerecho">
                            <div class="encabezado flex gap-2 items-center bg-transparent">
                                <div
                                    class="gota h-[20px] w-[20px] rounded-full bg-essentials-primary shadow-essentials">
                                </div>
                                <p class="bg-transparent">Historial de movimientos:</p>
                            </div>
                            <div class="flex items-center gap-[5px] my-[5px] bg-transparent">
                                <div class="checkbox-wrapper-16">
                                    <label class="checkbox-wrapper">
                                        <input class="checkbox-input" type="checkbox" value="Todos"
                                            name="CategoriasDash" />
                                        <span class="checkbox-tile">
                                            <span class="checkbox-label">Todos</span>
                                        </span>
                                    </label>
                                </div>
                                <div class="checkbox-wrapper-16">
                                    <label class="radio-wrapper">
                                        <input class="checkbox-input" type="checkbox" name="CategoriasDash"
                                            value="Creaciones" />
                                        <span class="checkbox-tile">
                                            <span class="checkbox-label">Creaciones</span>
                                        </span>
                                    </label>
                                </div>
                                <div class="checkbox-wrapper-16">
                                    <label class="checkbox-wrapper">
                                        <input class="checkbox-input" type="checkbox" name="CategoriasDash"
                                            value="Eliminaciones" />
                                        <span class="checkbox-tile">
                                            <span class="checkbox-label">Eliminaciones</span>
                                        </span>
                                    </label>
                                </div>
                                <div class="checkbox-wrapper-16">
                                    <label class="checkbox-wrapper">
                                        <input class="checkbox-input" type="checkbox" name="CategoriasDash"
                                            value="Actualizaciones" />
                                        <span class="checkbox-tile">
                                            <span class="checkbox-label">Actualizaciones</span>
                                        </span>
                                    </label>
                                </div>
                                <div class="checkbox-wrapper-16">
                                    <label class="checkbox-wrapper">
                                        <input class="checkbox-input" type="checkbox" name="CategoriasDash"
                                            value="Ventas" />
                                        <span class="checkbox-tile">
                                            <span class="checkbox-label">Ventas</span>
                                        </span>
                                    </label>
                                </div>
                                <div class="checkbox-wrapper-16">
                                    <label class="checkbox-wrapper">
                                        <input class="checkbox-input" type="checkbox" name="CategoriasDash"
                                            value="Devoluciones" />
                                        <span class="checkbox-tile">
                                            <span class="checkbox-label">Devoluciones</span>
                                        </span>
                                    </label>
                                </div>
                                <div class="checkbox-wrapper-16">
                                    <label class="checkbox-wrapper">
                                        <input class="checkbox-input" type="checkbox" name="CategoriasDash"
                                            value="Inicio Sesion" />
                                        <span class="checkbox-tile">
                                            <span class="checkbox-label">Inicio de sesion</span>
                                        </span>
                                    </label>
                                </div>
                            </div>
                        </div>


                        <div class="cardInfo my-4 flex flex-col gap-2 max-h-[250px] overflow-y-auto scrollbar-custom">
                            <div
                                class="anuncio mr-2 flex justify-between gap-3 items-center border border-secundary-light rounded-lg p-3">
                                <div class="iconoIfo flex items-center gap-3">
                                    <span class="material-symbols-rounded bg-essentials-primary p-3 rounded-lg">
                                        privacy_tip
                                    </span>
                                    <div class="info">
                                        <p>Se ha "Accion" el productod: "Nombre del producto"</p>
                                        <div class="creacion-id flex justify-between text-[12px]">
                                            <p>Creado por: <span>"Nombre usuario"</span>.</p>
                                            <p>ID movimiento: <span>"Numero en la DB"</span>.</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="fecha-categoria flex flex-col items-end gap-2 text-[12px]">
                                    <p>Fecha creacion: <span>"Fecha del movimiento"</span></p>
                                    <p class="bg-essentials-primary rounded-[5px] p-1">
                                        Nombre Tag
                                    </p>
                                </div>
                            </div>

                        </div>

                        <DetallesPlan />

                    </div>
                </div>
            </main>


        </div>
    </div>
</template>
