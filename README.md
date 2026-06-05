# SECOP Big Data 2025

## Integrantes

- Luis Miguel López Pérez
- Diana Katherine Huertas Baquero
- Sergio Andrés Sánchez Cardenas

---

## Descripción del proyecto

Este proyecto implementa una arquitectura de datos orientada al análisis de información pública de contratación estatal proveniente del SECOP para el periodo 2025-2026. El proceso fue desarrollado bajo un enfoque progresivo, iniciando con pruebas de ingesta en lotes pequeños y escalando posteriormente hacia procesos de limpieza, integración, análisis textual, priorización contractual, modelado NoSQL en MongoDB y visualización mediante dashboard.

La solución utiliza **Databricks Free Edition**, **Apache Spark**, **MongoDB Atlas**, **MongoDB Charts** y **GitHub** como herramientas principales para procesamiento distribuido, almacenamiento documental, visualización y control de versiones.

---

## Objetivo general

Construir una canalización de datos escalable, documentada y reproducible para obtener, procesar, integrar, analizar y visualizar información pública de contratación estatal del SECOP durante el periodo 2025-2026.

---

## Objetivos específicos

- Diseñar una arquitectura de datos por capas.
- Implementar ingesta de datos desde fuentes abiertas del SECOP.
- Almacenar datos crudos, estructurados, limpios y analíticos.
- Aplicar procesos de limpieza, normalización e integración de datos.
- Crear variables de análisis textual como `texto_busqueda` y `temas_detectados`.
- Diseñar un índice descriptivo de prioridad contractual.
- Construir un modelo documental NoSQL en MongoDB.
- Crear un dashboard operativo con indicadores, rankings, temas y alertas.
- Documentar decisiones de arquitectura, limitaciones y pasos de reproducción.

---

## Arquitectura del proyecto

El proyecto se organiza bajo una arquitectura tipo **Lakehouse**, complementada con una capa documental NoSQL y una capa de visualización.

```text
Fuentes públicas SECOP
        ↓
Databricks / Spark
        ↓
Layer 0 - Raw JSONL / CSV
        ↓
Parquet / Bronze
        ↓
Silver - Limpieza y estandarización
        ↓
Gold - Integración y analítica
        ↓
MongoDB Atlas - Modelo NoSQL documental
        ↓
MongoDB Charts - Dashboard operativo
```

---

## Estructura del repositorio

```text
secop-bigdata-2025/
│
├── config/
│   ├── project_settings.json
│   └── sources_2025.json
│
├── data/
│   └── README.md
│
├── docs/
│   └── evidencias/
│
├── notebooks/
│   ├── 01_layer0_ingestion_builder.ipynb
│   ├── 02_SECOP_2025_Silver_Cleaning_FIXED.ipynb
│   ├── 02B_SECOP_2025_Validacion_Limpieza_Integracion.ipynb
│   ├── 03_SECOP_2025_Texto_No_Estructurado_Temas.ipynb
│   ├── 04_SECOP_2025_Indice_Prioridad.ipynb
│   └── 05_SECOP_2025_Modelo_NoSQL_MongoDB_FREE_TIER.ipynb
│
├── outputs/
│   └── manifest/
│
├── src/
│
├── tests/
│
├── README.md
├── requirements.txt
└── .gitignore
```

---

## Fuentes de datos utilizadas

Las fuentes principales utilizadas corresponden a conjuntos de datos abiertos publicados en datos.gov.co.

| Fuente | Descripción | Uso dentro del proyecto |
|---|---|---|
| SECOP II Contratos | Información principal de contratos públicos | Base contractual principal |
| SECOP II Adiciones | Información de adiciones o modificaciones contractuales | Cálculo de número y valor de adiciones |
| SECOP II Ejecución | Información de avance y ejecución contractual | Análisis de avance contractual |
| DIVIPOLA Municipios | Catálogo territorial de municipios y departamentos | Normalización territorial |

---

## Fecha y hora de descarga

La descarga y procesamiento de datos se realizó bajo una ventana dinámica de análisis.

```text
Fecha inicial del análisis: 2025-01-01
Fecha final de corte: fecha efectiva de descarga del pipeline
Run ID principal: 20260603T031107Z
Periodo procesado: from_2025_01_01_to_2026-06-02
```

> Nota: la fecha final puede variar si el pipeline se ejecuta nuevamente, ya que el proceso toma como referencia la fecha efectiva de descarga.

---

## Número de registros usados

Durante el proceso se trabajó con diferentes volúmenes de datos según la etapa del pipeline.

| Etapa / tabla | Registros aproximados |
|---|---:|
| Contratos usados en dashboard MongoDB | 50,000 |
| Contratos con prioridad alta | 3,315 |
| Contratos con adiciones | 26,733 |
| SECOP II adiciones procesadas en Silver | 50,000 |
| SECOP II ejecución procesada en Silver | 1,058,461 |
| Tabla de temas / contratos analizados | 157,975 |

> Los valores pueden variar según la fecha de ejecución, límites aplicados y disponibilidad de datos en la fuente pública.

---

## Actividades desarrolladas

### Actividad 1. Ingesta Layer 0

Se implementó la descarga de datos desde las APIs públicas, guardando la información en formato crudo dentro de Databricks Volumes.

Salidas principales:

```text
raw_jsonl/
raw_csv/
parquet/
manifest/
logs/
```

---

### Actividad 2. Limpieza, validación e integración

Se aplicaron procesos de limpieza y estandarización sobre contratos, adiciones, ejecución contractual y datos territoriales.

Procesos realizados:

- Conversión de fechas.
- Conversión de valores numéricos.
- Normalización de texto.
- Perfilamiento de nulos.
- Integración de adiciones por contrato.
- Integración de avance de ejecución.
- Cruce territorial con DIVIPOLA.
- Generación de tabla Gold integrada.

Tablas principales:

```text
workspace.default.gold_secop_contratos_integrados
workspace.default.qa_resumen_fechas
workspace.default.qa_resumen_valores
workspace.default.qa_resumen_textos
workspace.default.qa_resumen_nulos
workspace.default.qa_registros_sin_cruce_territorial
```

---

### Actividad 3. Texto no estructurado

Se construyeron variables de análisis textual:

```text
texto_busqueda
temas_detectados
```

La variable `texto_busqueda` consolida campos descriptivos del contrato, entidad, proveedor, modalidad, objeto contractual y demás textos disponibles. Posteriormente, mediante reglas de palabras clave, se detectaron temas contractuales.

Temas considerados:

```text
infraestructura_obras
salud
educacion
tecnologia_software
alimentacion
transporte
ambiente
seguridad_vigilancia
servicios_profesionales
mantenimiento
aseo_limpieza
cultura_deporte
suministros_compras
interventoria_supervision
juridico_administrativo
sin_tema_detectado
```

Tablas generadas:

```text
workspace.default.gold_secop_contratos_temas
workspace.default.gold_resumen_contratos_por_tema
workspace.default.qa_reglas_temas_detectados
workspace.default.qa_texto_busqueda_calidad
```

---

### Actividad 4. Índice descriptivo de prioridad

Se diseñó un índice descriptivo de prioridad contractual sobre una escala de 0 a 100 puntos.

El índice considera:

- Valor contractual alto.
- Número de adiciones.
- Avance bajo.
- Modalidad contractual.
- Tema detectado.
- Texto insuficiente o ambiguo.

Fórmula general:

```text
indice_prioridad =
    score_valor_alto
  + score_adiciones
  + score_avance_bajo
  + score_modalidad
  + score_tema
  + score_texto
```

Clasificación:

| Nivel | Rango |
|---|---|
| Baja | menor a 40 |
| Media | entre 40 y 69.99 |
| Alta | mayor o igual a 70 |

Tablas generadas:

```text
workspace.default.gold_secop_indice_prioridad_contratos
workspace.default.gold_secop_ranking_prioridad
workspace.default.gold_secop_resumen_prioridad
workspace.default.qa_formula_indice_prioridad
```

> El índice es descriptivo y no representa por sí mismo evidencia de irregularidad contractual.

---

### Actividad 5. Modelo NoSQL en MongoDB

Se creó un modelo documental en MongoDB Atlas a partir de las tablas Gold generadas en Databricks.

Colecciones creadas:

```text
contratos_operativos
alertas_revision
entidades_resumen
proveedores_resumen
temas_resumen
metadata_pipeline
```

La colección principal `contratos_operativos` almacena documentos anidados con la siguiente estructura:

```json
{
  "contrato": {},
  "entidad": {},
  "proveedor": {},
  "territorio": {},
  "analitica": {},
  "adiciones": {},
  "ejecucion": {},
  "metadata": {}
}
```

También se crearon índices para mejorar consultas por:

- Nivel de prioridad.
- Índice de prioridad.
- Entidad.
- Proveedor.
- Tema detectado.
- Texto de búsqueda.

Debido al límite de almacenamiento de MongoDB Atlas Free Tier, se implementó una versión optimizada con reducción de datos y recorte de campos largos.

---

### Actividad 6. Dashboard

Se construyó un dashboard operativo en MongoDB Charts con los siguientes elementos:

- Total de contratos cargados.
- Valor total contratado.
- Contratos con prioridad alta.
- Contratos con adiciones.
- Ranking de entidades.
- Ranking de proveedores.
- Contratos por tema detectado.
- Distribución por nivel de prioridad.
- Tabla de alertas de revisión.
- Evidencia de actualización del pipeline.

Título del dashboard:

```text
SECOP 2025 - Dashboard operativo de priorización contractual
```

El dashboard permite observar de forma ejecutiva los resultados del modelo documental y la priorización analítica de contratos.

---

## Instrucciones para reproducir el proyecto

### 1. Clonar el repositorio

```bash
git clone https://github.com/Guesseppe100/secop-bigdata-2025.git
cd secop-bigdata-2025
```

---

### 2. Abrir el proyecto en Databricks

Importar o sincronizar el repositorio en Databricks:

```text
Workspace → Users → usuario → secop-bigdata-2025
```

---

### 3. Verificar configuración

Revisar los archivos:

```text
config/project_settings.json
config/sources_2025.json
```

Estos archivos contienen parámetros generales del proyecto y fuentes utilizadas.

---

### 4. Ejecutar notebooks en orden

El orden recomendado de ejecución es:

```text
01_layer0_ingestion_builder.ipynb
02_SECOP_2025_Silver_Cleaning_FIXED.ipynb
02B_SECOP_2025_Validacion_Limpieza_Integracion.ipynb
03_SECOP_2025_Texto_No_Estructurado_Temas.ipynb
04_SECOP_2025_Indice_Prioridad.ipynb
05_SECOP_2025_Modelo_NoSQL_MongoDB_FREE_TIER.ipynb
```

---

### 5. Configurar MongoDB Atlas

Crear un cluster en MongoDB Atlas y una base de datos llamada:

```text
secop_bigdata_2025
```

Configurar la URI de conexión en Databricks mediante widget, variable de entorno o secret.

No se debe guardar la URI directamente en GitHub.

---

### 6. Ejecutar carga a MongoDB

Ejecutar el notebook:

```text
05_SECOP_2025_Modelo_NoSQL_MongoDB_FREE_TIER.ipynb
```

Este notebook crea las colecciones documentales, índices, consultas, agregaciones y evidencia de actualización.

---

### 7. Construir dashboard en MongoDB Charts

Crear un dashboard en MongoDB Charts usando las colecciones:

```text
contratos_operativos
alertas_revision
entidades_resumen
proveedores_resumen
temas_resumen
metadata_pipeline
```

---

## Variables de entorno necesarias

Para ejecutar el proyecto se requiere configurar la conexión a MongoDB Atlas.

| Variable | Descripción |
|---|---|
| `MONGODB_URI` | URI de conexión a MongoDB Atlas |

Ejemplo de formato:

```text
mongodb+srv://usuario:password@cluster.mongodb.net/?appName=Cluster
```

> Esta variable contiene credenciales sensibles y no debe guardarse en archivos versionados.

---

## Decisiones de arquitectura

### Uso de Databricks y Spark

Se eligió Databricks con Apache Spark porque permite procesar grandes volúmenes de datos de manera distribuida, aplicar transformaciones escalables y organizar el pipeline por capas.

### Arquitectura por capas

Se utilizó una arquitectura tipo Lakehouse porque permite separar datos crudos, datos estructurados, datos limpios y datos analíticos.

### Uso de Parquet y Delta

Parquet se utilizó como formato eficiente de almacenamiento columnar. Delta se utilizó para crear tablas analíticas consultables desde Databricks.

### Uso de MongoDB

MongoDB se utilizó como capa documental operativa, permitiendo almacenar contratos como documentos anidados y facilitar consultas, agregaciones y visualizaciones.

### Uso de MongoDB Charts

MongoDB Charts se utilizó para construir un dashboard directamente sobre las colecciones NoSQL, evitando mover nuevamente los datos a otra herramienta de visualización.

### Reducción de datos para Free Tier

Debido al límite de almacenamiento de MongoDB Atlas Free Tier, se cargó una muestra priorizada y optimizada para demostrar el modelo sin superar la cuota disponible.

---

## Limitaciones encontradas

- Las APIs públicas pueden presentar cambios de disponibilidad, estructura o volumen.
- El procesamiento depende de los límites de Databricks Free Edition.
- MongoDB Atlas Free Tier tiene restricciones de almacenamiento.
- La detección de temas se basa en reglas de palabras clave, por lo que puede generar falsos positivos o falsos negativos.
- El índice de prioridad es descriptivo y no constituye evidencia de irregularidad contractual.
- Por espacio en MongoDB, se tuvo que ajustar al tamaño del archivo para poder realizar este proyecto (50000 datos)
- Algunos campos pueden estar incompletos o presentar inconsistencias desde la fuente original.
- El dashboard depende de la correcta actualización de las colecciones en MongoDB.
- La carga completa del universo de datos puede requerir un cluster de mayor capacidad.

---

## Evidencias generadas

El proyecto genera evidencias en las siguientes etapas:

```text
manifest/
logs/
tablas QA
metadata_pipeline
dashboard MongoDB Charts
capturas antes/después de actualización
```

La colección `metadata_pipeline` permite evidenciar ejecuciones del pipeline mediante:

```text
run_id
fecha de ejecución
estado
conteos por colección
```

---

## Conclusión

El proyecto implementa una arquitectura de datos completa para el análisis de contratación pública del SECOP 2025. La solución integra ingesta, limpieza, procesamiento distribuido, análisis textual, priorización contractual, modelado NoSQL y visualización operativa. El resultado final permite consultar indicadores generales, rankings, temas detectados, alertas y evidencia de actualización, manteniendo una estructura reproducible y documentada.
