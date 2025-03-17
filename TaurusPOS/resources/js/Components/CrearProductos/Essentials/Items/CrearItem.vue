<script setup>
import { ref, watch, computed, onMounted } from 'vue';

// Refs para los inputs y la imagen
const file = ref(null);
const fileName = ref('');
const imageUrl = ref('');

// Datos del formulario
const form = ref({
    plu: '',
    nombreProducto: '',
    descripcionProducto: '',
    stockProducto: '',
    cantidadProducto: '',
    unidadMedidaProducto: '',
    categoriaProducto: '',
    subcategoriaProducto: '',
    proveedorProducto: '',
    marcaProducto: '',
    precioNetoProducto: '',
    descuentoProducto: '',
    ivaProducto: '',
    loteProducto: '',
    rsaProducto: '',
    vencimientoProducto: '',
})

// ✅ Función para capitalizar la primera letra
const capitalizeFirstLetter = (str) => {
    return str ? str.charAt(0).toUpperCase() + str.slice(1).toLowerCase() : ''
}

// ✅ Función para actualizar las previsualizaciones
const updatePreview = () => {
    // Recorremos las propiedades del objeto y capitalizamos el valor
    for (const key in form.value) {
        if (typeof form.value[key] === 'string') {
            form.value[key] = capitalizeFirstLetter(form.value[key].trim())
        }
    }
}

// ✅ Función para subir archivo
const handleImageUpload = (event) => {
  const selectedFile = event.target.files[0]

  if (!selectedFile) return

  const maxSize = 3 * 1024 * 1024 // 3MB
  const validExtensions = ['image/jpeg', 'image/png', 'image/gif']

  if (selectedFile.size > maxSize) {
    alert('El archivo es demasiado grande. Máximo 3MB.')
    file.value = null
    return
  }

  if (!validExtensions.includes(selectedFile.type)) {
    alert('Formato no permitido. Sube una imagen en JPG, PNG o GIF.')
    file.value = null
    return
  }

  const reader = new FileReader()
  reader.onload = () => {
    imageUrl.value = reader.result
  }
  reader.readAsDataURL(selectedFile)

  file.value = selectedFile
  fileName.value = selectedFile.name
}

// ✅ Función para cancelar archivo
const resetImage = () => {
  file.value = null
  fileName.value = ''
  imageUrl.value = ''
}

// ✅ Función para obtener valor numérico correctamente formateado
const obtenerNumero = (value) => {
    if (!value) return 0
    let valor = value.replace(/\./g, '').replace(',', '.')
    return parseFloat(valor) || 0
}

// ✅ Computada para el precio final
const precioFinal = computed(() => {
    const precioNeto = obtenerNumero(form.value.precioNetoProducto)
    const descuento = obtenerNumero(form.value.descuentoProducto)
    const iva = obtenerNumero(form.value.ivaProducto)

    const precioConDescuento = precioNeto - descuento
    const precioFinal = precioConDescuento + (precioConDescuento * (iva / 100))

    return precioFinal.toLocaleString('es-CO', {
        minimumFractionDigits: 0,
        maximumFractionDigits: 0
    })
})

// ✅ Función para formatear números en el input
const formatearNumeroInput = (event) => {
    let value = event.target.value.replace(/\./g, '')
    let numberValue = parseFloat(value)

    if (isNaN(numberValue)) {
        event.target.value = ''
        return
    }

    event.target.value = numberValue.toLocaleString('es-CO', {
        minimumFractionDigits: 0,
        maximumFractionDigits: 0
    })
}

// Actualiza la previsualización automáticamente
watch(form, updatePreview, { deep: true });

onMounted(() => {
    updatePreview();
});
</script>


<template>

    <div class="parentOver flex justify-between gap-[60px] mt-4">
        <div class="w-[60%]">
            <div class="encabezado mb-5">
                <h2 class="text-blanco text-[25px] font-semibold">Creación de mercancia</h2>
                <p class="mb-[10px] text-secundary-light">En este apartado podrás crear un nuevo item a la sucursal
                    de tu tienda, recuerda llenar todos los campos correspondientes.</p>
            </div>

            <!-- 🖼️ Contenedor de carga de imagen -->
            <div class="container cursor-pointer flex justify-between items-center gap-4">
                <!-- Área de carga -->
                <div class="wrapper w-full h-full border border-dashed border-secundary-light rounded-lg flex justify-between items-center"
                    @click="$refs.fileInput.click()">
                    <div class="file-name p-2 flex justify-between w-full">
                        <p>
                            {{
                                fileName
                                    ? `${fileName} `
                                    : 'Imagen de referencia en formato PNG, JPG, JPEG no mayor a 3Mb'
                            }}
                        </p>
                        <span class="material-symbols-rounded">
                            upload
                        </span>
                    </div>
                </div>

                <!-- Botón de cancelar -->
                <div id="cancel-btn" @click="resetImage">
                    <i class="material-symbols-rounded hover:bg-essentials-primary rounded-md">
                        close
                    </i>
                </div>

                <!-- Input oculto para la carga de archivos -->
                <input ref="fileInput" type="file" hidden accept="image/png, image/jpeg, image/jpg"
                    @change="handleImageUpload" />
            </div>

            <!-- form -->
            <form action="" method="post" @submit.prevent="">
                <div class="mt-[5px] flex justify-between gap-3 w-full">
                    <div class=" mt-[5px] w-[50%]">
                        <p class="my-[5px] text-[16px]">PLU:</p>
                        <div class="input-insertar w-full">
                            <input type="number" placeholder="Ponle identidad a tu item" v-model="form.plu">
                            <span class="material-symbols-rounded text-essentials-primary">pin</span>
                        </div>
                    </div>

                    <div class=" mt-[5px] w-[50%]">
                        <p class="my-[5px] text-[16px]">Nombre:</p>
                        <div class="input-insertar w-full">
                            <input type="text" placeholder="Escribe su nombre" v-model="form.nombreProducto"
                                name="nombreProducto">
                            <span class="material-symbols-rounded text-essentials-primary">format_italic</span>
                        </div>
                    </div>
                </div>

                <div class="mt-[5px] flex justify-between gap-3 w-full">
                    <div class="w-[50%] mt-[5px]">
                        <p class="my-[5px] text-[16px]">Categoría:</p>
                        <div class="custom-select ">
                            <select id="categoriaProducto" name="categoriaProducto">
                                <optgroup label="Selecciona una categoria">Categoria</optgroup>
                                <option value="sub1">Categoría 1</option>
                                <option value="sub2">Categoría 2</option>
                                <option value="sub3">Categoría 3</option>
                                <option value="sub4">Categoría 4</option>
                            </select>
                            <div class="select-arrow"></div>
                        </div>
                    </div>

                    <div class="w-[50%] mt-[5px]">
                        <p class="my-[5px] text-[16px]">Subcategoría:</p>
                        <div class="custom-select ">
                            <select id="subcategoriaProducto" name="subcategoriaProducto">
                                <optgroup label="Selecciona una subcategoria">Subcategoria</optgroup>
                                <option value="sub1">Subcategoría 1</option>
                                <option value="sub2">Subcategoría 2</option>
                                <option value="sub3">Subcategoría 3</option>
                                <option value="sub4">Subcategoría 4</option>
                            </select>
                            <div class="select-arrow"></div>
                        </div>
                    </div>
                </div>

                <div class="mt-[5px] flex justify-between gap-3 w-full">
                    <div class=" mt-[5px] w-[50%]">
                        <p class="my-[5px] text-[16px]">Descripción:</p>
                        <div class="input-insertar w-full">
                            <input type="text" placeholder="Describe a (nombre)" id="descripcionProducto"
                                name="descripcionProducto">
                            <span class="material-symbols-rounded text-essentials-primary">format_italic</span>
                        </div>
                    </div>

                    <div class=" mt-[5px] w-[50%]">
                        <p class="my-[5px] text-[16px]">Cantidad en Stock:</p>
                        <div class="input-insertar w-full">
                            <input type="number" placeholder="¿Cuantos tienes disponibles?" id="stockProducto"
                                name="stockProducto">
                            <span class="material-symbols-rounded text-essentials-primary">pin</span>
                        </div>
                    </div>
                </div>

                <div class="mt-[5px] flex justify-between gap-3 w-full">
                    <div class=" mt-[5px] w-[50%]">
                        <p class="my-[5px] text-[16px]">Cantidad:</p>
                        <div class="input-insertar w-full">
                            <input type="number" placeholder="Ejemplo: 400" id="cantidadProducto"
                                name="cantidadProducto">
                            <span class="material-symbols-rounded text-essentials-primary">pin</span>
                        </div>
                    </div>

                    <div class="w-[50%] mt-[5px]">
                        <p class="my-[5px] text-[16px]">Unidad de medida:</p>
                        <div class="custom-select ">
                            <select id="unidadMedidaProducto" name="unidadMedidaProducto">
                                <optgroup label="Selecciona una subcategoria">Categoria</optgroup>
                                <option value="Unidades">Unidades</option>
                                <option value="Onzas">Onzas</option>
                                <option value="Gramos">Gramos</option>
                                <option value="Mililitros">Mililitros</option>
                                <option value="Litros">Litros</option>
                                <option value="Kilos">Kilos</option>
                                <option value="Libras">Libras</option>
                            </select>
                            <div class="select-arrow"></div>
                        </div>
                    </div>
                </div>

                <div class="mt-[5px] flex justify-between gap-3 w-full">
                    <div class=" mt-[5px] w-[50%]">
                        <p class="my-[5px] text-[16px]">Marca:</p>
                        <div class="input-insertar w-full">
                            <input type="text" placeholder="Ejemplo: Coca cola" id="marcaProducto" name="marcaProducto">
                            <span class="material-symbols-rounded text-essentials-primary">format_italic</span>
                        </div>
                    </div>

                    <div class=" mt-[5px] w-[50%]">
                        <p class="my-[5px] text-[16px]">Precio neto:</p>
                        <div class="input-insertar w-full">
                            <input type="number" placeholder="Precio comprado" id="precioNetoProducto"
                                name="precioNetoProducto">
                            <span class="material-symbols-rounded text-essentials-primary">format_italic</span>
                        </div>
                    </div>
                </div>

                <div class="mt-[5px] flex justify-between gap-3 w-full">
                    <div class=" mt-[5px] w-[50%]">
                        <p class="my-[5px] text-[16px]">Descuento:</p>
                        <div class="input-insertar w-full">
                            <input type="number" placeholder="Escribe el monto" id="descuentoProducto"
                                name="descuentoProducto">
                            <span class="material-symbols-rounded text-essentials-primary">pin</span>
                        </div>
                    </div>


                    <div class=" mt-[5px] w-[50%]">
                        <p class="my-[5px] text-[16px]">IVA %:</p>
                        <div class="input-insertar w-full">
                            <input type="number" placeholder="Si tiene ICUI E IVA ingresalo asi: (ICUI+IVA)"
                                id="ivaProducto" name="ivaProducto">
                            <span class="material-symbols-rounded text-essentials-primary">pin</span>
                        </div>
                    </div>
                </div>

                <div class="mt-[5px] flex justify-between gap-3 w-full">
                    <div class=" mt-[5px] w-[50%]">
                        <p class="my-[5px] text-[16px]">Lote:</p>
                        <div class="input-insertar w-full">
                            <input type="text" placeholder="Ingresa Lote" id="loteProducto" name="loteProducto">
                            <span class="material-symbols-rounded text-essentials-primary">format_italic</span>
                        </div>
                    </div>

                    <div class=" mt-[5px] w-[50%]">
                        <p class="my-[5px] text-[16px]">Registro Sanitario :</p>
                        <div class="input-insertar w-full">
                            <input type="text" placeholder="RSA de cada producto" id="rsaProducto" name="rsaProducto">
                            <span class="material-symbols-rounded text-essentials-primary">format_italic</span>
                        </div>
                    </div>
                </div>

                <div class="mt-[5px] flex justify-between gap-3 w-full">
                    <div class=" mt-[5px] w-[50%]">
                        <p class="my-[5px] text-[16px]">Fecha vencimiento:</p>
                        <div class="input-insertar w-full">
                            <input type="date" placeholder="" id="vencimientoProducto" name="vencimientoProducto">
                            <span class="material-symbols-rounded text-essentials-primary">event</span>
                        </div>
                    </div>

                    <div class="w-[50%] mt-[5px]">
                        <p class="my-[5px] text-[16px]">Proveedor:</p>
                        <div class="custom-select ">
                            <select id="proveedorProducto" name="proveedorProducto">
                                <optgroup label="Selecciona un proveedor">Proveedor</optgroup>
                                <option value="NA">No aplica</option>
                                <option value="Jhoann Zamudio">Jhoann Zamudio</option>

                            </select>
                            <div class="select-arrow"></div>
                        </div>
                    </div>
                </div>
                <button class="btn-essentials mt-4 w-full" id="confirm-button">Confirmar creacion</button>
            </form>
        </div>

        <div class="w-[40%]  h-[80vh]">

            <p class="text-blanco text-[25px] font-semibold">Vista previa de tu item</p>

            <!-- 🔍 Vista previa de imagen -->
            <div class="image p-2 w-full flex justify-center items-center my-4" v-if="imageUrl">
                <img :src="imageUrl" alt="Vista previa"
                    class="border border-dashed border-secundary-light rounded-lg h-[400px] w-[400px] object-cover" />
            </div>



            <div class=" text-blanco  my-[15px]">
                <div class="flex justify-between items-center text-[25px] font-medium">
                    <p>{{ form.nombreProducto || 'Nombre' }}</p>
                    <p id="pluPreview">Identificador PLU</p>
                </div>
                <p class="text-secundary-light text-4" id="descripcionProductoPreview">Descripcion</p>
            </div>

            <div class="text-blanco flex items-center justify-between text-[15px] my-2">
                <p class="flex items-center gap-2">
                    <span class="material-symbols-rounded text-[15px] text-essentials-primary">
                        category
                    </span>
                    <span id="categoriaProductoPreview">Categoria</span>

                </p>
                <p class="flex items-center gap-2"><span
                        class="material-symbols-rounded text-[15px] text-essentials-primary">view_object_track</span>
                    <span id="subcategoriaProductoPreview">Subcategoria</span>

                </p>
                <p class="flex items-center gap-2 cantidad" id="stockProductoPreview">20<span
                        class="cantidad">Unidades</span></p>
            </div>

            <div class="text-blanco flex items-center justify-between text-[15px] my-2">
                <p class="flex items-center gap-2"><span
                        class="material-symbols-rounded text-[15px] text-essentials-primary">square_foot</span>
                    <span id="cantidadProductoPreview">Unidad</span><span id="unidadMedidaProductoPreview">Medida</span>

                </p>
                <p class="flex items-center gap-2"><span
                        class="material-symbols-rounded text-[15px] text-essentials-primary">person</span>
                    <span id="proveedorProductoPreview">Proveedor</span>
                </p>
                <p class="flex items-center gap-2"><span
                        class="material-symbols-rounded text-[15px] text-essentials-primary">verified</span>
                    <span id="marcaProductoPreview">Marca</span>
                </p>
            </div>

            <div class="text-blanco flex items-center justify-between text-[15px] my-2">
                <p class="flex items-center gap-2">
                    <span class="material-symbols-rounded text-[15px] text-essentials-primary">
                        payments
                    </span>
                    <span id="precioNetoProductoPreview">Precio neto</span>
                </p>
                <p class="flex items-center gap-2"><span
                        class="material-symbols-rounded text-[15px] text-essentials-primary">remove</span>
                    <span id="descuentoProductoPreview">Descuento</span>
                </p>
                <p class="flex items-center gap-2"><span
                        class="material-symbols-rounded text-[15px] text-essentials-primary">percent</span>
                    <span id="ivaProductoPreview">IVA + ICUI</span>
                </p>
            </div>

            <div class="text-blanco flex items-center justify-between text-[15px] my-2">
                <p class="flex items-center gap-2">
                    <span class="material-symbols-rounded text-[15px] text-essentials-primary">
                        table_convert
                    </span>
                    <span id="loteProductoPreview">Lote</span>
                </p>
                <p class="flex items-center gap-2"><span
                        class="material-symbols-rounded text-[15px] text-essentials-primary">news</span>
                    <span id="rsaProductoPreview">Registro Sanitario</span>
                </p>
                <p class="flex items-center gap-2"><span
                        class="material-symbols-rounded text-[15px] text-essentials-primary">event_busy</span>
                    <span id="vencimientoProductoPreview">Fecha vencimiento</span>
                </p>
            </div>

            <div class=" flex justify-between items-center">
                <div class="estado-orden flex items-center gap-2 my-2">
                    <div class="gota h-5 w-5 bg-semaforo-verde shadow-verde rounded-full"></div>
                    <p>Activo</p>
                </div>
                <p class="flex items-center gap-2 text-[40px]">
                    <span class="material-symbols-rounded text-[40px] text-essentials-primary">
                        attach_money
                    </span>
                    <span id="precioFinalPreview">0,0</span>
                </p>
            </div>
        </div>
    </div>
</template>