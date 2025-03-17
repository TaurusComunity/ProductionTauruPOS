<script setup>
import { ref, computed } from 'vue';

const props = defineProps({
  productos: {
    type: Array,
    default: () => [
      {
        id: 1,
        nombre: 'Producto A',
        descripcion: 'Descripción del Producto A',
        categoria: 'Categoría 1',
        receta: 'Receta A',
        stock: 8,
        estado: 'Activo',
        precio_final: 15.99,
        imagen: 'https://via.placeholder.com/60'
      },
      {
        id: 2,
        nombre: 'Producto B',
        descripcion: 'Descripción del Producto B',
        categoria: 'Categoría 2',
        receta: 'Receta B',
        stock: 12,
        estado: 'Suspendido',
        precio_final: 25.50,
        imagen: 'https://via.placeholder.com/60'
      },
      {
        id: 3,
        nombre: 'Producto C',
        descripcion: 'Descripción del Producto C',
        categoria: 'Categoría 3',
        receta: 'Receta C',
        stock: 16,
        estado: 'Inactivo',
        precio_final: 30.00,
        imagen: 'https://via.placeholder.com/60'
      }
    ]
  }
});

const searchQuery = ref('');
const filteredProductos = computed(() => {
  if (!props.productos || !Array.isArray(props.productos)) return [];
  if (!searchQuery.value.trim()) return props.productos;
  return props.productos.filter(producto =>
    producto.nombre.toLowerCase().includes(searchQuery.value.toLowerCase())
  );
});

function getStockClass(stock) {
    if (stock <= 9) return 'bg-semaforo-rojo';
    if (stock >= 10 && stock <= 14) return 'bg-semaforo-amarillo';
    if (stock >= 15) return 'bg-semaforo-verde';
}

function getEstadoClass(estado) {
    if (estado === 'Inactivo') return 'bg-semaforo-rojo';
    if (estado === 'Suspendido') return 'bg-semaforo-amarillo';
    if (estado === 'Activo') return 'bg-semaforo-verde';
}
</script>

<template>
  <div>
    <!-- Campo de búsqueda -->
   

    <table class="w-full border-collapse">
      <thead>
        <tr class="text-left">
          <th>PLU</th>
          <th>Imagen</th>
          <th>Nombre</th>
          <th>Descripción</th>
          <th>Categoría</th>
          <th>Receta</th>
          <th>Stock</th>
          <th>Estado</th>
          <th>Precio final</th>
          <th>Acciones</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="producto in filteredProductos" :key="producto.id">
          <td class="text-[14px]">{{ producto.id }}</td>
          <td class="text-[14px]">
            <img
              :src="producto.imagen"
              class="rounded-lg"
              width="60"
              height="60"
              alt="Imagen de producto"
            />
          </td>
          <td class="text-[14px]">{{ producto.nombre }}</td>
          <td class="text-[14px]">{{ producto.descripcion }}</td>
          <td class="text-[14px]">{{ producto.categoria }}</td>
          <td class="text-[14px]">{{ producto.receta }}</td>
          <td class="text-[14px]">
            <span
              class="p-2 rounded-lg font-bold"
              :class="getStockClass(producto.stock)"
            >
              {{ producto.stock }} unidades
            </span>
          </td>
          <td class="text-[14px]">
            <span
              class="p-2 rounded-lg font-bold"
              :class="getEstadoClass(producto.estado)"
            >
              {{ producto.estado }}
            </span>
          </td>
          <td class="text-[14px]">
            ${{ producto.precio_final.toFixed(2) }}
          </td>
          <td>
            <div class="flex gap-2 items-center">
              <span class="cursor-pointer hover:text-red-500">
                🗑️
              </span>
              <span class="cursor-pointer hover:text-blue-400">
                👁️
              </span>
            </div>
          </td>
        </tr>
      </tbody>
    </table>

    <div
      v-if="filteredProductos.length === 0"
      class="text-center mt-10 font-bold text-2xl text-gray-500"
    >
      No hay coincidencias.
    </div>
  </div>
</template>

