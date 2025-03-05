create database taurus_app;
use taurus_app;

#revisado
CREATE TABLE tipo_documentos(
	id INT PRIMARY KEY AUTO_INCREMENT,
    documento_legal ENUM('Cedula ciudadania','Tarjeta identidad','Cedula extranjeria','Pasaporte') NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO tipo_documentos (documento_legal) VALUES 
("Cedula ciudadania"),
("Tarjeta identidad"),
("Cedula extranjeria"),
("Pasaporte");

#revisado
CREATE TABLE estados(
	id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_estado ENUM('Activo','Inactivo','En curso','Finalizado','En espera','Cancelado','Reservado','Pagada','Pendiente','Estable','En peligro','En revision','Suspendido') NOT NULL,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO estados (tipo_estado) VALUES
("Activo"),
("Inactivo"),
("En curso"),
("Finalizado"),
("En espera"),
("Cancelado"),
("Reservado"),
("Pagada"),
("Pendiente"),
("Estable"),
("En peligro"),
("En revision"),
("Suspendido");

CREATE TABLE medios_pago(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    tipo_pago ENUM("Efectivo","Nequi","Daviplata","Tarjeta","Otro medio de pago") NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
	FOREIGN KEY (id_estado) REFERENCES estados(id)
);

INSERT INTO medios_pago (tipo_pago) VALUES 
("Efectivo"),
("Nequi"),
("Daviplata"),
("Tarjeta"),
("Otro medio de pago");

#revisado
CREATE TABLE planes_aplicaciones(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    nombre_plan VARCHAR(100) NOT NULL,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
	FOREIGN KEY (id_estado) REFERENCES estados(id)
);

INSERT INTO planes_aplicaciones (nombre_plan) VALUES
("Free"),
("Basic"),
("Pro+"),
("Estellar");

#revisado
CREATE TABLE detalles_plan(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_planes_aplicaciones INT NOT NULL,
    cantidad_sucursales INT NOT NULL,
    cantidad_empleados INT NOT NULL,
    cantidad_proveedores INT NOT NULL,
    cantidad_facturacion_electronica INT NOT NULL,
    cantidad_facturacion_fisica INT NOT NULL,
    cantidad_productos INT NOT NULL,
    cantidad_mesas INT NOT NULL,
    manejo_reservas ENUM("Si", "No") NOT NULL,
    manejo_contabilidad ENUM("Si","No") NOT NULL,
    manejo_pos ENUM("Si","No") NOT NULL,
    manejo_control_gastos ENUM("Si","No") NOT NULL,
    manejo_etiquetado_barras ENUM("Si","No") NOT NULL,
    manejo_codigos_qr ENUM("Si","No") NOT NULL,
    manejo_orden_trabajo ENUM("Si","No") NOT NULL,
    manejo_encuestas ENUM("Si","No") NOT NULL,
    manejo_servicios ENUM("Si","No") NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
	FOREIGN KEY (id_planes_aplicaciones) REFERENCES planes_aplicaciones(id)
);

INSERT INTO detalles_plan (
id_planes_aplicaciones, 
cantidad_sucursales, 
cantidad_empleados,
cantidad_proveedores,
cantidad_facturacion_electronica,
cantidad_facturacion_fisica,
cantidad_productos,
cantidad_mesas,
manejo_reservas,
manejo_contabilidad,
manejo_pos,
manejo_control_gastos,
manejo_etiquetado_barras,
manejo_codigos_qr,
manejo_orden_trabajo,
manejo_encuestas,
manejo_servicios
) 
VALUES
(1,9999,9999,9999,9999,9999,9999,9999,"Si","Si","Si","Si","Si","Si","Si","Si","Si"),
(2,1,10,5,10,100,30,10,"No","No","Si","No","No","No","No","No","Si"),
(3,3,20,10,60,200,90,30,"No","No","Si","Si","No","No","No","No","Si"),
(4,9999,9999,9999,9999,9999,9999,9999,"Si","Si","Si","Si","Si","Si","Si","Si","Si");

#revisado
CREATE TABLE aplicaciones_web(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT NOT NULL,
    id_planes_aplicaciones INT NOT NULL,
    nombre_app VARCHAR(100) NOT NULL,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
	FOREIGN KEY (id_estado) REFERENCES estados(id),
	FOREIGN KEY (id_planes_aplicaciones) REFERENCES planes_aplicaciones(id)
);

INSERT INTO aplicaciones_web (
id_estado,
id_planes_aplicaciones,
nombre_app
) VALUES
(1,1,"Machine App"),
(1,1,"Guru App"),
(1,1,"Smart App"),
(1,1,"Essentials App"),
(1,1,"Shopper App"),
(1,2,"Machine App"),
(1,2,"Guru App"),
(1,2,"Smart App"),
(1,2,"Essentials App"),
(1,2,"Shopper App"),
(1,3,"Machine App"),
(1,3,"Guru App"),
(1,3,"Smart App"),
(1,3,"Essentials App"),
(1,3,"Shopper App"),
(1,4,"Machine App"),
(1,4,"Guru App"),
(1,4,"Smart App"),
(1,4,"Essentials App"),
(1,4,"Shopper App");

#revisado
CREATE TABLE token_accesos(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_tienda_sistematizada INT NOT NULL,
    id_aplicacion_web INT NOT NULL,
    id_estado INT DEFAULT 1,
    token_activacion VARCHAR(250) NOT NULL UNIQUE,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_aplicacion_web) REFERENCES aplicaciones_web(id),
    FOREIGN KEY (id_estado) REFERENCES estados(id) 
);

#revisado
CREATE TABLE clientes(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_tipo_documento INT,
    nombres_cliente VARCHAR(100) NOT NULL,
    apellidos_cliente VARCHAR(250) NOT NULL,
	numero_documento_cliente VARCHAR(30) NOT NULL,
    email_cliente VARCHAR(100) NOT NULL UNIQUE,
    telefono_cliente VARCHAR(12) NOT NULL UNIQUE,
    direccion_cliente VARCHAR(100) NOT NULL,
    barrio_cliente VARCHAR(30) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_tipo_documento) REFERENCES tipo_documentos(id)
);

#revisado
CREATE TABLE tiendas_sitematizadas (
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_token INT NOT NULL,
    id_estado INT DEFAULT 1,
    id_aplicacion_web INT NOT NULL,
    id_local_conectado INT NOT NULL,
    id_tipo_documento INT NOT NULL,
    id_clientes INT NOT NULL,
    logo_tienda BLOB NOT NULL,
    nombre_tienda VARCHAR(100) NOT NULL,
    nombre_representante VARCHAR(100) NOT NULL,
    numero_documento VARCHAR(50) NOT NULL UNIQUE,
	correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(15) NOT NULL UNIQUE,
    usuario VARCHAR(100) NOT NULL UNIQUE,
    contrasenia VARCHAR(250) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
	FOREIGN KEY (id_token) REFERENCES token_accesos(id),
	FOREIGN KEY (id_estado) REFERENCES estados(id),
	FOREIGN KEY (id_aplicacion_web) REFERENCES aplicaciones_web(id),
    FOREIGN KEY (id_tipo_documento) REFERENCES tipo_documentos(id),
	FOREIGN KEY (id_clientes) REFERENCES clientes(id)
);

#revisado
CREATE TABLE roles(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    tipo_rol ENUM("Administrador","Empleado") NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO roles (tipo_rol) VALUES 
("Administrador"),
("Empleado");

#revisado
CREATE TABLE empleados(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_local_conectado INT,
    id_tipo_documento INT,
    id_rol INT,
    foto_empleado BLOB NOT NULL,
    nombres_empleado VARCHAR(100) NOT NULL,
    apellidos_empleado VARCHAR(100) NOT NULL,
    numero_documento_empleado VARCHAR(20) NOT NULL UNIQUE,
	email_empleado VARCHAR(100) NOT NULL UNIQUE,
    telefono_empleado VARCHAR(13) NOT NULL UNIQUE,
    genero_empleado ENUM("Masculino", "Femenino") NOT NULL,
    direccion_residencia_empleado VARCHAR(250) NOT NULL,
    cargo_empleado VARCHAR(100) NOT NULL,
    salario_base_empleado VARCHAR(100) NOT NULL,
    horario_trabajo_empleado VARCHAR(100) NOT NULL,
    tipo_contrato ENUM("Indefinido","Fijo","Obra labor","Prestacion de servicios","Temporal","Pasantia") NOT NULL,
    hoja_vida_empleado BLOB NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
   FOREIGN KEY (id_estado) REFERENCES estados(id),
   FOREIGN KEY (id_tipo_documento) REFERENCES tipo_documentos(id),
   FOREIGN KEY (id_rol) REFERENCES roles(id)
);

#revisado
CREATE TABLE proveedores(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_local_conectado INT,
    nombres_proveedor VARCHAR(50) NOT NULL,
    apellidos_proveedor VARCHAR(50) NOT NULL,
    nombre_empresa VARCHAR(100) NOT NULL,
    email_proveedor VARCHAR(100) NOT NULL,
    telefono_proveedor VARCHAR(13) NOT NULL,
    tipo_producto VARCHAR(250) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id)
);

#revisado
CREATE TABLE subcategorias(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    nombre_subcategoria VARCHAR(100) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id)
);

#revisado
CREATE TABLE categorias(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_subcategoria INT,
    nombre_categoria VARCHAR(100) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_subcategoria) REFERENCES subcategorias(id)
);

#revisado
CREATE TABLE productos_universales(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    nombre_aplicacion ENUM("Machine App","Guru App","Smart App","Essentials App","Shooper App") NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id)
);

#revisado
CREATE TABLE productos_shopper(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_producto_universal INT,
    id_categoria INT,
    imagen_referencia_producto BLOB NOT NULL,
    PLU_producto VARCHAR(100) NOT NULL UNIQUE,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion_producto VARCHAR(250) NOT NULL,
    cantidad_stock_producto VARCHAR(50) NOT NULL,
    unidad_medida_producto VARCHAR(100) NOT NULL,
    cantidad_producto VARCHAR(100) NOT NULL,
    marca_producto VARCHAR(100) NOT NULL,
    color_producto VARCHAR(50) NOT NULL,
    talla_producto VARCHAR(5) NOT NULL,
    material_producto VARCHAR(30) NOT NULL,
    estilo_producto ENUM("Formal","Ocasion","Deportivo","Oversize","Skinny","Playero","Invierno","Verano","Estudiantil","juvenil","Medico","Pijama"),
    garantia_producto VARCHAR(20) DEFAULT "No aplica",
    precio_neto_producto DECIMAL(10,2) NOT NULL,
    iva_producto VARCHAR(5) NOT NULL,
    descuento_producto DECIMAL(10,2) NOT NULL,
    precio_final DECIMAL(10,2) AS((precio_neto_producto - descuento_producto)*(1+(iva_producto / 100 ))) STORED NOT NULL,
    proveedor_producto VARCHAR(100) NOT NULL,
    lote_producto VARCHAR(50) NOT NULL,
    fecha_vencimiento DATE DEFAULT "2999-12-31",
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_producto_universal) REFERENCES productos_universales(id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

#revisado
CREATE TABLE recetas_productos(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_producto_essentials INT,
    ingrediente VARCHAR(100) NOT NULL,
    precio_promedio DECIMAL(10,2) NOT NULL,
    cantidad_gramos INT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

#revisado
CREATE TABLE productos_essentials(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_producto_universal INT,
    id_categoria INT,
    id_receta_producto INT,
    imagen_referencia_producto BLOB NOT NULL,
    PLU_producto VARCHAR(100) NOT NULL UNIQUE,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion_producto VARCHAR(250) NOT NULL,
    cantidad_stock_producto VARCHAR(50) NOT NULL,
    unidad_medida_producto VARCHAR(100) NOT NULL,
    cantidad_producto VARCHAR(100) NOT NULL,
    marca_producto VARCHAR(100) NOT NULL,
    precio_neto_producto DECIMAL(10,2) NOT NULL,
    iva_producto VARCHAR(5) NOT NULL,
    descuento_producto DECIMAL(10,2) NOT NULL,
    precio_final DECIMAL(10,2) AS((precio_neto_producto - descuento_producto)*(1+(iva_producto / 100 ))) STORED NOT NULL,
    proveedor_producto VARCHAR(100) NOT NULL,
    lote_producto VARCHAR(50) NOT NULL,
    registro_sanitario_producto VARCHAR(150) NOT NULL,
    fecha_vencimiento DATE DEFAULT "2999-12-31",
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_producto_universal) REFERENCES productos_universales(id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id),
    FOREIGN KEY (id_receta_producto) REFERENCES recetas_productos(id)
);

#revisado
CREATE TABLE productos_smart(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_producto_universal INT,
    id_categoria INT,
    imagen_referencia_producto BLOB NOT NULL,
    PLU_producto VARCHAR(100) NOT NULL UNIQUE,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion_producto VARCHAR(250) NOT NULL,
    cantidad_stock_producto VARCHAR(50) NOT NULL,
    referencia_producto VARCHAR(100) NOT NULL,
    marca_producto VARCHAR(100) NOT NULL,
    compatibilidad_entre_modelos VARCHAR(100) NOT NULL,
    color_producto VARCHAR(50) NOT NULL,
    IMEI_1 VARCHAR(16) DEFAULT "No aplica",
    IMEI_2 VARCHAR(16) DEFAULT "No aplica",
    precio_neto_producto DECIMAL(10,2) NOT NULL,
    iva_producto VARCHAR(5) NOT NULL,
    descuento_producto DECIMAL(10,2) NOT NULL,
    precio_final DECIMAL(10,2) AS((precio_neto_producto - descuento_producto)*(1+(iva_producto / 100 ))) STORED NOT NULL,
    proveedor_producto VARCHAR(100) NOT NULL,
    lote_producto VARCHAR(50) NOT NULL,
    fecha_vencimiento DATE DEFAULT "2999-12-31",
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_producto_universal) REFERENCES productos_universales(id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

#revisado
CREATE TABLE productos_guru(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_producto_universal INT,
    id_categoria INT,
    imagen_referencia_producto BLOB NOT NULL,
    PLU_producto VARCHAR(100) NOT NULL UNIQUE,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion_producto VARCHAR(250) NOT NULL,
    cantidad_stock_producto VARCHAR(50) NOT NULL,
    unidad_medida_producto VARCHAR(100) NOT NULL,
    cantidad_producto VARCHAR(100) NOT NULL,
    marca_producto VARCHAR(100) NOT NULL,
    precio_neto_producto DECIMAL(10,2) NOT NULL,
    iva_producto VARCHAR(5) NOT NULL,
    descuento_producto DECIMAL(10,2) NOT NULL,
    precio_final DECIMAL(10,2) AS((precio_neto_producto - descuento_producto)*(1+(iva_producto / 100 ))) STORED NOT NULL,
    proveedor_producto VARCHAR(100) NOT NULL,
    lote_producto VARCHAR(50) NOT NULL,
    registro_sanitario_producto VARCHAR(100) NOT NULL,
    fecha_vencimiento DATE DEFAULT "2999-12-31",
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_producto_universal) REFERENCES productos_universales(id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
    
);

#revisado
CREATE TABLE productos_machine(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_producto_universal INT,
    id_categoria INT,
    imagen_referencia_producto BLOB NOT NULL,
    PLU_producto VARCHAR(100) NOT NULL UNIQUE,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion_producto VARCHAR(250) NOT NULL,
    cantidad_stock_producto VARCHAR(50) NOT NULL,
    unidad_medida_producto VARCHAR(100) NOT NULL,
    cantidad_producto VARCHAR(100) NOT NULL,
    referencia_producto VARCHAR(100) NOT NULL,
    modelo_producto VARCHAR(100) NOT NULL,
    marca_producto VARCHAR(100) NOT NULL,
    compatibilidad_entre_modelos VARCHAR(100) NOT NULL,
    precio_neto_producto DECIMAL(10,2) NOT NULL,
    iva_producto VARCHAR(5) NOT NULL,
    descuento_producto DECIMAL(10,2) NOT NULL,
    precio_final DECIMAL(10,2) AS((precio_neto_producto - descuento_producto)*(1+(iva_producto / 100 ))) STORED NOT NULL,
    proveedor_producto VARCHAR(100) NOT NULL,
    lote_producto VARCHAR(50) NOT NULL,
    fecha_vencimiento DATE DEFAULT "2999-12-31",
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_producto_universal) REFERENCES productos_universales(id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

#revisado
CREATE TABLE servicios_universales(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    nombre_aplicacion ENUM("Machine App","Guru App","Smart App","Essentials App","Shooper App") NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id)
);

#revisado
CREATE TABLE servicios(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_servicio_universal INT,
    id_categoria INT,
    imagen_referencia_servcio BLOB NOT NULL,
    PLU_servicio VARCHAR(100) NOT NULL UNIQUE,
    nombre_servicio VARCHAR(100) NOT NULL,
    descripcion_servicio VARCHAR(250) NOT NULL,
    tipo_servicio VARCHAR(100) NOT NULL,
    incluye_productos BOOLEAN DEFAULT false,
    duracion_estimada VARCHAR(20) NOT NULL,
    garantia_servicio VARCHAR(10) NOT NULL,
    precio_neto_servicio DECIMAL(10,2) NOT NULL,
    iva_servicio VARCHAR(5) NOT NULL,
    descuento_servicio DECIMAL(10,2) NOT NULL,
    precio_final DECIMAL(10,2) AS((precio_neto_servicio - descuento_servicio)*(1+(iva_servicio / 100 ))) STORED NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
	FOREIGN KEY (id_servicio_universal) REFERENCES servicios_universales(id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

#revisado
CREATE TABLE encuestas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    nombre_usuario VARCHAR(100) NOT NULL,
    comentario VARCHAR(250) NOT NULL,
    puntuacion VARCHAR(5) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id)
);

#revisado
CREATE TABLE contabilidad_empleados(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    tipo_contabilidad ENUM("Historico salario base","Bonificaciones empleados","Pagos horas extras empleados","Descuento deducciones empleados","Control anticipos empleados","Contratos empleados","Nominas empleados","Historico contratos empleados"),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id)
);

#revisado
CREATE TABLE nominas_empleados(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 9,
    id_contabilidad_empleado INT,
    id_empleado INT,
    id_local_conectado INT,
    id_metodo_pago INT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    salario_base DECIMAL(10,2) NOT NULL,
    valor_hora_extra DECIMAL(10,2) NOT NULL,
    horas_extras INT DEFAULT 0,
    bonificaciones DECIMAL(10,2) DEFAULT 0.00,
    descuentos DECIMAL(10,2) DEFAULT 0.00,
    total_pagar DECIMAL(10,2) AS ((salario_base + bonificaciones) - (descuentos) + (horas_extras * valor_hora_extra) ) STORED,
    estado_pago ENUM("Pagado","Vencida","Pendiente pago") DEFAULT "Pendiente pago",
    fecha_pago DATE NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_contabilidad_empleado) REFERENCES contabilidad_empleados(id),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id)
);

#revisado
CREATE TABLE contratos_empleados(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_contabilidad_empleado INT,
    id_empleado INT,
    id_local_conectado INT,
	tipo_contrato ENUM("Indefinido","Fijo","Obra labor","Prestacion de servicios","Temporal","Pasantia") NOT NULL,
    fecha_inicio DATE NOT NULL,
	fecha_fin DATE DEFAULT "2999-12-31",
    salario_neto DECIMAL(10,2) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    jornada ENUM("Completa","Medio tiempo") NOT NULL,
    horarios VARCHAR(50) NOT NULL,
    motivo_finalizacion VARCHAR(100) DEFAULT "Sin modificar, aun continua con su contrato activo.",
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_contabilidad_empleado) REFERENCES contabilidad_empleados(id),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id)
);

#revisado
CREATE TABLE control_anticipos_empleados(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 3,
    id_contabilidad_empleado INT,
    id_empleado INT,
    monto_anticipo DECIMAL(10,2) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_contabilidad_empleado) REFERENCES contabilidad_empleados(id),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id)
);

#revisado
CREATE TABLE descuento_deducciones(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 3,
    id_contabilidad_empleado INT,
    id_empleado INT,
    tipo_descuento ENUM("Descuento","Prestamo","Avance nomina") NOT NULL,
    monto_descontar DECIMAL(10,2) NOT NULL,
    justificacion_descuento VARCHAR(100) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_contabilidad_empleado) REFERENCES contabilidad_empleados(id),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id)
);

#revisado
CREATE TABLE pagos_horas_extras_empleados(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 3,
    id_contabilidad_empleado INT,
    id_empleado INT,
    precio_hora DECIMAL(10,2) NOT NULL,
    total_horas VARCHAR(10) NOT NULL,
    monto_pagar DECIMAL(10,2) AS ((precio_hora * total_horas)) STORED NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_contabilidad_empleado) REFERENCES contabilidad_empleados(id),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id)
);

#revisado
CREATE TABLE bonificaciones_empleados(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 3,
    id_contabilidad_empleado INT,
    id_empleado INT,
    monto_bonificacion DECIMAL(10,2) NOT NULL,
    justificacion_bono VARCHAR(100)NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_contabilidad_empleado) REFERENCES contabilidad_empleados(id),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id)
);

#revisado
CREATE TABLE historicos_contratos_empleados(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 4,
    id_contrato_empleado INT,
	id_contabilidad_empleados INT,
    modificaciones_contrato VARCHAR(250) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_contrato_empleado) REFERENCES contratos_empleados(id),
	FOREIGN KEY (id_contabilidad_empleados) REFERENCES contabilidad_empleados(id)
);

#revisado
CREATE TABLE historicos_salario_base(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_contabilidad_empleados INT,
    id_empleado INT,
    periodo_pago VARCHAR(10) NOT NULL,
    nuevo_salario DECIMAL(10,2) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_contabilidad_empleados) REFERENCES contabilidad_empleados(id),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id)
);

#revisado
CREATE TABLE sucursales_virtuales(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    titulo_sucursal VARCHAR(100) NOT NULL,
    descripcion_sucursal VARCHAR(250) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id)
);

#revisado
CREATE TABLE bodega_shopper(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_sucursal_virtual INT,
    id_categoria INT,
    imagen_referencia_producto BLOB NOT NULL,
    PLU_producto VARCHAR(100) NOT NULL UNIQUE,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion_producto VARCHAR(250) NOT NULL,
    cantidad_stock_producto VARCHAR(50) NOT NULL,
    unidad_medida_producto VARCHAR(100) NOT NULL,
    cantidad_producto VARCHAR(100) NOT NULL,
    marca_producto VARCHAR(100) NOT NULL,
    color_producto VARCHAR(50) NOT NULL,
    talla_producto VARCHAR(5) NOT NULL,
    material_producto VARCHAR(30) NOT NULL,
    estilo_producto ENUM("Formal","Ocasion","Deportivo","Oversize","Skinny","Playero","Invierno","Verano","Estudiantil","juvenil","Medico","Pijama"),
    garantia_producto VARCHAR(20) DEFAULT "No aplica",
    precio_neto_producto DECIMAL(10,2) NOT NULL,
    iva_producto VARCHAR(5) NOT NULL,
    descuento_producto DECIMAL(10,2) NOT NULL,
    precio_final DECIMAL(10,2) AS((precio_neto_producto - descuento_producto)*(1+(iva_producto / 100 ))) STORED NOT NULL,
    proveedor_producto VARCHAR(100) NOT NULL,
    lote_producto VARCHAR(50) NOT NULL,
    fecha_vencimiento DATE DEFAULT "2999-12-31",
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_sucursal_virtual) REFERENCES sucursales_virtuales(id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

#revisado
CREATE TABLE bodega_essentials(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_sucursal_virtual INT,
    id_categoria INT,
    id_receta_producto INT,
    imagen_referencia_producto BLOB NOT NULL,
    PLU_producto VARCHAR(100) NOT NULL UNIQUE,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion_producto VARCHAR(250) NOT NULL,
    cantidad_stock_producto VARCHAR(50) NOT NULL,
    unidad_medida_producto VARCHAR(100) NOT NULL,
    cantidad_producto VARCHAR(100) NOT NULL,
    marca_producto VARCHAR(100) NOT NULL,
    precio_neto_producto DECIMAL(10,2) NOT NULL,
    iva_producto VARCHAR(5) NOT NULL,
    descuento_producto DECIMAL(10,2) NOT NULL,
    precio_final DECIMAL(10,2) AS((precio_neto_producto - descuento_producto)*(1+(iva_producto / 100 ))) STORED NOT NULL,
    proveedor_producto VARCHAR(100) NOT NULL,
    lote_producto VARCHAR(50) NOT NULL,
    registro_sanitario_producto VARCHAR(150) NOT NULL,
    fecha_vencimiento DATE DEFAULT "2999-12-31",
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_sucursal_virtual) REFERENCES sucursales_virtuales(id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

#revisado
CREATE TABLE bodega_smart(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_sucursal_virtual INT,
    id_categoria INT,
    imagen_referencia_producto BLOB NOT NULL,
    PLU_producto VARCHAR(100) NOT NULL UNIQUE,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion_producto VARCHAR(250) NOT NULL,
    cantidad_stock_producto VARCHAR(50) NOT NULL,
    referencia_producto VARCHAR(100) NOT NULL,
    marca_producto VARCHAR(100) NOT NULL,
    compatibilidad_entre_modelos VARCHAR(100) NOT NULL,
    color_producto VARCHAR(50) NOT NULL,
    IMEI_1 VARCHAR(16) DEFAULT "No aplica",
    IMEI_2 VARCHAR(16) DEFAULT "No aplica",
    precio_neto_producto DECIMAL(10,2) NOT NULL,
    iva_producto VARCHAR(5) NOT NULL,
    descuento_producto DECIMAL(10,2) NOT NULL,
    precio_final DECIMAL(10,2) AS((precio_neto_producto - descuento_producto)*(1+(iva_producto / 100 ))) STORED NOT NULL,
    proveedor_producto VARCHAR(100) NOT NULL,
    lote_producto VARCHAR(50) NOT NULL,
    fecha_vencimiento DATE DEFAULT "2999-12-31",
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_sucursal_virtual) REFERENCES sucursales_virtuales(id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

#revisado
CREATE TABLE bodega_guru(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_sucursal_virtual INT,
    id_categoria INT,
    imagen_referencia_producto BLOB NOT NULL,
    PLU_producto VARCHAR(100) NOT NULL UNIQUE,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion_producto VARCHAR(250) NOT NULL,
    cantidad_stock_producto VARCHAR(50) NOT NULL,
    unidad_medida_producto VARCHAR(100) NOT NULL,
    cantidad_producto VARCHAR(100) NOT NULL,
    marca_producto VARCHAR(100) NOT NULL,
    precio_neto_producto DECIMAL(10,2) NOT NULL,
    iva_producto VARCHAR(5) NOT NULL,
    descuento_producto DECIMAL(10,2) NOT NULL,
    precio_final DECIMAL(10,2) AS((precio_neto_producto - descuento_producto)*(1+(iva_producto / 100 ))) STORED NOT NULL,
    proveedor_producto VARCHAR(100) NOT NULL,
    lote_producto VARCHAR(50) NOT NULL,
    registro_sanitario_producto VARCHAR(100) NOT NULL,
    fecha_vencimiento DATE DEFAULT "2999-12-31",
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_sucursal_virtual) REFERENCES sucursales_virtuales(id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
    
);

#revisado
CREATE TABLE bodega_machine(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_sucursal_virtual INT,
    id_categoria INT,
    imagen_referencia_producto BLOB NOT NULL,
    PLU_producto VARCHAR(100) NOT NULL UNIQUE,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion_producto VARCHAR(250) NOT NULL,
    cantidad_stock_producto VARCHAR(50) NOT NULL,
    unidad_medida_producto VARCHAR(100) NOT NULL,
    cantidad_producto VARCHAR(100) NOT NULL,
    referencia_producto VARCHAR(100) NOT NULL,
    modelo_producto VARCHAR(100) NOT NULL,
    marca_producto VARCHAR(100) NOT NULL,
    compatibilidad_entre_modelos VARCHAR(100) NOT NULL,
    precio_neto_producto DECIMAL(10,2) NOT NULL,
    iva_producto VARCHAR(5) NOT NULL,
    descuento_producto DECIMAL(10,2) NOT NULL,
    precio_final DECIMAL(10,2) AS((precio_neto_producto - descuento_producto)*(1+(iva_producto / 100 ))) STORED NOT NULL,
    proveedor_producto VARCHAR(100) NOT NULL,
    lote_producto VARCHAR(50) NOT NULL,
    fecha_vencimiento DATE DEFAULT "2999-12-31",
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_sucursal_virtual) REFERENCES sucursales_virtuales(id),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

#revisado
CREATE TABLE pedidos_proveedores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_proveedor INT NOT NULL,
    producto_pedido VARCHAR(250) NOT NULL,
    cantidad_pedida INT NOT NULL, -- Cambiado a tipo numérico
    monto_total_pagar DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    fecha_llegada_pedido DATE NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id)
);

#revisado
CREATE TABLE detalle_overviews(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_overviews INT,
    total_productos_vendidos VARCHAR(100) NOT NULL DEFAULT "0",
    total_ganancias DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id)
);

#revisado
CREATE TABLE overviews_ventas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_local_conectado INT,
    id_empleado INT,
    fecha_venta DATE NOT NULL,
    total_venta DECIMAL(10,2) NOT NULL,
    total_producto_vendidos VARCHAR(50) NOT NULL,
    total_ganancias DECIMAL(10,2) NOT NULL,
    total_trasacciones VARCHAR(100) NOT NULL DEFAULT "0",
    pagos_efectivo VARCHAR(100) NOT NULL DEFAULT "0",
    pagos_nequi VARCHAR(100) NOT NULL DEFAULT "0",
    pagos_daviplata VARCHAR(100) NOT NULL DEFAULT "0",
    pagos_tarjeta VARCHAR(100) NOT NULL DEFAULT "0",
    pagos_otros_medios_pago VARCHAR(100) NOT NULL DEFAULT "0",
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id)
);

CREATE TABLE detalles_ventas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 4,
    metodo_pago VARCHAR(100) NOT NULL,
    monto_pagar DECIMAL(10,2) NOT NULL,
    dinero_recibido DECIMAL(10,2) NOT NULL,
    dinero_devolver DECIMAL(10,2) AS((monto_pagar - dinero_recibido)) STORED NOT NULL,
    comentario_orden VARCHAR(100) NOT NULL,
    productos_vendidos VARCHAR(250) NOT NULL,
     fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (id_estado) REFERENCES estados(id)
);

#revisado
CREATE TABLE gastos_local (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_local_conectado INT,
    tipo_gasto ENUM("Imprevisto", "Fijo", "Variable") NOT NULL,
    monto_gasto DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    justificacion_gasto VARCHAR(250) NOT NULL,
    descripcion_gasto VARCHAR(250) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (id_estado) REFERENCES estados(id)
);

#revisado
CREATE TABLE firmas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_empleado INT,
    id_cliente INT,
    imagen_firma BLOB NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

CREATE TABLE facturaciones_electronicas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 4,
    id_medios_pago INT,
    id_tipo_documento INT,
    numero_factura VARCHAR(250) NOT NULL,
    empleado_factura VARCHAR(100) NOT NULL,
    nombres_cliente VARCHAR(100) NOT NULL,
    apellidos_cliente VARCHAR(100) NOT NULL,
    numero_documento_cliente VARCHAR(30) NOT NULL,
    direccion_cliente VARCHAR(250) NOT NULL,
    email_cliente VARCHAR(100) NOT NULL,
    regimen_cliente ENUM("Comun","Simplificado","Especial", "No aplica"),
    PLU_item VARCHAR(100) NOT NULL,
    item VARCHAR(250) NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    cantidad_llevada VARCHAR(100) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    total_compra DECIMAL(10,2) NOT NULL,
    cantidad_items VARCHAR(50) NOT NULL,
    comentario_compra VARCHAR(250) NOT NULL,
    cufe VARCHAR(250) NOT NULL,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_medios_pago) REFERENCES medios_pago(id),
    FOREIGN KEY (id_tipo_documento) REFERENCES tipo_documentos(id)
);

CREATE TABLE detalles_facturacion_electronica(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 4,
    id_medio_pago INT,
    id_tipo_documento INT,
    id_factura_electronica INT,
    numero_factura VARCHAR(250) NOT NULL,
    empleado_factura VARCHAR(100) NOT NULL,
    nombres_cliente VARCHAR(100) NOT NULL,
    apellidos_cliente VARCHAR(100) NOT NULL,
    numero_documento_cliente VARCHAR(30) NOT NULL,
    direccion_cliente VARCHAR(250) NOT NULL,
    email_cliente VARCHAR(100) NOT NULL,
    regimen_cliente ENUM("Comun","Simplificado","Especial", "No aplica"),
    PLU_item VARCHAR(100) NOT NULL,
    item VARCHAR(250) NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    cantidad_llevada VARCHAR(100) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    total_compra DECIMAL(10,2) NOT NULL,
    cantidad_items VARCHAR(50) NOT NULL,
    comentario_compra VARCHAR(250) NOT NULL,
    cufe VARCHAR(250) NOT NULL,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_medio_pago) REFERENCES medios_pago(id),
    FOREIGN KEY (id_tipo_documento) REFERENCES tipo_documentos(id),
    FOREIGN KEY (id_factura_electronica) REFERENCES facturaciones_electronicas(id)
);

CREATE TABLE facturaciones_fisicas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 4,
    id_medios_pago INT,
    numero_factura VARCHAR(250) NOT NULL,
    empleado_factura VARCHAR(100) NOT NULL,
    cliente VARCHAR(100) DEFAULT "COSUMIDOR FINAL",
    numero_documento VARCHAR(30) DEFAULT "9999999999",
    PLU_item VARCHAR(100) NOT NULL,
    item VARCHAR(250) NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    cantidad_llevada VARCHAR(100) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    total_compra DECIMAL(10,2) NOT NULL,
    cantidad_items VARCHAR(50) NOT NULL,
    comentario_compra VARCHAR(250) NOT NULL,
    cufe VARCHAR(250) NOT NULL,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_medios_pago) REFERENCES medios_pago(id)
);

CREATE TABLE detalles_facturacion_fisica(
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_factura_fisica INT,
    id_estado INT DEFAULT 4,
    id_medio_pago INT,
    numero_factura VARCHAR(250) NOT NULL,
    empleado_factura VARCHAR(100) NOT NULL,
    cliente VARCHAR(100) DEFAULT "COSUMIDOR FINAL",
    numero_documento VARCHAR(30) DEFAULT "9999999999",
    PLU_item VARCHAR(100) NOT NULL,
    item VARCHAR(250) NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    cantidad_llevada VARCHAR(100) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    total_compra DECIMAL(10,2) NOT NULL,
    cantidad_items VARCHAR(50) NOT NULL,
    comentario_compra VARCHAR(250) NOT NULL,
    cufe VARCHAR(250) NOT NULL,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_medio_pago) REFERENCES medios_pago(id),
    FOREIGN KEY (id_factura_fisica) REFERENCES facturaciones_fisicas(id)
);

CREATE TABLE reservas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_servicio INT,
    id_cliente INT,
    fecha_reserva DATE NOT NULL,
    hora_reserva TIME NOT NULL,
    titulo_reserva VARCHAR(100) NOT NULL,
    descripcion_reserva VARCHAR(250) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_servicio) REFERENCES servicios_universales(id),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

CREATE TABLE qrs(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    imagen_qr BLOB NOT NULL,
	titulo_qr VARCHAR(50) NOT NULL,
    descripcion_qr VARCHAR(250) NOT NULL,
    uso_qr VARCHAR(100) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id)
);

CREATE TABLE etiquetados(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    titulo_etiqueta VARCHAR(50) NOT NULL,
    descripcion_etiqueta VARCHAR(250) NOT NULL,
    uso_etiqueta VARCHAR(100) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id)
);

CREATE TABLE cotizaciones(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 5,
    id_medio_pago INT,
    numero_factura VARCHAR(250) NOT NULL,
    empleado_factura VARCHAR(100) NOT NULL,
    cliente VARCHAR(100) DEFAULT "COSUMIDOR FINAL",
    numero_documento VARCHAR(30) DEFAULT "9999999999",
    PLU_item VARCHAR(100) NOT NULL,
    item VARCHAR(250) NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    cantidad_llevada VARCHAR(100) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    total_compra DECIMAL(10,2) NOT NULL,
    cantidad_items VARCHAR(50) NOT NULL,
    comentario_compra VARCHAR(250) NOT NULL,
    cufe VARCHAR(250) NOT NULL,
	fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_medio_pago) REFERENCES medios_pago(id)
);

CREATE TABLE movimientos_app(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_tienda_sitematizada INT,
    id_local_conectado INT,
    tipo_movimiento ENUM("Eliminacion","Creacion","Actualizacion","Venta","Devolucion","Inicio Sesion") NOT NULL,
    descripcion VARCHAR(250) NOT NULL,
    ip_usuario VARCHAR(250) NOT NULL,
    dispositivo VARCHAR(100) NOT NULL,
    sistema_operativo VARCHAR(100) NOT NULL,
    navegador VARCHAR(50) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
	FOREIGN KEY (id_tienda_sitematizada) REFERENCES tiendas_sitematizadas(id)
);

CREATE TABLE local_conectado (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_estado INT DEFAULT 1,
    id_tienda_sitematizada INT NOT NULL,
    id_empleados INT NOT NULL,
    id_proveedores INT NOT NULL,
    id_producto_universales INT NOT NULL,
    id_servicios_universales INT NOT NULL,
    id_encuestas INT NOT NULL,
    id_contabilidad_empleados INT NOT NULL,
    id_sucursal_virtuales INT NOT NULL,
    id_facturacion_fisica INT NOT NULL,
    id_facturacion_electronica INT NOT NULL,
    id_reservas INT NOT NULL,
    id_etiquetas INT NOT NULL,
    id_qr INT NOT NULL,
    id_cotizaciones INT NOT NULL,
    telefono VARCHAR(15) NOT NULL UNIQUE,
    direccion VARCHAR(50) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (id_estado) REFERENCES estados(id),
    FOREIGN KEY (id_tienda_sitematizada) REFERENCES tiendas_sitematizadas(id),
    FOREIGN KEY (id_empleados) REFERENCES empleados(id),
    FOREIGN KEY (id_proveedores) REFERENCES proveedores(id),
    FOREIGN KEY (id_producto_universales) REFERENCES productos_universales(id),
    FOREIGN KEY (id_servicios_universales) REFERENCES servicios_universales(id),
    FOREIGN KEY (id_encuestas) REFERENCES encuestas(id),
    FOREIGN KEY (id_contabilidad_empleados) REFERENCES contabilidad_empleados(id),
    FOREIGN KEY (id_sucursal_virtuales) REFERENCES sucursales_virtuales(id),
    FOREIGN KEY (id_facturacion_fisica) REFERENCES facturaciones_fisicas(id),
    FOREIGN KEY (id_facturacion_electronica) REFERENCES facturaciones_electronicas(id),
    FOREIGN KEY (id_reservas) REFERENCES reservas(id),
    FOREIGN KEY (id_etiquetas) REFERENCES etiquetados(id),
    FOREIGN KEY (id_qr) REFERENCES qrs(id),
    FOREIGN KEY (id_cotizaciones) REFERENCES cotizaciones(id)
);